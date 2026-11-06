package model;

import java.time.LocalDate;

public class CashPayment extends Payment {

    public CashPayment(int paymentId, int bookingId, double amount, String status, LocalDate paymentDate) {
        super(paymentId, bookingId, amount, status, paymentDate);
    }

    @Override
    public String getMethod() {
        return "CASH";
    }

    @Override
    public double getFeePercent() {
        return 0;
    }

    @Override
    public String getInitialStatus() {
        return "PENDING";
    }
}
