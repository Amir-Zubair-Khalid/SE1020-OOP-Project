package model;

public class Admin extends User {

    public Admin(int userId, String username, String email, String password, String phone, String licenseNumber) {
        super(userId, username, email, password, phone, licenseNumber);
    }

    @Override
    public String getRole() {
        return "ADMIN";
    }

    @Override
    public double getDiscountRate() {
        return 0.0;
    }

    @Override
    public double getLateFeePerDay() {
        return 0.0;
    }

    @Override
    public boolean isAdmin() {
        return true;
    }
}
