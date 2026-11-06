<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="page-head">
    <div>
        <a class="text-decoration-none small" href="${root}/vehicle?action=list"><i class="bi bi-arrow-left"></i> Back to vehicles</a>
        <h1 class="mt-1">Add a vehicle</h1>
        <p>New vehicles appear in the customer list straight away if they're available.</p>
    </div>
</div>

<div class="panel form-narrow">
    <form action="${root}/vehicle" method="post">
        <input type="hidden" name="action" value="add">
        <div class="row g-3">
            <div class="col-sm-6">
                <label class="form-label" for="type">Type</label>
                <select id="type" name="type" class="form-select">
                    <option value="CAR">Car</option>
                    <option value="VAN">Van (+ Rs. 1,000 per booking)</option>
                    <option value="BIKE">Bike</option>
                    <option value="LUXURY">Luxury (Premium members only)</option>
                </select>
            </div>
            <div class="col-sm-6">
                <label class="form-label" for="status">Status</label>
                <select id="status" name="status" class="form-select">
                    <option value="AVAILABLE">Available</option>
                    <option value="MAINTENANCE">Maintenance</option>
                </select>
            </div>
            <div class="col-sm-6">
                <label class="form-label" for="brand">Brand</label>
                <input type="text" id="brand" name="brand" class="form-control" placeholder="Toyota" required>
            </div>
            <div class="col-sm-6">
                <label class="form-label" for="model">Model</label>
                <input type="text" id="model" name="model" class="form-control" placeholder="Axio" required>
            </div>
            <div class="col-sm-6">
                <label class="form-label" for="plateNumber">Plate number</label>
                <input type="text" id="plateNumber" name="plateNumber" class="form-control" placeholder="CAB-1234" style="text-transform:uppercase" required>
                <div class="form-hint">Must be unique</div>
            </div>
            <div class="col-12 form-hint mt-0">To show a photo, add <code>images/vehicles/brand-model.jpg</code> (lowercase, spaces as dashes), e.g. <code>toyota-axio.jpg</code>.</div>
            <div class="col-sm-6">
                <label class="form-label" for="dailyRate">Daily rate (Rs.)</label>
                <input type="number" id="dailyRate" name="dailyRate" class="form-control" min="1" step="0.01" placeholder="5000" required>
            </div>
        </div>
        <div class="d-flex gap-2 mt-4">
            <button type="submit" class="btn btn-primary"><i class="bi bi-plus-lg"></i> Add vehicle</button>
            <a class="btn btn-light" href="${root}/vehicle?action=list">Cancel</a>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
