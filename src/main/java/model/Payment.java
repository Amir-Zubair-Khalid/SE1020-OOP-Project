package model;

import java.time.LocalDate;

public abstract class Payment {

    private int paymentId;
    private int bookingId;
    private double amount;
    private String status;
    private LocalDate paymentDate;

    public Payment(int paymentId, int bookingId, double amount, String status, LocalDate paymentDate) {
        this.paymentId = paymentId;
        this.bookingId = bookingId;
        this.amount = amount;
        this.status = status;
        this.paymentDate = paymentDate;
    }

    public abstract String getMethod();

    public abstract double getFeePercent();

    public abstract String getInitialStatus();

    public double calculateTotal(double invoiceTotal) {
        return invoiceTotal + invoiceTotal * getFeePercent() / 100;
    }

    public static Payment create(String method, int paymentId, int bookingId, double amount, String status, LocalDate paymentDate) {
        if (method.equals("CARD")) {
            return new CardPayment(paymentId, bookingId, amount, status, paymentDate);
        } else if (method.equals("ONLINE")) {
            return new OnlinePayment(paymentId, bookingId, amount, status, paymentDate);
        } else {
            return new CashPayment(paymentId, bookingId, amount, status, paymentDate);
        }
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDate getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(LocalDate paymentDate) {
        this.paymentDate = paymentDate;
    }
}
