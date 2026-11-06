<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="page-head">
    <div>
        <h1>Payments</h1>
        <p>Confirm cash payments once the money is received. Only pending payments can be changed or deleted.</p>
    </div>
</div>

<c:choose>
    <c:when test="${empty payments}">
        <div class="panel empty-state">
            <i class="bi bi-credit-card"></i>
            <h3>No payments yet</h3>
            <p class="mb-0">Payments show here after customers pay their invoices.</p>
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
                            <td>${p.method} <span class="text-muted-2 small">(<fmt:formatNumber value="${p.feePercent}" pattern="0"/>% fee)</span></td>
                            <td>${p.paymentDate}</td>
                            <td class="num fw-semibold">Rs. <fmt:formatNumber value="${p.amount}" pattern="#,##0.00"/></td>
                            <td><span class="status status-${p.status}">${p.status}</span></td>
                            <td class="text-end">
                                <c:if test="${p.status == 'PENDING'}">
                                    <form action="${root}/payment" method="post" class="d-inline">
                                        <input type="hidden" name="action" value="markPaid">
                                        <input type="hidden" name="paymentId" value="${p.paymentId}">
                                        <button type="submit" class="btn btn-soft-success btn-sm"><i class="bi bi-check-lg"></i> Mark as paid</button>
                                    </form>
                                    <form action="${root}/payment" method="post" class="d-inline" data-confirm="Delete payment #${p.paymentId}?" data-confirm-text="The customer will be able to pay this booking again." data-confirm-button="Delete payment">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="paymentId" value="${p.paymentId}">
                                        <button type="submit" class="btn btn-soft-danger btn-sm" title="Delete payment" aria-label="Delete payment"><i class="bi bi-trash"></i></button>
                                    </form>
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
