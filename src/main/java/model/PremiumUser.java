package model;

public class PremiumUser extends User {

    public PremiumUser(int userId, String username, String email, String password, String phone, String licenseNumber) {
        super(userId, username, email, password, phone, licenseNumber);
    }

    @Override
    public String getRole() {
        return "PREMIUM";
    }

    @Override
    public double getDiscountRate() {
        return 0.10;
    }

    @Override
    public double getLateFeePerDay() {
        return 500.0;
    }
}
