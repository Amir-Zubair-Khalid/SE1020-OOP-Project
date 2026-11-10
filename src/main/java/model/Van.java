package model;

public class Van extends Vehicle {

    public Van(int vehicleId, String brand, String model, String plateNumber, double dailyRate, String status) {
        super(vehicleId, brand, model, plateNumber, dailyRate, status);
    }

    @Override
    public String getType() {
        return "VAN";
    }

    @Override
    public double calculateBaseRate(long days) {
        return getDailyRate() * days + 1000;
    }
}
