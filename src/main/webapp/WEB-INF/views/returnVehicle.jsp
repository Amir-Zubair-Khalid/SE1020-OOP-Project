<%@ include file="/WEB-INF/views/header.jsp" %>

<h2>Return Vehicle</h2>

<div class="card col-md-5 mb-3">
    <div class="card-body">
        <p class="card-text">
            Booking ID: ${booking.bookingId}<br>
            Customer: <c:out value="${booking.customerName}"/><br>
            Vehicle: <c:out value="${booking.vehicleName}"/><br>
            Pickup date: ${booking.pickupDate}<br>
            Agreed return date: ${booking.returnDate}
        </p>
    </div>
</div>

<form action="${root}/booking" method="post" class="col-md-5">
    <input type="hidden" name="action" value="return">
    <input type="hidden" name="bookingId" value="${booking.bookingId}">
    <div class="mb-3">
        <label class="form-label">Actual Return Date</label>
        <input type="date" name="actualReturnDate" class="form-control" value="${today}" required>
    </div>
    <button type="submit" class="btn btn-primary">Confirm Return</button>
    <a class="btn btn-secondary" href="${root}/booking?action=all">Cancel</a>
</form>

<%@ include file="/WEB-INF/views/footer.jsp" %>
