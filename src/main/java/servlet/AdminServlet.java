package servlet;

import dao.BookingDAO;
import dao.PaymentDAO;
import dao.UserDAO;
import dao.VehicleDAO;
import model.User;
import util.PasswordUtil;
import util.RequestUtil;
import util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();
    private VehicleDAO vehicleDAO = new VehicleDAO();
    private BookingDAO bookingDAO = new BookingDAO();
    private PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireAdmin(request, response);
        if (loggedUser == null) {
            return;
        }

        String action = RequestUtil.getText(request, "action");

        if (action.equals("list")) {
            request.setAttribute("admins", userDAO.getAdmins());
            request.getRequestDispatcher("/WEB-INF/views/adminList.jsp").forward(request, response);
        } else if (action.equals("addForm")) {
            request.getRequestDispatcher("/WEB-INF/views/adminRegister.jsp").forward(request, response);
        } else {
            request.setAttribute("totalUsers", userDAO.countUsers());
            request.setAttribute("totalVehicles", vehicleDAO.countVehicles());
            request.setAttribute("totalBookings", bookingDAO.countBookings());
            request.setAttribute("totalRevenue", paymentDAO.getTotalRevenue());
            request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireAdmin(request, response);
        if (loggedUser == null) {
            return;
        }

        String action = RequestUtil.getText(request, "action");

        if (action.equals("add")) {
            addAdmin(request, response);
        } else if (action.equals("delete")) {
            deleteAdmin(request, response, loggedUser);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin?action=dashboard");
        }
    }

    private void addAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = RequestUtil.getText(request, "username");
        String email = RequestUtil.getText(request, "email");
        String password = RequestUtil.getText(request, "password");
        String phone = RequestUtil.getText(request, "phone");
        String addView = "/WEB-INF/views/adminRegister.jsp";

        if (username.isEmpty() || email.isEmpty() || password.isEmpty()) {
            RequestUtil.forwardWithError(request, response, addView, "Please fill all the required fields");
            return;
        }
        if (!email.contains("@")) {
            RequestUtil.forwardWithError(request, response, addView, "Email is not valid");
            return;
        }
        if (password.length() < 6) {
            RequestUtil.forwardWithError(request, response, addView, "Password must have at least 6 characters");
            return;
        }
        if (userDAO.getUserByUsername(username) != null) {
            RequestUtil.forwardWithError(request, response, addView, "Username is already taken");
            return;
        }

        User admin = User.create("ADMIN", 0, username, email, PasswordUtil.hash(password), phone, "-");

        if (userDAO.addUser(admin)) {
            RequestUtil.redirectWithMessage(request, response, "/admin?action=list", "Admin account created");
        } else {
            RequestUtil.forwardWithError(request, response, addView, "Could not create the admin account");
        }
    }

    private void deleteAdmin(HttpServletRequest request, HttpServletResponse response, User loggedUser) throws IOException {
        int adminId = RequestUtil.getInt(request, "userId");
        User admin = userDAO.getUserById(adminId);
        String message;

        if (admin == null || !admin.isAdmin()) {
            message = "Admin not found";
        } else if (admin.getUserId() == loggedUser.getUserId()) {
            message = "You cannot delete your own account";
        } else if (userDAO.deleteUser(adminId)) {
            message = "Admin deleted";
        } else {
            message = "Could not delete the admin";
        }

        RequestUtil.redirectWithMessage(request, response, "/admin?action=list", message);
    }
}
