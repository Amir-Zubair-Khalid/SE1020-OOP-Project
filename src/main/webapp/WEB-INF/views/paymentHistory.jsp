<%@ include file="/WEB-INF/views/header.jsp" %>

<h2>My Payments</h2>

<table class="table table-bordered">
    <tr>
        <th>Payment ID</th>
        <th>Booking ID</th>
        <th>Method</th>
        <th>Amount (Rs.)</th>
        <th>Status</th>
        <th>Date</th>
    </tr>
    <c:forEach var="p" items="${payments}">
        <tr>
            <td>${p.paymentId}</td>
            <td>${p.bookingId}</td>
            <td>${p.method}</td>
            <td><fmt:formatNumber value="${p.amount}" pattern="#,##0.00"/></td>
            <td>${p.status}</td>
            <td>${p.paymentDate}</td>
        </tr>
    </c:forEach>
</table>

<%@ include file="/WEB-INF/views/footer.jsp" %>
