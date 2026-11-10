package dao;

import model.Vehicle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VehicleDAO {

    public boolean addVehicle(Vehicle vehicle) {
        String sql = "INSERT INTO vehicles (vehicle_type, brand, model, plate_number, daily_rate, status) VALUES (?, ?, ?, ?, ?, ?)";
        return DBConnection.executeUpdate(sql, vehicle.getType(), vehicle.getBrand(), vehicle.getModel(),
                vehicle.getPlateNumber(), vehicle.getDailyRate(), vehicle.getStatus());
    }

    public Vehicle getVehicleById(int vehicleId) {
        String sql = "SELECT * FROM vehicles WHERE vehicle_id = ?";
        List<Vehicle> vehicles = queryVehicles(sql, vehicleId);
        if (vehicles.isEmpty()) {
            return null;
        }
        return vehicles.get(0);
    }

    public List<Vehicle> searchVehicles(String keyword, String type) {
        String sql = "SELECT * FROM vehicles WHERE (brand LIKE ? OR model LIKE ? OR plate_number LIKE ?) "
                + "AND (? = '' OR vehicle_type = ?) ORDER BY vehicle_id";
        String like = "%" + keyword + "%";
        return queryVehicles(sql, like, like, like, type, type);
    }

    public boolean updateVehicle(Vehicle vehicle) {
        String sql = "UPDATE vehicles SET vehicle_type = ?, brand = ?, model = ?, plate_number = ?, daily_rate = ?, status = ? "
                + "WHERE vehicle_id = ?";
        return DBConnection.executeUpdate(sql, vehicle.getType(), vehicle.getBrand(), vehicle.getModel(),
                vehicle.getPlateNumber(), vehicle.getDailyRate(), vehicle.getStatus(), vehicle.getVehicleId());
    }

    public boolean deleteVehicle(int vehicleId) {
        String sql = "DELETE FROM vehicles WHERE vehicle_id = ?";
        return DBConnection.executeUpdate(sql, vehicleId);
    }

    public int countVehicles() {
        return (int) DBConnection.getNumber("SELECT COUNT(*) FROM vehicles");
    }

    private List<Vehicle> queryVehicles(String sql, Object... params) {
        List<Vehicle> vehicles = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    vehicles.add(Vehicle.create(rs.getString("vehicle_type"), rs.getInt("vehicle_id"),
                            rs.getString("brand"), rs.getString("model"), rs.getString("plate_number"),
                            rs.getDouble("daily_rate"), rs.getString("status")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicles;
    }
}
