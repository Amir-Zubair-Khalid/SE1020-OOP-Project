package servlet;

import dao.BookingDAO;
import dao.PaymentDAO;
import dao.UserDAO;
import dao.VehicleDAO;
import model.Booking;
import model.Invoice;
import model.Payment;
import model.User;
import util.RequestUtil;
import util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    private PaymentDAO paymentDAO = new PaymentDAO();
    private BookingDAO bookingDAO = new BookingDAO();
    private VehicleDAO vehicleDAO = new VehicleDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = RequestUtil.getText(request, "action");

        if (action.equals("pay")) {
            showInvoice(request, response);
        } else if (action.equals("all")) {
            showAllPayments(request, response);
        } else {
            showHistory(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = RequestUtil.getText(request, "action");

        if (action.equals("pay")) {
            makePayment(request, response);
        } else if (action.equals("markPaid")) {
            markAsPaid(request, response);
        } else if (action.equals("delete")) {
            deletePayment(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/payment?action=history");
        }
    }

    private Invoice createInvoice(Booking booking) {
        return new Invoice(booking, vehicleDAO.getVehicleById(booking.getVehicleId()), userDAO.getUserById(booking.getUserId()));
    }

    private boolean canPay(Booking booking, User loggedUser) {
        return booking != null && booking.getUserId() == loggedUser.getUserId() && booking.getStatus().equals("RETURNED");
    }

    private void showInvoice(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireLogin(request, response);
        if (loggedUser == null) {
            return;
        }

        Booking booking = bookingDAO.getBookingById(RequestUtil.getInt(request, "bookingId"));
        if (!canPay(booking, loggedUser)) {
            RequestUtil.redirectWithMessage(request, response, "/booking?action=myBookings", "An invoice is only available for your returned bookings");
            return;
        }

        request.setAttribute("invoice", createInvoice(booking));
        request.setAttribute("payment", paymentDAO.getPaymentByBooking(booking.getBookingId()));
        request.getRequestDispatcher("/WEB-INF/views/payment.jsp").forward(request, response);
    }

    private void makePayment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireLogin(request, response);
        if (loggedUser == null) {
            return;
        }

        Booking booking = bookingDAO.getBookingById(RequestUtil.getInt(request, "bookingId"));
        if (!canPay(booking, loggedUser)) {
            RequestUtil.redirectWithMessage(request, response, "/booking?action=myBookings", "An invoice is only available for your returned bookings");
            return;
        }
        if (paymentDAO.getPaymentByBooking(booking.getBookingId()) != null) {
            RequestUtil.redirectWithMessage(request, response, "/payment?action=history", "This booking is already paid");
            return;
        }

        Invoice invoice = createInvoice(booking);
        String method = RequestUtil.getText(request, "method");

        Payment payment = Payment.create(method, 0, booking.getBookingId(), 0, "", LocalDate.now());
        payment.setAmount(payment.calculateTotal(invoice.getTotal()));
        payment.setStatus(payment.getInitialStatus());

        if (paymentDAO.addPayment(payment)) {
            RequestUtil.redirectWithMessage(request, response, "/payment?action=history", "Payment recorded");
        } else {
            RequestUtil.redirectWithMessage(request, response, "/booking?action=myBookings", "Could not save the payment");
        }
    }

    private void showHistory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireLogin(request, response);
        if (loggedUser == null) {
            return;
        }
        request.setAttribute("payments", paymentDAO.getPaymentsByUser(loggedUser.getUserId()));
        request.getRequestDispatcher("/WEB-INF/views/paymentHistory.jsp").forward(request, response);
    }

    private void showAllPayments(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedUser = SessionUtil.requireAdmin(request, response);
        if (loggedUser == null) {
            return;
        }
        request.setAttribute("payments", paymentDAO.getAllPayments());
        request.getRequestDispatcher("/WEB-INF/views/adminPayments.jsp").forward(request, response);
    }

    private void markAsPaid(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User loggedUser = SessionUtil.requireAdmin(request, response);
        if (loggedUser == null) {
            return;
        }

        String message;
        if (paymentDAO.markAsPaid(RequestUtil.getInt(request, "paymentId"))) {
            message = "Payment marked as paid";
        } else {
            message = "Only pending payments can be marked as paid";
        }
        RequestUtil.redirectWithMessage(request, response, "/payment?action=all", message);
    }

    private void deletePayment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User loggedUser = SessionUtil.requireAdmin(request, response);
        if (loggedUser == null) {
            return;
        }

        String message;
        if (paymentDAO.deletePayment(RequestUtil.getInt(request, "paymentId"))) {
            message = "Payment deleted";
        } else {
            message = "Only pending payments can be deleted";
        }
        RequestUtil.redirectWithMessage(request, response, "/payment?action=all", message);
    }
}
