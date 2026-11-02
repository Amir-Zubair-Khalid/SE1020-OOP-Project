<%@ include file="/WEB-INF/views/header.jsp" %>

<h2>All Bookings</h2>

<table class="table table-bordered">
    <tr>
        <th>ID</th>
        <th>Customer</th>
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
            <td><c:out value="${b.customerName}"/></td>
            <td><c:out value="${b.vehicleName}"/></td>
            <td>${b.pickupDate}</td>
            <td>${b.returnDate}</td>
            <td>${b.actualReturnDate}</td>
            <td><fmt:formatNumber value="${b.lateFee}" pattern="#,##0.00"/></td>
            <td>${b.status}</td>
            <td>
                <c:if test="${b.status == 'BOOKED'}">
                    <a class="btn btn-warning btn-sm" href="${root}/booking?action=returnForm&bookingId=${b.bookingId}">Return</a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>

<%@ include file="/WEB-INF/views/footer.jsp" %>
