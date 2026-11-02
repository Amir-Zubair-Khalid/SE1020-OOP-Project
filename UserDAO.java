package dao;

import model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public boolean addUser(User user) {
        String sql = "INSERT INTO users (username, email, password, phone, license_number, role) VALUES (?, ?, ?, ?, ?, ?)";
        return DBConnection.executeUpdate(sql, user.getUsername(), user.getEmail(), user.getPassword(),
                user.getPhone(), user.getLicenseNumber(), user.getRole());
    }

    public User login(String username, String hashedPassword) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        return getFirst(queryUsers(sql, username, hashedPassword));
    }

    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        return getFirst(queryUsers(sql, username));
    }

    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        return getFirst(queryUsers(sql, userId));
    }

    public List<User> getCustomers() {
        String sql = "SELECT * FROM users WHERE role <> 'ADMIN' ORDER BY user_id";
        return queryUsers(sql);
    }

    public List<User> searchCustomers(String keyword) {
        String sql = "SELECT * FROM users WHERE role <> 'ADMIN' AND (username LIKE ? OR email LIKE ?) ORDER BY user_id";
        String like = "%" + keyword + "%";
        return queryUsers(sql, like, like);
    }

    public List<User> getAdmins() {
        String sql = "SELECT * FROM users WHERE role = 'ADMIN' ORDER BY user_id";
        return queryUsers(sql);
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE users SET email = ?, password = ?, phone = ?, license_number = ?, role = ? WHERE user_id = ?";
        return DBConnection.executeUpdate(sql, user.getEmail(), user.getPassword(), user.getPhone(),
                user.getLicenseNumber(), user.getRole(), user.getUserId());
    }

    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        return DBConnection.executeUpdate(sql, userId);
    }

    public int countUsers() {
        return (int) DBConnection.getNumber("SELECT COUNT(*) FROM users");
    }

    private User getFirst(List<User> users) {
        if (users.isEmpty()) {
            return null;
        }
        return users.get(0);
    }

    private List<User> queryUsers(String sql, Object... params) {
        List<User> users = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    users.add(User.create(rs.getString("role"), rs.getInt("user_id"), rs.getString("username"),
                            rs.getString("email"), rs.getString("password"), rs.getString("phone"),
                            rs.getString("license_number")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
}
