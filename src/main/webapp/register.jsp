<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="auth-wrap">
    <div class="auth-side">
        <div>
            <span class="brand-plate">VRS</span>
            <h2 class="mt-3">Create your account</h2>
            <p>It takes a minute. You'll need your driving licence number.</p>
        </div>
        <div>
            <p class="mb-2"><b class="text-white">Regular</b> - standard prices, Rs. 1,000 per late day</p>
            <p class="mb-0"><b class="text-white">Premium</b> - 10% off every rental, Rs. 500 per late day, and luxury cars</p>
        </div>
    </div>
    <div class="auth-form">
        <h1>Register</h1>
        <p class="text-muted-2 mb-4">Fields marked * are required.</p>
        <form action="${root}/user" method="post">
            <input type="hidden" name="action" value="register">
            <div class="row g-3">
                <div class="col-sm-6">
                    <label class="form-label" for="username">Username *</label>
                    <input type="text" id="username" name="username" class="form-control" autocomplete="username" required>
                </div>
                <div class="col-sm-6">
                    <label class="form-label" for="email">Email *</label>
                    <input type="email" id="email" name="email" class="form-control" autocomplete="email" placeholder="you@example.com" required>
                </div>
                <div class="col-sm-6">
                    <label class="form-label" for="password">Password *</label>
                    <input type="password" id="password" name="password" class="form-control" minlength="6" autocomplete="new-password" required>
                    <div class="form-hint">At least 6 characters</div>
                </div>
                <div class="col-sm-6">
                    <label class="form-label" for="phone">Phone</label>
                    <input type="tel" id="phone" name="phone" class="form-control" placeholder="077 123 4567">
                </div>
                <div class="col-sm-6">
                    <label class="form-label" for="licenseNumber">Driving licence no. *</label>
                    <input type="text" id="licenseNumber" name="licenseNumber" class="form-control" placeholder="B1234567" required>
                </div>
                <div class="col-sm-6">
                    <label class="form-label" for="membership">Membership</label>
                    <select id="membership" name="membership" class="form-select">
                        <option value="REGULAR">Regular</option>
                        <option value="PREMIUM">Premium (10% off + luxury cars)</option>
                    </select>
                </div>
            </div>
            <button type="submit" class="btn btn-primary w-100 justify-content-center py-2 mt-4">Create account</button>
        </form>
        <p class="mt-4 mb-0 text-center text-muted-2">Already registered? <a href="${root}/login.jsp">Log in</a></p>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
