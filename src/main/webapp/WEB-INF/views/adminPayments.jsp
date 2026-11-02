<%@ include file="/WEB-INF/views/header.jsp" %>

<h2>All Payments</h2>

<table class="table table-bordered">
    <tr>
        <th>Payment ID</th>
        <th>Booking ID</th>
        <th>Method</th>
        <th>Amount (Rs.)</th>
        <th>Status</th>
        <th>Date</th>
        <th>Action</th>
    </tr>
    <c:forEach var="p" items="${payments}">
        <tr>
            <td>${p.paymentId}</td>
            <td>${p.bookingId}</td>
            <td>${p.method}</td>
            <td><fmt:formatNumber value="${p.amount}" pattern="#,##0.00"/></td>
            <td>${p.status}</td>
            <td>${p.paymentDate}</td>
            <td>
                <c:if test="${p.status == 'PENDING'}">
                    <form action="${root}/payment" method="post" class="d-inline">
                        <input type="hidden" name="action" value="markPaid">
                        <input type="hidden" name="paymentId" value="${p.paymentId}">
                        <button type="submit" class="btn btn-success btn-sm">Mark as Paid</button>
                    </form>
                    <form action="${root}/payment" method="post" class="d-inline" onsubmit="return confirm('Delete this payment?');">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="paymentId" value="${p.paymentId}">
                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                    </form>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>

<%@ include file="/WEB-INF/views/footer.jsp" %>
