package servlet;

import dao.BookingDAO;
import dao.UserDAO;
import dao.VehicleDAO;
import model.Booking;
import model.User;
import model.Vehicle;
import util.RequestUtil;
import util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

    private BookingDAO bookingDAO = new BookingDAO();
    private VehicleDAO vehicleDAO = new VehicleDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = RequestUtil.getText(request, "action");

        if (action.equals("bookForm")) {
            showBookForm(request, response);
        } else if (action.equals("all")) {
            showAllBookings(request, response);
        } else if (action.equals("returnForm")) {
            showReturnForm(request, response);
        } else {
            showMyBookings(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = RequestUtil.getText(request, "action");

        if (action.equals("book")) {
            bookVehicle(request, response);
        } else if (action.equals("cancel")) {
            cancelBooking(request, response);
        } else if (action.equals("return")) {
            returnVehicle(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/booking?action=myBookings");
        }
    }

    private void showBookForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireLogin(request, response);
        if (loggedUser == null) {
            return;
        }
        if (loggedUser.isAdmin()) {
            RequestUtil.redirectWithMessage(request, response, "/vehicle?action=list", "Admins cannot book vehicles");
            return;
        }

        Vehicle vehicle = vehicleDAO.getVehicleById(RequestUtil.getInt(request, "vehicleId"));
        if (vehicle == null || !vehicle.getStatus().equals("AVAILABLE")) {
            RequestUtil.redirectWithMessage(request, response, "/vehicle?action=list", "This vehicle is not available");
            return;
        }

        request.setAttribute("vehicle", vehicle);
        request.getRequestDispatcher("/WEB-INF/views/bookVehicle.jsp").forward(request, response);
    }

    private void bookVehicle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireLogin(request, response);
        if (loggedUser == null) {
            return;
        }
        if (loggedUser.isAdmin()) {
            RequestUtil.redirectWithMessage(request, response, "/vehicle?action=list", "Admins cannot book vehicles");
            return;
        }

        int vehicleId = RequestUtil.getInt(request, "vehicleId");
        LocalDate pickupDate = RequestUtil.getDate(request, "pickupDate");
        LocalDate returnDate = RequestUtil.getDate(request, "returnDate");
        String bookView = "/WEB-INF/views/bookVehicle.jsp";

        Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);
        if (vehicle == null || !vehicle.getStatus().equals("AVAILABLE")) {
            RequestUtil.redirectWithMessage(request, response, "/vehicle?action=list", "This vehicle is not available");
            return;
        }
        request.setAttribute("vehicle", vehicle);

        if (pickupDate == null || returnDate == null) {
            RequestUtil.forwardWithError(request, response, bookView, "Please select both dates");
            return;
        }
        if (pickupDate.isBefore(LocalDate.now())) {
            RequestUtil.forwardWithError(request, response, bookView, "Pickup date cannot be in the past");
            return;
        }
        if (!returnDate.isAfter(pickupDate)) {
            RequestUtil.forwardWithError(request, response, bookView, "Return date must be after the pickup date");
            return;
        }
        if (!bookingDAO.isVehicleFree(vehicleId, pickupDate, returnDate)) {
            RequestUtil.forwardWithError(request, response, bookView, "The vehicle is already booked for these dates");
            return;
        }

        Booking booking = new Booking();
        booking.setUserId(loggedUser.getUserId());
        booking.setVehicleId(vehicleId);
        booking.setPickupDate(pickupDate);
        booking.setReturnDate(returnDate);

        if (bookingDAO.addBooking(booking)) {
            RequestUtil.redirectWithMessage(request, response, "/booking?action=myBookings", "Booking confirmed");
        } else {
            RequestUtil.forwardWithError(request, response, bookView, "Could not save the booking");
        }
    }

    private void showMyBookings(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireLogin(request, response);
        if (loggedUser == null) {
            return;
        }
        request.setAttribute("bookings", bookingDAO.getBookingsByUser(loggedUser.getUserId()));
        request.getRequestDispatcher("/WEB-INF/views/myBookings.jsp").forward(request, response);
    }

    private void showAllBookings(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireAdmin(request, response);
        if (loggedUser == null) {
            return;
        }
        request.setAttribute("bookings", bookingDAO.getAllBookings());
        request.getRequestDispatcher("/WEB-INF/views/allBookings.jsp").forward(request, response);
    }

    private void cancelBooking(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User loggedUser = SessionUtil.requireLogin(request, response);
        if (loggedUser == null) {
            return;
        }

        Booking booking = bookingDAO.getBookingById(RequestUtil.getInt(request, "bookingId"));
        String message;

        if (booking == null || booking.getUserId() != loggedUser.getUserId()) {
            message = "Booking not found";
        } else if (bookingDAO.cancelBooking(booking.getBookingId())) {
            message = "Booking cancelled";
        } else {
            message = "Only bookings with status BOOKED can be cancelled";
        }

        RequestUtil.redirectWithMessage(request, response, "/booking?action=myBookings", message);
    }

    private void showReturnForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireAdmin(request, response);
        if (loggedUser == null) {
            return;
        }

        Booking booking = bookingDAO.getBookingById(RequestUtil.getInt(request, "bookingId"));
        if (booking == null || !booking.getStatus().equals("BOOKED")) {
            RequestUtil.redirectWithMessage(request, response, "/booking?action=all", "This booking cannot be returned");
            return;
        }

        request.setAttribute("booking", booking);
        request.setAttribute("today", LocalDate.now());
        request.getRequestDispatcher("/WEB-INF/views/returnVehicle.jsp").forward(request, response);
    }

    private void returnVehicle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireAdmin(request, response);
        if (loggedUser == null) {
            return;
        }

        Booking booking = bookingDAO.getBookingById(RequestUtil.getInt(request, "bookingId"));
        LocalDate actualDate = RequestUtil.getDate(request, "actualReturnDate");

        if (booking == null || !booking.getStatus().equals("BOOKED")) {
            RequestUtil.redirectWithMessage(request, response, "/booking?action=all", "This booking cannot be returned");
            return;
        }
        if (actualDate == null || actualDate.isBefore(booking.getPickupDate())) {
            request.setAttribute("booking", booking);
            request.setAttribute("today", LocalDate.now());
            RequestUtil.forwardWithError(request, response, "/WEB-INF/views/returnVehicle.jsp", "Please enter a valid return date");
            return;
        }

        User customer = userDAO.getUserById(booking.getUserId());
        long lateDays = booking.calculateLateDays(actualDate);
        double lateFee = lateDays * customer.getLateFeePerDay();

        if (bookingDAO.returnBooking(booking.getBookingId(), actualDate, lateFee)) {
            RequestUtil.redirectWithMessage(request, response, "/booking?action=all", "Vehicle returned. Late days: " + lateDays);
        } else {
            RequestUtil.redirectWithMessage(request, response, "/booking?action=all", "Could not update the booking");
        }
    }
}
