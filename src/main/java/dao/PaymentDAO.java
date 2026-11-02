package dao;

import model.Payment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    public boolean addPayment(Payment payment) {
        String sql = "INSERT INTO payments (booking_id, amount, method, status, payment_date) VALUES (?, ?, ?, ?, ?)";
        return DBConnection.executeUpdate(sql, payment.getBookingId(), payment.getAmount(), payment.getMethod(),
                payment.getStatus(), payment.getPaymentDate());
    }

    public Payment getPaymentByBooking(int bookingId) {
        List<Payment> payments = queryPayments("SELECT * FROM payments WHERE booking_id = ?", bookingId);
        if (payments.isEmpty()) {
            return null;
        }
        return payments.get(0);
    }

    public List<Payment> getPaymentsByUser(int userId) {
        String sql = "SELECT p.* FROM payments p JOIN bookings b ON p.booking_id = b.booking_id "
                + "WHERE b.user_id = ? ORDER BY p.payment_id DESC";
        return queryPayments(sql, userId);
    }

    public List<Payment> getAllPayments() {
        return queryPayments("SELECT * FROM payments ORDER BY payment_id DESC");
    }

    public boolean markAsPaid(int paymentId) {
        String sql = "UPDATE payments SET status = 'PAID' WHERE payment_id = ? AND status = 'PENDING'";
        return DBConnection.executeUpdate(sql, paymentId);
    }

    public boolean deletePayment(int paymentId) {
        String sql = "DELETE FROM payments WHERE payment_id = ? AND status = 'PENDING'";
        return DBConnection.executeUpdate(sql, paymentId);
    }

    public double getTotalRevenue() {
        return DBConnection.getNumber("SELECT COALESCE(SUM(amount), 0) FROM payments WHERE status = 'PAID'");
    }

    private List<Payment> queryPayments(String sql, Object... params) {
        List<Payment> payments = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    payments.add(Payment.create(rs.getString("method"), rs.getInt("payment_id"),
                            rs.getInt("booking_id"), rs.getDouble("amount"), rs.getString("status"),
                            rs.getDate("payment_date").toLocalDate()));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
}
