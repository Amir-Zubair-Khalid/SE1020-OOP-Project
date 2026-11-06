package servlet;

import dao.UserDAO;
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
import java.util.List;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = RequestUtil.getText(request, "action");

        if (action.equals("logout")) {
            logout(request, response);
        } else if (action.equals("list")) {
            listCustomers(request, response);
        } else {
            showProfile(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = RequestUtil.getText(request, "action");

        if (action.equals("register")) {
            register(request, response);
        } else if (action.equals("login")) {
            login(request, response);
        } else if (action.equals("update")) {
            updateProfile(request, response);
        } else if (action.equals("delete")) {
            deleteCustomer(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    private void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = RequestUtil.getText(request, "username");
        String email = RequestUtil.getText(request, "email");
        String password = RequestUtil.getText(request, "password");
        String phone = RequestUtil.getText(request, "phone");
        String licenseNumber = RequestUtil.getText(request, "licenseNumber");
        String membership = RequestUtil.getText(request, "membership");

        if (username.isEmpty() || email.isEmpty() || password.isEmpty() || licenseNumber.isEmpty()) {
            RequestUtil.forwardWithError(request, response, "/register.jsp", "Please fill all the required fields");
            return;
        }
        if (!email.contains("@")) {
            RequestUtil.forwardWithError(request, response, "/register.jsp", "Email is not valid");
            return;
        }
        if (password.length() < 6) {
            RequestUtil.forwardWithError(request, response, "/register.jsp", "Password must have at least 6 characters");
            return;
        }
        if (userDAO.getUserByUsername(username) != null) {
            RequestUtil.forwardWithError(request, response, "/register.jsp", "Username is already taken");
            return;
        }

        String role = "PREMIUM".equals(membership) ? "PREMIUM" : "REGULAR";
        User user = User.create(role, 0, username, email, PasswordUtil.hash(password), phone, licenseNumber);

        if (userDAO.addUser(user)) {
            RequestUtil.redirectWithMessage(request, response, "/login.jsp", "Registration successful. Please login.");
        } else {
            RequestUtil.forwardWithError(request, response, "/register.jsp", "Could not register the user");
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = RequestUtil.getText(request, "username");
        String password = RequestUtil.getText(request, "password");

        User user = userDAO.login(username, PasswordUtil.hash(password));

        if (user == null) {
            RequestUtil.forwardWithError(request, response, "/login.jsp", "Wrong username or password");
            return;
        }

        request.getSession().setAttribute("loggedUser", user);
        if (user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/admin?action=dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.getSession().invalidate();
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    private void showProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireLogin(request, response);
        if (loggedUser == null) {
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireLogin(request, response);
        if (loggedUser == null) {
            return;
        }

        String email = RequestUtil.getText(request, "email");
        String phone = RequestUtil.getText(request, "phone");
        String licenseNumber = RequestUtil.getText(request, "licenseNumber");
        String newPassword = RequestUtil.getText(request, "newPassword");
        String membership = RequestUtil.getText(request, "membership");
        String profileView = "/WEB-INF/views/profile.jsp";

        if (email.isEmpty() || !email.contains("@")) {
            RequestUtil.forwardWithError(request, response, profileView, "Email is not valid");
            return;
        }
        if (!newPassword.isEmpty() && newPassword.length() < 6) {
            RequestUtil.forwardWithError(request, response, profileView, "Password must have at least 6 characters");
            return;
        }

        String role = loggedUser.getRole();
        if (!loggedUser.isAdmin()) {
            role = "PREMIUM".equals(membership) ? "PREMIUM" : "REGULAR";
        }

        String password = loggedUser.getPassword();
        if (!newPassword.isEmpty()) {
            password = PasswordUtil.hash(newPassword);
        }

        User updatedUser = User.create(role, loggedUser.getUserId(), loggedUser.getUsername(), email, password, phone, licenseNumber);

        if (userDAO.updateUser(updatedUser)) {
            request.getSession().setAttribute("loggedUser", updatedUser);
            RequestUtil.redirectWithMessage(request, response, "/user?action=profile", "Profile updated");
        } else {
            RequestUtil.forwardWithError(request, response, profileView, "Could not update the profile");
        }
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireAdmin(request, response);
        if (loggedUser == null) {
            return;
        }

        String keyword = RequestUtil.getText(request, "keyword");
        List<User> users;
        if (keyword.isEmpty()) {
            users = userDAO.getCustomers();
        } else {
            users = userDAO.searchCustomers(keyword);
        }

        request.setAttribute("users", users);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/WEB-INF/views/userList.jsp").forward(request, response);
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User loggedUser = SessionUtil.requireAdmin(request, response);
        if (loggedUser == null) {
            return;
        }

        int userId = RequestUtil.getInt(request, "userId");
        User user = userDAO.getUserById(userId);
        String message;

        if (user == null || user.isAdmin()) {
            message = "Customer not found";
        } else if (userDAO.deleteUser(userId)) {
            message = "Customer deleted";
        } else {
            message = "Cannot delete a customer who has bookings";
        }

        RequestUtil.redirectWithMessage(request, response, "/user?action=list", message);
    }
}
