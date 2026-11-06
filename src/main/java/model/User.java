package model;

public abstract class User {

    private int userId;
    private String username;
    private String email;
    private String password;
    private String phone;
    private String licenseNumber;

    public User(int userId, String username, String email, String password, String phone, String licenseNumber) {
        this.userId = userId;
        this.username = username;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.licenseNumber = licenseNumber;
    }

    public abstract String getRole();

    public abstract double getDiscountRate();

    public abstract double getLateFeePerDay();

    public boolean isAdmin() {
        return false;
    }

    public static User create(String role, int userId, String username, String email, String password, String phone, String licenseNumber) {
        if (role.equals("ADMIN")) {
            return new Admin(userId, username, email, password, phone, licenseNumber);
        } else if (role.equals("PREMIUM")) {
            return new PremiumUser(userId, username, email, password, phone, licenseNumber);
        } else {
            return new RegularUser(userId, username, email, password, phone, licenseNumber);
        }
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }
}
