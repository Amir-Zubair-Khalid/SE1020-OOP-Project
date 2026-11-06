package model;

public class Bike extends Vehicle {

    public Bike(int vehicleId, String brand, String model, String plateNumber, double dailyRate, String status) {
        super(vehicleId, brand, model, plateNumber, dailyRate, status);
    }

    @Override
    public String getType() {
        return "BIKE";
    }

    @Override
    public double calculateBaseRate(long days) {
        return getDailyRate() * days;
    }
}
