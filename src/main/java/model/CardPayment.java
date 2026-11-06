package model;

import java.time.LocalDate;

public class CardPayment extends Payment {

    public CardPayment(int paymentId, int bookingId, double amount, String status, LocalDate paymentDate) {
        super(paymentId, bookingId, amount, status, paymentDate);
    }

    @Override
    public String getMethod() {
        return "CARD";
    }

    @Override
    public double getFeePercent() {
        return 2;
    }

    @Override
    public String getInitialStatus() {
        return "PAID";
    }
}
