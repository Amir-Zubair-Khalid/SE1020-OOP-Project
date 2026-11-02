<%@ include file="/WEB-INF/views/header.jsp" %>

<h2>Register</h2>

<form action="${root}/user" method="post" class="col-md-5">
    <input type="hidden" name="action" value="register">
    <div class="mb-3">
        <label class="form-label">Username</label>
        <input type="text" name="username" class="form-control" required>
    </div>
    <div class="mb-3">
        <label class="form-label">Email</label>
        <input type="text" name="email" class="form-control" required>
    </div>
    <div class="mb-3">
        <label class="form-label">Password (minimum 6 characters)</label>
        <input type="password" name="password" class="form-control" required>
    </div>
    <div class="mb-3">
        <label class="form-label">Phone</label>
        <input type="text" name="phone" class="form-control">
    </div>
    <div class="mb-3">
        <label class="form-label">Driving License Number</label>
        <input type="text" name="licenseNumber" class="form-control" required>
    </div>
    <div class="mb-3">
        <label class="form-label">Membership</label>
        <select name="membership" class="form-select">
            <option value="REGULAR">Regular</option>
            <option value="PREMIUM">Premium (10% discount)</option>
        </select>
    </div>
    <button type="submit" class="btn btn-primary">Register</button>
</form>

<%@ include file="/WEB-INF/views/footer.jsp" %>
