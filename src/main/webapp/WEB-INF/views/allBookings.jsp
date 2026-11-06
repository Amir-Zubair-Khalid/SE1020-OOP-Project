<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="page-head">
    <div>
        <h1>All bookings</h1>
        <p>Process returns here. The late fee depends on the customer's membership.</p>
    </div>
</div>

<c:choose>
    <c:when test="${empty bookings}">
        <div class="panel empty-state">
            <i class="bi bi-calendar-x"></i>
            <h3>No bookings yet</h3>
            <p class="mb-0">Bookings will show here when customers make them.</p>
        </div>
    </c:when>
    <c:otherwise>
        <div class="table-card">
            <div class="table-responsive">
                <table class="table table-modern">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Customer</th>
                        <th>Vehicle</th>
                        <th>Pickup</th>
                        <th>Return</th>
                        <th>Returned on</th>
                        <th class="num">Late fee</th>
                        <th>Status</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="b" items="${bookings}">
                        <tr>
                            <td class="id-cell">${b.bookingId}</td>
                            <td><i class="bi bi-person text-muted-2"></i> <c:out value="${b.customerName}"/></td>
                            <td class="fw-semibold"><c:out value="${b.vehicleName}"/></td>
                            <td>${b.pickupDate}</td>
                            <td>${b.returnDate}</td>
                            <td>${empty b.actualReturnDate ? '<span class="text-muted-2">&ndash;</span>' : b.actualReturnDate}</td>
                            <td class="num">Rs. <fmt:formatNumber value="${b.lateFee}" pattern="#,##0.00"/></td>
                            <td><span class="status status-${b.status}">${b.status}</span></td>
                            <td class="text-end">
                                <c:if test="${b.status == 'BOOKED'}">
                                    <a class="btn btn-soft btn-sm" href="${root}/booking?action=returnForm&bookingId=${b.bookingId}"><i class="bi bi-box-arrow-in-down"></i> Process return</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/views/footer.jsp" %>
