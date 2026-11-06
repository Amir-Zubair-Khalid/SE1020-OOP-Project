package model;

/**
 * A luxury car (e.g. BMW, Audi, Mercedes-Benz).
 * Only Premium members can rent these.
 */
public class LuxuryCar extends Vehicle {

    public LuxuryCar(int vehicleId, String brand, String model, String plateNumber, double dailyRate, String status) {
        super(vehicleId, brand, model, plateNumber, dailyRate, status);
    }

    @Override
    public String getType() {
        return "LUXURY";
    }

    @Override
    public double calculateBaseRate(long days) {
        return getDailyRate() * days;
    }

    @Override
    public boolean isPremiumOnly() {
        return true;
    }
}
