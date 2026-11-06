package model;

public class Invoice {

    private Booking booking;
    private Vehicle vehicle;
    private User customer;

    public Invoice(Booking booking, Vehicle vehicle, User customer) {
        this.booking = booking;
        this.vehicle = vehicle;
        this.customer = customer;
    }

    public long getDays() {
        return booking.getDays();
    }

    public double getRent() {
        return vehicle.calculateBaseRate(booking.getDays());
    }

    public double getDiscount() {
        return getRent() * customer.getDiscountRate();
    }

    public double getLateFee() {
        return booking.getLateFee();
    }

    public double getTotal() {
        return getRent() - getDiscount() + getLateFee();
    }

    public Booking getBooking() {
        return booking;
    }

    public Vehicle getVehicle() {
        return vehicle;
    }

    public User getCustomer() {
        return customer;
    }
}
