package model;

import java.time.LocalDate;

public class OnlinePayment extends Payment {

    public OnlinePayment(int paymentId, int bookingId, double amount, String status, LocalDate paymentDate) {
        super(paymentId, bookingId, amount, status, paymentDate);
    }

    @Override
    public String getMethod() {
        return "ONLINE";
    }

    @Override
    public double getFeePercent() {
        return 1;
    }

    @Override
    public String getInitialStatus() {
        return "PAID";
    }
}
