package model;

public class RegularUser extends User {

    public RegularUser(int userId, String username, String email, String password, String phone, String licenseNumber) {
        super(userId, username, email, password, phone, licenseNumber);
    }

    @Override
    public String getRole() {
        return "REGULAR";
    }

    @Override
    public double getDiscountRate() {
        return 0.0;
    }

    @Override
    public double getLateFeePerDay() {
        return 1000.0;
    }
}
