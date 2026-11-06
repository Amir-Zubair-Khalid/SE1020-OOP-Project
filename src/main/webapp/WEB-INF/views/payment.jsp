<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="page-head">
    <div>
        <a class="text-decoration-none small" href="${root}/booking?action=myBookings"><i class="bi bi-arrow-left"></i> Back to my bookings</a>
        <h1 class="mt-1">Invoice</h1>
        <p>Check the charges, then choose how you'd like to pay.</p>
    </div>
</div>

<div class="row g-4">
    <div class="col-lg-6">
        <div class="panel invoice">
            <div class="invoice-head">
                <div>
                    <span class="brand-plate">VRS</span>
                    <h2 class="mt-2">DriveEasy</h2>
                    <div class="invoice-no">Invoice for booking #${invoice.booking.bookingId}</div>
                </div>
                <div class="text-end">
                    <div class="fw-semibold"><c:out value="${invoice.customer.username}"/></div>
                    <span class="status status-${invoice.customer.role}">${invoice.customer.role}</span>
                </div>
            </div>

            <div class="inv-line">
                <div><b><c:out value="${invoice.vehicle.name}"/></b> <span class="plate ms-1"><c:out value="${invoice.vehicle.plateNumber}"/></span>
                    <small>${invoice.booking.pickupDate} to ${invoice.booking.returnDate} &middot; returned ${invoice.booking.actualReturnDate}</small></div>
            </div>
            <div class="inv-line">
                <div>Rent
                    <small>${invoice.days} ${invoice.days == 1 ? 'day' : 'days'} &times; Rs. <fmt:formatNumber value="${invoice.vehicle.dailyRate}" pattern="#,##0"/><c:if test="${invoice.vehicle.type == 'VAN'}"> + Rs. 1,000 van charge</c:if></small></div>
                <span class="amt">Rs. <fmt:formatNumber value="${invoice.rent}" pattern="#,##0.00"/></span>
            </div>
            <div class="inv-line">
                <div>Membership discount
                    <small><fmt:formatNumber value="${invoice.customer.discountRate * 100}" pattern="0"/>% for ${invoice.customer.role} members</small></div>
                <span class="amt text-success">&minus; Rs. <fmt:formatNumber value="${invoice.discount}" pattern="#,##0.00"/></span>
            </div>
            <div class="inv-line">
                <div>Late fee
                    <small>${invoice.lateFee > 0 ? 'Returned after the agreed date' : 'Returned on time'}</small></div>
                <span class="amt ${invoice.lateFee > 0 ? 'text-danger' : ''}">+ Rs. <fmt:formatNumber value="${invoice.lateFee}" pattern="#,##0.00"/></span>
            </div>
            <div class="inv-total">
                <span class="fw-semibold">Invoice total</span>
                <b>Rs. <fmt:formatNumber value="${invoice.total}" pattern="#,##0.00"/></b>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <c:choose>
            <c:when test="${not empty payment}">
                <div class="panel text-center py-5">
                    <div class="stat-icon mx-auto mb-3" style="background:var(--good-bg);color:var(--good)"><i class="bi bi-check2-circle"></i></div>
                    <h2 class="h4">${payment.status == 'PAID' ? 'Paid in full' : 'Payment pending'}</h2>
                    <p class="text-muted-2 mb-3">
                        Rs. <fmt:formatNumber value="${payment.amount}" pattern="#,##0.00"/> by ${payment.method} on ${payment.paymentDate}.
                        <c:if test="${payment.status == 'PENDING'}"><br>Pay the cash at the counter and an admin will confirm it.</c:if>
                    </p>
                    <span class="status status-${payment.status}">${payment.status}</span>
                    <div class="mt-4"><a class="btn btn-light" href="${root}/payment?action=history">View my payments</a></div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="panel">
                    <div class="panel-title"><i class="bi bi-wallet2"></i> Choose a payment method</div>
                    <form action="${root}/payment" method="post" id="payForm">
                        <input type="hidden" name="action" value="pay">
                        <input type="hidden" name="bookingId" value="${invoice.booking.bookingId}">
                        <div class="method-grid">
                            <label class="method-option">
                                <input type="radio" name="method" value="CARD" data-total="${invoice.total * 1.02}" checked>
                                <i class="bi bi-credit-card-2-front"></i>
                                <span class="m-name">Card</span>
                                <span class="m-note">2% fee &middot; paid now</span>
                                <span class="m-amt">Rs. <fmt:formatNumber value="${invoice.total * 1.02}" pattern="#,##0.00"/></span>
                            </label>
                            <label class="method-option">
                                <input type="radio" name="method" value="ONLINE" data-total="${invoice.total * 1.01}">
                                <i class="bi bi-phone"></i>
                                <span class="m-name">Online</span>
                                <span class="m-note">1% fee &middot; paid now</span>
                                <span class="m-amt">Rs. <fmt:formatNumber value="${invoice.total * 1.01}" pattern="#,##0.00"/></span>
                            </label>
                            <label class="method-option">
                                <input type="radio" name="method" value="CASH" data-total="${invoice.total}">
                                <i class="bi bi-cash-stack"></i>
                                <span class="m-name">Cash</span>
                                <span class="m-note">No fee &middot; pending until an admin confirms</span>
                                <span class="m-amt">Rs. <fmt:formatNumber value="${invoice.total}" pattern="#,##0.00"/></span>
                            </label>
                        </div>
                        <div class="pay-total mt-4">
                            <span>You'll pay</span>
                            <b id="payAmount">Rs. <fmt:formatNumber value="${invoice.total * 1.02}" pattern="#,##0.00"/></b>
                        </div>
                        <div class="d-flex gap-2 mt-3">
                            <button type="submit" class="btn btn-primary flex-grow-1 justify-content-center py-2"><i class="bi bi-lock"></i> Pay now</button>
                            <a class="btn btn-light" href="${root}/booking?action=myBookings">Back</a>
                        </div>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
(function () {
    var out = document.getElementById('payAmount');
    if (!out) return;
    document.querySelectorAll('input[name=method]').forEach(function (r) {
        r.addEventListener('change', function () {
            out.textContent = 'Rs. ' + Number(r.dataset.total).toLocaleString('en-LK', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        });
    });
})();
</script>

<%@ include file="/WEB-INF/views/footer.jsp" %>
