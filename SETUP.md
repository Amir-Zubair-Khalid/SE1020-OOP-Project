# DriveEasy - Vehicle Rental System

Java Servlets + JSP + MySQL web app (SLIIT group project).
Customers browse and book cars, vans, bikes and luxury vehicles, admins process returns, and invoices are paid by cash, card or online.

## Run it on Windows

You need 4 things installed. Use these exact versions where it says so.

| What | Version | Download |
|---|---|---|
| Java JDK | 17 or 21 (LTS) | https://adoptium.net (Temurin, Windows x64 .msi) |
| IntelliJ IDEA | Community or Ultimate | https://www.jetbrains.com/idea/download/?section=windows |
| Apache Tomcat | **9.0.x** (not 10 or 11) | https://tomcat.apache.org/download-90.cgi (64-bit Windows zip) |
| MySQL | Community Server + Workbench | https://dev.mysql.com/downloads/installer/ |

> Tomcat must be version **9**. This project uses `javax.servlet`, and Tomcat 10+ only supports `jakarta.servlet`, so it will not work there.

### 1. Install Java
Run the Temurin `.msi`. On the "Custom Setup" screen, turn on **Set JAVA_HOME variable**.

### 2. Install Tomcat 9
Unzip it somewhere simple, e.g. `C:\tomcat\apache-tomcat-9.0.xx`. Don't run `startup.bat`: IntelliJ starts Tomcat for you.

### 3. Install MySQL and load the database
1. Run the MySQL Installer and choose **Server only** plus **MySQL Workbench** (or "Developer Default").
2. When asked, set a **root password** and write it down. Keep the default port **3306**.
3. Open **MySQL Workbench**, click the **Local instance MySQL** connection and enter the password.
4. **File > Open SQL Script** > choose `database/database.sql` from this project > click the lightning bolt to run it.
5. Refresh the **SCHEMAS** panel. You should see `vehicle_rental` with 4 tables.

### 4. Open the project in IntelliJ
1. **File > Open** > select this project folder (the one with `pom.xml`) > **Trust Project**.
2. Wait for Maven to finish downloading dependencies (progress bar at the bottom right).
3. If asked for a JDK: **File > Project Structure > SDK** > choose the JDK from step 1.

### 5. Set your MySQL password
Open `src/main/java/dao/DBConnection.java` and put **your** MySQL root password on this line:
```java
private static final String PASSWORD = "your-mysql-password";
```

### 6. Set up Tomcat in IntelliJ (Smart Tomcat plugin)
1. **File > Settings > Plugins** > Marketplace > search **Smart Tomcat** > Install > restart IntelliJ.
2. **Run > Edit Configurations** > **+** > **Smart Tomcat**, and fill in:
   - **Tomcat server:** click Configure and pick the Tomcat 9 folder from step 2
   - **Deployment directory:** `src/main/webapp` (inside this project)
   - **Context path:** `/vehicle-rental`
   - **Server port:** `8080`
3. Click **OK**, then the green Run button.

*(IntelliJ Ultimate users can use the built-in "Tomcat Server > Local" configuration instead, deploying the `vehicle-rental:war exploded` artifact with context `/vehicle-rental`.)*

### 7. Open the site
Go to **http://localhost:8080/vehicle-rental**

| Account | Username | Password |
|---|---|---|
| Admin | `admin` | `admin123` |
| Regular customer | `nimal` | `nimal123` |
| Premium customer (can book luxury cars) | `kamal` | `kamal123` |

## Troubleshooting

| Problem | Fix |
|---|---|
| "Wrong username or password" for every account | The app can't reach MySQL. Open **http://localhost:8080/vehicle-rental/dbcheck.jsp**, which shows the exact problem. Usually the password in `DBConnection.java` is wrong, or `database.sql` wasn't run. |
| `Address already in use` / port 8080 | Something else is using port 8080. Change the port in the Smart Tomcat config to `8081` and use http://localhost:8081/vehicle-rental |
| `Communications link failure` | MySQL isn't running. Open the Windows **Services** app, find **MySQL**, click **Start**. |
| Pages show `ClassNotFoundException: javax.servlet...` | You're on Tomcat 10 or 11. Use Tomcat **9**. |
| Pages look unstyled | Hard-refresh the browser with **Ctrl + F5**. |

## Project structure
```
src/main/java/model     Classes (User, Vehicle, Booking, Payment, Invoice and subclasses)
src/main/java/dao       Database access (JDBC)
src/main/java/servlet   Controllers (one servlet per module)
src/main/java/util      Session, request and password helpers
src/main/webapp         JSP pages, CSS, vehicle photos
database/database.sql   Tables and sample data
```

Vehicle photos are from Wikimedia Commons; see `src/main/webapp/images/vehicles/credits.html` for authors and licences.
