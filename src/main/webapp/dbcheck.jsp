<%@ page contentType="text/html;charset=UTF-8" import="java.sql.*,dao.DBConnection" %>
<%-- Temporary page to test the MySQL connection. Delete this file when login works. --%>
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>Database check</title>
<style>body{font-family:system-ui,sans-serif;max-width:720px;margin:40px auto;padding:0 16px;line-height:1.5}
.ok{background:#e2f5ea;color:#16794a;padding:14px 18px;border-radius:10px}.bad{background:#fce5e7;color:#b42531;padding:14px 18px;border-radius:10px}
code{background:#f1f3f7;padding:2px 6px;border-radius:4px}table{border-collapse:collapse;margin-top:12px}td,th{border:1px solid #ddd;padding:6px 12px;text-align:left}</style></head><body>
<h1>Database check</h1>
<%
    try (Connection con = DBConnection.getConnection()) {
        out.println("<div class='ok'><b>Connected to MySQL.</b></div>");
        try (Statement st = con.createStatement(); ResultSet rs = st.executeQuery("SELECT user_id, username, role FROM users ORDER BY user_id")) {
            out.println("<p>Users in the database:</p><table><tr><th>ID</th><th>Username</th><th>Role</th></tr>");
            boolean any = false;
            while (rs.next()) { any = true; out.println("<tr><td>" + rs.getInt(1) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td></tr>"); }
            out.println("</table>");
            if (!any) out.println("<p class='bad'>The users table is empty. Run <code>database/database.sql</code> again.</p>");
            else out.println("<p>If <b>admin</b> is listed, log in with <code>admin</code> / <code>admin123</code>.</p>");
        }
    } catch (Exception e) {
        String msg = String.valueOf(e.getMessage());
        String hint;
        if (msg.contains("Access denied")) hint = "The MySQL password in <code>src/main/java/dao/DBConnection.java</code> (line 13) is wrong for your Mac. Change it to your own MySQL root password and re-run Tomcat.";
        else if (msg.contains("Unknown database")) hint = "The <code>vehicle_rental</code> database doesn't exist yet. Run <code>database/database.sql</code> in MySQL Workbench.";
        else if (msg.contains("Communications link failure") || msg.contains("Connection refused")) hint = "MySQL isn't running. Start it (System Settings &rarr; MySQL &rarr; Start) and refresh this page.";
        else if (msg.contains("driver not found")) hint = "The MySQL driver isn't loaded. In IntelliJ, reload the Maven project (Maven panel &rarr; Reload) and re-run Tomcat.";
        else if (msg.contains("doesn't exist")) hint = "The tables are missing. Run <code>database/database.sql</code> in MySQL Workbench.";
        else hint = "Send this message to Claude.";
        out.println("<div class='bad'><b>Could not use the database.</b><br>" + hint + "</div>");
        out.println("<p>Exact error:</p><p><code>" + msg.replace("<", "&lt;") + "</code></p>");
    }
%>
</body></html>
