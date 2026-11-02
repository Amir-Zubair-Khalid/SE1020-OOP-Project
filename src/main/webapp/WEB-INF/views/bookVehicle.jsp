<%@ include file="/WEB-INF/views/header.jsp" %>

<h2>Book a Vehicle</h2>

<div class="card col-md-5 mb-3">
    <div class="card-body">
        <h5 class="card-title"><c:out value="${vehicle.name}"/> (${vehicle.type})</h5>
        <p class="card-text">
            Plate: <c:out value="${vehicle.plateNumber}"/><br>
            Daily rate: Rs. <fmt:formatNumber value="${vehicle.dailyRate}" pattern="#,##0.00"/>
        </p>
    </div>
</div>

<form action="${root}/booking" method="post" class="col-md-5">
    <input type="hidden" name="action" value="book">
    <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">
    <div class="mb-3">
        <label class="form-label">Pickup Date</label>
        <input type="date" name="pickupDate" class="form-control" required>
    </div>
    <div class="mb-3">
        <label class="form-label">Return Date</label>
        <input type="date" name="returnDate" class="form-control" required>
    </div>
    <button type="submit" class="btn btn-primary">Confirm Booking</button>
    <a class="btn btn-secondary" href="${root}/vehicle?action=list">Cancel</a>
</form>

<%@ include file="/WEB-INF/views/footer.jsp" %>
