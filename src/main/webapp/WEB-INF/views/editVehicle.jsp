<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="page-head">
    <div>
        <a class="text-decoration-none small" href="${root}/vehicle?action=list"><i class="bi bi-arrow-left"></i> Back to vehicles</a>
        <h1 class="mt-1">Edit <c:out value="${vehicle.name}"/></h1>
        <p>Vehicle #${vehicle.vehicleId} &middot; <span class="plate"><c:out value="${vehicle.plateNumber}"/></span></p>
    </div>
</div>

<div class="panel form-narrow">
    <form action="${root}/vehicle" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">
        <div class="row g-3">
            <div class="col-sm-6">
                <label class="form-label" for="type">Type</label>
                <select id="type" name="type" class="form-select">
                    <option value="CAR" ${vehicle.type == 'CAR' ? 'selected' : ''}>Car</option>
                    <option value="VAN" ${vehicle.type == 'VAN' ? 'selected' : ''}>Van (+ Rs. 1,000 per booking)</option>
                    <option value="BIKE" ${vehicle.type == 'BIKE' ? 'selected' : ''}>Bike</option>
                    <option value="LUXURY" ${vehicle.type == 'LUXURY' ? 'selected' : ''}>Luxury (Premium members only)</option>
                </select>
            </div>
            <div class="col-sm-6">
                <label class="form-label" for="status">Status</label>
                <select id="status" name="status" class="form-select">
                    <option value="AVAILABLE" ${vehicle.status == 'AVAILABLE' ? 'selected' : ''}>Available</option>
                    <option value="MAINTENANCE" ${vehicle.status == 'MAINTENANCE' ? 'selected' : ''}>Maintenance</option>
                </select>
            </div>
            <div class="col-sm-6">
                <label class="form-label" for="brand">Brand</label>
                <input type="text" id="brand" name="brand" class="form-control" value="<c:out value='${vehicle.brand}'/>" required>
            </div>
            <div class="col-sm-6">
                <label class="form-label" for="model">Model</label>
                <input type="text" id="model" name="model" class="form-control" value="<c:out value='${vehicle.model}'/>" required>
            </div>
            <div class="col-sm-6">
                <label class="form-label" for="plateNumber">Plate number</label>
                <input type="text" id="plateNumber" name="plateNumber" class="form-control" value="<c:out value='${vehicle.plateNumber}'/>" style="text-transform:uppercase" required>
            </div>
            <div class="col-sm-6">
                <label class="form-label" for="dailyRate">Daily rate (Rs.)</label>
                <input type="number" id="dailyRate" name="dailyRate" class="form-control" min="1" step="0.01" value="${vehicle.dailyRate}" required>
            </div>
        </div>
        <div class="d-flex gap-2 mt-4">
            <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg"></i> Save changes</button>
            <a class="btn btn-light" href="${root}/vehicle?action=list">Cancel</a>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
