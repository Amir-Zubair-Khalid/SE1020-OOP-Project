<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="page-head">
    <div>
        <a class="text-decoration-none small" href="${root}/booking?action=all"><i class="bi bi-arrow-left"></i> Back to bookings</a>
        <h1 class="mt-1">Return booking #${booking.bookingId}</h1>
        <p>Enter the date the vehicle actually came back. Late days are charged at the customer's daily late fee.</p>
    </div>
</div>

<div class="row g-4">
    <div class="col-lg-5 order-lg-2">
        <div class="panel">
            <div class="panel-title"><i class="bi bi-card-checklist"></i> Booking details</div>
            <div class="summary">
                <div class="summary-row"><span>Customer</span><span><c:out value="${booking.customerName}"/></span></div>
                <div class="summary-row"><span>Vehicle</span><span><c:out value="${booking.vehicleName}"/></span></div>
                <div class="summary-row"><span>Pickup date</span><span>${booking.pickupDate}</span></div>
                <div class="summary-row"><span>Agreed return</span><span>${booking.returnDate}</span></div>
                <div class="summary-row"><span>Rental days</span><span>${booking.days}</span></div>
            </div>
        </div>
    </div>
    <div class="col-lg-7 order-lg-1">
        <div class="panel">
            <div class="panel-title"><i class="bi bi-box-arrow-in-down"></i> Confirm return</div>
            <form action="${root}/booking" method="post">
                <input type="hidden" name="action" value="return">
                <input type="hidden" name="bookingId" value="${booking.bookingId}">
                <label class="form-label" for="actualReturnDate">Actual return date</label>
                <input type="date" id="actualReturnDate" name="actualReturnDate" class="form-control" style="max-width:260px" value="${today}" min="${booking.pickupDate}" required>
                <div class="form-hint" id="lateNote">Due back on ${booking.returnDate}.</div>
                <div class="d-flex gap-2 mt-4">
                    <button type="submit" class="btn btn-primary"><i class="bi bi-check2-circle"></i> Confirm return</button>
                    <a class="btn btn-light" href="${root}/booking?action=all">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
(function () {
    var due = '${booking.returnDate}', input = document.getElementById('actualReturnDate'), note = document.getElementById('lateNote');
    function update() {
        if (!input.value) return;
        var late = Math.round((Date.parse(input.value) - Date.parse(due)) / 86400000);
        note.innerHTML = late > 0 ? '<span class="text-danger fw-semibold">' + late + (late === 1 ? ' day' : ' days') + ' late</span> - a late fee will be added.' : 'On time - no late fee.';
    }
    input.addEventListener('change', update); update();
})();
</script>

<%@ include file="/WEB-INF/views/footer.jsp" %>
