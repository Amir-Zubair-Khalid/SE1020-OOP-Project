<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="page-head">
    <div>
        <h1>My bookings</h1>
        <p>Once a vehicle is returned, you can open its invoice and pay here.</p>
    </div>
    <a class="btn btn-primary" href="${root}/vehicle?action=list"><i class="bi bi-plus-lg"></i> New booking</a>
</div>

<c:choose>
    <c:when test="${empty bookings}">
        <div class="panel empty-state">
            <i class="bi bi-calendar-x"></i>
            <h3>No bookings yet</h3>
            <p>Find a vehicle and book your first trip.</p>
            <a class="btn btn-primary mt-2" href="${root}/vehicle?action=list">Browse vehicles</a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="table-card">
            <div class="table-responsive">
                <table class="table table-modern">
                    <thead>
                    <tr>
                        <th>#</th>
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
                            <td class="fw-semibold"><c:out value="${b.vehicleName}"/></td>
                            <td>${b.pickupDate}</td>
                            <td>${b.returnDate}</td>
                            <td>${empty b.actualReturnDate ? '<span class="text-muted-2">&ndash;</span>' : b.actualReturnDate}</td>
                            <td class="num ${b.lateFee > 0 ? 'text-danger fw-semibold' : 'text-muted-2'}">Rs. <fmt:formatNumber value="${b.lateFee}" pattern="#,##0.00"/></td>
                            <td><span class="status status-${b.status}">${b.status}</span></td>
                            <td class="text-end">
                                <c:if test="${b.status == 'BOOKED'}">
                                    <form action="${root}/booking" method="post" class="d-inline" data-confirm="Cancel this booking?" data-confirm-text="Booking #${b.bookingId} for ${fn:escapeXml(b.vehicleName)} will be cancelled." data-confirm-button="Cancel booking">
                                        <input type="hidden" name="action" value="cancel">
                                        <input type="hidden" name="bookingId" value="${b.bookingId}">
                                        <button type="submit" class="btn btn-soft-danger btn-sm"><i class="bi bi-x-lg"></i> Cancel</button>
                                    </form>
                                </c:if>
                                <c:if test="${b.status == 'RETURNED'}">
                                    <a class="btn btn-primary btn-sm" href="${root}/payment?action=pay&bookingId=${b.bookingId}"><i class="bi bi-receipt"></i> Invoice / Pay</a>
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
