<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="page-head">
    <div>
        <h1>My payments</h1>
        <p>Card and online payments are paid straight away. Cash stays pending until an admin confirms it.</p>
    </div>
</div>

<c:choose>
    <c:when test="${empty payments}">
        <div class="panel empty-state">
            <i class="bi bi-receipt"></i>
            <h3>No payments yet</h3>
            <p>When a vehicle is returned, open its invoice from My bookings to pay.</p>
            <a class="btn btn-primary mt-2" href="${root}/booking?action=myBookings">Go to my bookings</a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="table-card">
            <div class="table-responsive">
                <table class="table table-modern">
                    <thead>
                    <tr>
                        <th>Payment</th>
                        <th>Booking</th>
                        <th>Method</th>
                        <th>Date</th>
                        <th class="num">Amount</th>
                        <th>Status</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${payments}">
                        <tr>
                            <td class="id-cell">#${p.paymentId}</td>
                            <td>Booking #${p.bookingId}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.method == 'CARD'}"><i class="bi bi-credit-card-2-front text-muted-2"></i></c:when>
                                    <c:when test="${p.method == 'ONLINE'}"><i class="bi bi-phone text-muted-2"></i></c:when>
                                    <c:otherwise><i class="bi bi-cash-stack text-muted-2"></i></c:otherwise>
                                </c:choose>
                                ${p.method}
                            </td>
                            <td>${p.paymentDate}</td>
                            <td class="num fw-semibold">Rs. <fmt:formatNumber value="${p.amount}" pattern="#,##0.00"/></td>
                            <td><span class="status status-${p.status}">${p.status}</span></td>
                            <td class="text-end"><a class="btn btn-light btn-sm" href="${root}/payment?action=pay&bookingId=${p.bookingId}">View invoice</a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/views/footer.jsp" %>
