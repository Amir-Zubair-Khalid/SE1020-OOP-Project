package util;

import model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class SessionUtil {

    public static User getLoggedUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        return (User) session.getAttribute("loggedUser");
    }

    public static User requireLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = getLoggedUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
        return user;
    }

    public static User requireAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = requireLogin(request, response);
        if (user == null) {
            return null;
        }
        if (!user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return null;
        }
        return user;
    }
}
