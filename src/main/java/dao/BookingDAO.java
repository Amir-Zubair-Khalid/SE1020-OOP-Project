package dao;

import model.Booking;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    private static final String SELECT = "SELECT b.*, u.username, CONCAT(v.brand, ' ', v.model) AS vehicle_name "
            + "FROM bookings b JOIN users u ON b.user_id = u.user_id JOIN vehicles v ON b.vehicle_id = v.vehicle_id ";

    public boolean addBooking(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, vehicle_id, pickup_date, return_date, late_fee, status) "
                + "VALUES (?, ?, ?, ?, 0, 'BOOKED')";
        return DBConnection.executeUpdate(sql, booking.getUserId(), booking.getVehicleId(),
                booking.getPickupDate(), booking.getReturnDate());
    }

    public boolean isVehicleFree(int vehicleId, LocalDate pickupDate, LocalDate returnDate) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE vehicle_id = ? AND status = 'BOOKED' "
                + "AND pickup_date < ? AND ? < return_date";
        return DBConnection.getNumber(sql, vehicleId, returnDate, pickupDate) == 0;
    }

    public Booking getBookingById(int bookingId) {
        List<Booking> bookings = queryBookings(SELECT + "WHERE b.booking_id = ?", bookingId);
        if (bookings.isEmpty()) {
            return null;
        }
        return bookings.get(0);
    }

    public List<Booking> getBookingsByUser(int userId) {
        return queryBookings(SELECT + "WHERE b.user_id = ? ORDER BY b.booking_id DESC", userId);
    }

    public List<Booking> getAllBookings() {
        return queryBookings(SELECT + "ORDER BY b.booking_id DESC");
    }

    public boolean cancelBooking(int bookingId) {
        String sql = "UPDATE bookings SET status = 'CANCELLED' WHERE booking_id = ? AND status = 'BOOKED'";
        return DBConnection.executeUpdate(sql, bookingId);
    }

    public boolean returnBooking(int bookingId, LocalDate actualReturnDate, double lateFee) {
        String sql = "UPDATE bookings SET status = 'RETURNED', actual_return_date = ?, late_fee = ? "
                + "WHERE booking_id = ? AND status = 'BOOKED'";
        return DBConnection.executeUpdate(sql, actualReturnDate, lateFee, bookingId);
    }

    public int countBookings() {
        return (int) DBConnection.getNumber("SELECT COUNT(*) FROM bookings");
    }

    private List<Booking> queryBookings(String sql, Object... params) {
        List<Booking> bookings = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setBookingId(rs.getInt("booking_id"));
                    booking.setUserId(rs.getInt("user_id"));
                    booking.setVehicleId(rs.getInt("vehicle_id"));
                    booking.setPickupDate(rs.getDate("pickup_date").toLocalDate());
                    booking.setReturnDate(rs.getDate("return_date").toLocalDate());
                    Date actual = rs.getDate("actual_return_date");
                    if (actual != null) {
                        booking.setActualReturnDate(actual.toLocalDate());
                    }
                    booking.setLateFee(rs.getDouble("late_fee"));
                    booking.setStatus(rs.getString("status"));
                    booking.setCustomerName(rs.getString("username"));
                    booking.setVehicleName(rs.getString("vehicle_name"));
                    bookings.add(booking);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
}
