package model;

public abstract class Vehicle {

    private int vehicleId;
    private String brand;
    private String model;
    private String plateNumber;
    private double dailyRate;
    private String status;

    public Vehicle(int vehicleId, String brand, String model, String plateNumber, double dailyRate, String status) {
        this.vehicleId = vehicleId;
        this.brand = brand;
        this.model = model;
        this.plateNumber = plateNumber;
        this.dailyRate = dailyRate;
        this.status = status;
    }

    public abstract String getType();

    public abstract double calculateBaseRate(long days);

    public String getName() {
        return brand + " " + model;
    }

    // Only Premium members can rent this vehicle. LuxuryCar overrides this to return true.
    public boolean isPremiumOnly() {
        return false;
    }

    public static Vehicle create(String type, int vehicleId, String brand, String model, String plateNumber, double dailyRate, String status) {
        if (type.equals("LUXURY")) {
            return new LuxuryCar(vehicleId, brand, model, plateNumber, dailyRate, status);
        } else if (type.equals("VAN")) {
            return new Van(vehicleId, brand, model, plateNumber, dailyRate, status);
        } else if (type.equals("BIKE")) {
            return new Bike(vehicleId, brand, model, plateNumber, dailyRate, status);
        } else {
            return new Car(vehicleId, brand, model, plateNumber, dailyRate, status);
        }
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getPlateNumber() {
        return plateNumber;
    }

    public void setPlateNumber(String plateNumber) {
        this.plateNumber = plateNumber;
    }

    public double getDailyRate() {
        return dailyRate;
    }

    public void setDailyRate(double dailyRate) {
        this.dailyRate = dailyRate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
