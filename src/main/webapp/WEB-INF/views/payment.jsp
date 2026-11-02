<%@ include file="/WEB-INF/views/header.jsp" %>

<h2>Invoice</h2>

<table class="table table-bordered col-md-5" style="max-width: 500px;">
    <tr><th>Booking ID</th><td>${invoice.booking.bookingId}</td></tr>
    <tr><th>Vehicle</th><td><c:out value="${invoice.vehicle.name}"/></td></tr>
    <tr><th>Rental days</th><td>${invoice.days}</td></tr>
    <tr><th>Rent</th><td>Rs. <fmt:formatNumber value="${invoice.rent}" pattern="#,##0.00"/></td></tr>
    <tr><th>Membership discount</th><td>Rs. <fmt:formatNumber value="${invoice.discount}" pattern="#,##0.00"/></td></tr>
    <tr><th>Late fee</th><td>Rs. <fmt:formatNumber value="${invoice.lateFee}" pattern="#,##0.00"/></td></tr>
    <tr><th>Total</th><td><b>Rs. <fmt:formatNumber value="${invoice.total}" pattern="#,##0.00"/></b></td></tr>
</table>

<c:choose>
    <c:when test="${not empty payment}">
        <div class="alert alert-info">
            This booking is already paid by ${payment.method}.
            Amount: Rs. <fmt:formatNumber value="${payment.amount}" pattern="#,##0.00"/> (${payment.status})
        </div>
    </c:when>
    <c:otherwise>
        <form action="${root}/payment" method="post" class="col-md-5">
            <input type="hidden" name="action" value="pay">
            <input type="hidden" name="bookingId" value="${invoice.booking.bookingId}">
            <div class="mb-3">
                <label class="form-label">Payment Method</label>
                <select name="method" class="form-select">
                    <option value="CASH">Cash (no fee, pending until admin confirms)</option>
                    <option value="CARD">Card (2% fee)</option>
                    <option value="ONLINE">Online (1% fee)</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Pay Now</button>
            <a class="btn btn-secondary" href="${root}/booking?action=myBookings">Back</a>
        </form>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/views/footer.jsp" %>
