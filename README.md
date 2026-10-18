# Vehicle Rental Platform

A web-based vehicle rental system built for the **SE1020 – Object Oriented Programming** group project. Customers can browse and book vehicles, and administrators can manage users, vehicles, bookings and payments. Data is stored in plain text files instead of a database.

## Team

| Member | Component | Branch |
|---|---|---|
| Amir | User Management (Customer Accounts) | `amir-user` |
| Matheesha Kalpana | Vehicle Management | `panda-vehicle` |
| Mario | Booking & Returns | `mario-booking` |
| Mahima | Payment & Billing | `mahima-payment` |
| TBD | Admin Management | `admin-management` |

## Tech Stack

| Purpose | Technology |
|---|---|
| IDE | IntelliJ IDEA |
| Language | Java (JDK 17 or later) |
| Backend | JSP Servlets on Apache Tomcat |
| Build tool | Maven |
| Frontend | HTML, CSS, JavaScript, Bootstrap (via CDN) |
| Data storage | Text files (file read/write) |
| Version control | Git and GitHub |
| Diagrams | draw.io |

## Components

### 1. User Management
- **Create:** register a new customer (`users.txt`)
- **Read:** search a user by username or ID
- **Update:** edit email, password, license details, membership type
- **Delete:** remove a customer account
- **OOP:** `User` (encapsulation), `RegularUser` and `PremiumUser` extend `User` (inheritance), different authentication or discount rules (polymorphism)

### 2. Vehicle Management
- **Create:** add vehicles (type, brand, model, plate number, price per day, availability) to `vehicles.txt`
- **Read:** search by type, brand, price or availability
- **Update:** edit details, price or availability status
- **Delete:** remove retired or sold vehicles
- **OOP:** `Vehicle` (encapsulation), `Car`, `Van` and `Bike` extend `Vehicle` (inheritance), different rental cost calculation per vehicle type (polymorphism)

### 3. Booking & Returns
- **Create:** record a new booking (`bookings.txt`)
- **Read:** view all bookings and due dates
- **Update:** update return status, extend a booking, calculate late fees or damage charges
- **Delete:** cancel a booking or remove completed records
- **OOP:** `Booking` (encapsulation), availability check before booking (abstraction), different fee calculation for regular and premium users (polymorphism)

### 4. Admin Management
- **Create:** register a new admin (`admins.txt`)
- **Read:** view all admins and their activity logs
- **Update:** modify admin permissions or profile
- **Delete:** remove admin accounts
- **OOP:** `Admin` extends `User` (inheritance), admin-only methods hidden from regular users (abstraction)

### 5. Payment & Billing
- **Create:** record a payment (`payments.txt`)
- **Read:** view payment history and invoices, filter by user or date
- **Update:** update payment status (pending, paid, refunded) or apply discounts
- **Delete:** remove failed or duplicate payment records
- **OOP:** `Payment` (encapsulation), `CardPayment`, `CashPayment` and `OnlinePayment` extend `Payment` (inheritance), different processing and fee logic per method (polymorphism)

## Project Structure

```
vehicle-rental-platform/
├── pom.xml
├── README.md
├── data/
│   ├── users.txt
│   ├── vehicles.txt
│   ├── bookings.txt
│   ├── payments.txt
│   └── admins.txt
├── docs/                  # class diagrams, noun-verb analysis
└── src/main/
    ├── java/
    │   ├── model/         # entity classes (User, Vehicle, Booking, ...)
    │   ├── service/       # business logic and CRUD operations
    │   ├── servlet/       # servlets handling requests
    │   └── util/          # shared file handling utilities
    └── webapp/            # JSP pages, CSS, JS
```

## Data Files

All data files use **comma-separated fields in a fixed order**, one record per line. Avoid commas inside field values.

**ID formats**

| Entity | Format |
|---|---|
| User | `U001` |
| Vehicle | `V001` |
| Booking | `B001` |
| Payment | `P001` |
| Admin | `A001` |

**Example: `vehicles.txt`**

```
V001,Car,Toyota,Axio,CAB-1234,8500.00,true
V002,Van,Nissan,Caravan,VAN-5678,12000.00,true
V003,Bike,Honda,CB150,BIK-9012,3000.00,false
```

Fields: `vehicleId, type, brand, model, plateNumber, pricePerDay, available`

## Getting Started

### Prerequisites
- IntelliJ IDEA
- JDK 17 or later
- Apache Tomcat 10.1 (uses the `jakarta.servlet` package)
- Maven
- Git

> Everyone on the team must use the same JDK and Tomcat versions.

### Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/<owner>/<repo-name>.git
   ```
2. Open the project in IntelliJ IDEA and let Maven import the dependencies.
3. Configure a Tomcat run configuration and deploy the project as a web application.
4. Make sure the `data/` folder contains the sample `.txt` files.
5. Run the server and open the application in your browser.

## Git Workflow

- Each member works on their own branch and merges into `main` through a pull request.
- Never commit directly to `main`.
- Commit small and often, with clear messages (for example `Add Vehicle model with getters and setters`).
- Pull before you push:
  ```bash
  git pull origin main
  ```
- Only edit shared files (such as the file-handling utility) after telling the team.

## OOP Concepts Used

- **Encapsulation:** private fields with getters and setters in all model classes.
- **Inheritance:** `RegularUser` and `PremiumUser` extend `User`, `Admin` extends `User`, `Car`, `Van` and `Bike` extend `Vehicle`, and `CardPayment`, `CashPayment` and `OnlinePayment` extend `Payment`.
- **Polymorphism:** overridden methods for rental cost, fees, discounts and payment processing.
- **Abstraction:** availability checks before booking and admin-only operations.

## Deliverables

- [ ] Source code (`.java`, `.jsp`, configuration files)
- [ ] Class diagrams for each component
- [ ] Final report including the Git commit history
- [ ] Sample data files for the demonstration
- [ ] Viva presentation
