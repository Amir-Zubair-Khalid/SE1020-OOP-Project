package util;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

public class RequestUtil {

    public static String getText(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        if (value == null) {
            return "";
        }
        return value.trim();
    }

    public static int getInt(HttpServletRequest request, String name) {
        try {
            return Integer.parseInt(getText(request, name));
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    public static double getDouble(HttpServletRequest request, String name) {
        try {
            return Double.parseDouble(getText(request, name));
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    public static LocalDate getDate(HttpServletRequest request, String name) {
        try {
            return LocalDate.parse(getText(request, name));
        } catch (DateTimeParseException e) {
            return null;
        }
    }

    public static void forwardWithError(HttpServletRequest request, HttpServletResponse response, String view, String error)
            throws ServletException, IOException {
        request.setAttribute("error", error);
        request.getRequestDispatcher(view).forward(request, response);
    }

    public static void redirectWithMessage(HttpServletRequest request, HttpServletResponse response, String url, String message)
            throws IOException {
        request.getSession().setAttribute("message", message);
        response.sendRedirect(request.getContextPath() + url);
    }
}
