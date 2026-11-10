package model;

public class Car extends Vehicle {

    public Car(int vehicleId, String brand, String model, String plateNumber, double dailyRate, String status) {
        super(vehicleId, brand, model, plateNumber, dailyRate, status);
    }

    @Override
    public String getType() {
        return "CAR";
    }

    @Override
    public double calculateBaseRate(long days) {
        return getDailyRate() * days;
    }
}
