<%@ include file="/WEB-INF/views/header.jsp" %>

<h2>My Bookings</h2>

<table class="table table-bordered">
    <tr>
        <th>ID</th>
        <th>Vehicle</th>
        <th>Pickup</th>
        <th>Return</th>
        <th>Actual Return</th>
        <th>Late Fee (Rs.)</th>
        <th>Status</th>
        <th>Action</th>
    </tr>
    <c:forEach var="b" items="${bookings}">
        <tr>
            <td>${b.bookingId}</td>
            <td><c:out value="${b.vehicleName}"/></td>
            <td>${b.pickupDate}</td>
            <td>${b.returnDate}</td>
            <td>${b.actualReturnDate}</td>
            <td><fmt:formatNumber value="${b.lateFee}" pattern="#,##0.00"/></td>
            <td>${b.status}</td>
            <td>
                <c:if test="${b.status == 'BOOKED'}">
                    <form action="${root}/booking" method="post" class="d-inline" onsubmit="return confirm('Cancel this booking?');">
                        <input type="hidden" name="action" value="cancel">
                        <input type="hidden" name="bookingId" value="${b.bookingId}">
                        <button type="submit" class="btn btn-danger btn-sm">Cancel</button>
                    </form>
                </c:if>
                <c:if test="${b.status == 'RETURNED'}">
                    <a class="btn btn-primary btn-sm" href="${root}/payment?action=pay&bookingId=${b.bookingId}">Invoice / Pay</a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>

<%@ include file="/WEB-INF/views/footer.jsp" %>
