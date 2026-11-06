<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="auth-wrap">
    <div class="auth-side">
        <div>
            <span class="brand-plate">VRS</span>
            <h2 class="mt-3">Welcome back</h2>
            <p>Log in to book vehicles, see your bookings and pay your invoices.</p>
        </div>
        <ul>
            <li><i class="bi bi-check2-circle"></i>Cars, vans and bikes</li>
            <li><i class="bi bi-check2-circle"></i>Instant availability check</li>
            <li><i class="bi bi-check2-circle"></i>Pay by cash, card or online</li>
        </ul>
    </div>
    <div class="auth-form">
        <h1>Log in</h1>
        <p class="text-muted-2 mb-4">Enter your username and password.</p>
        <form action="${root}/user" method="post">
            <input type="hidden" name="action" value="login">
            <div class="mb-3">
                <label class="form-label" for="username">Username</label>
                <div class="input-icon"><i class="bi bi-person"></i>
                    <input type="text" id="username" name="username" class="form-control" autocomplete="username" required autofocus>
                </div>
            </div>
            <div class="mb-4">
                <label class="form-label" for="password">Password</label>
                <div class="input-icon"><i class="bi bi-lock"></i>
                    <input type="password" id="password" name="password" class="form-control" autocomplete="current-password" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary w-100 justify-content-center py-2">Log in <i class="bi bi-arrow-right"></i></button>
        </form>
        <p class="mt-4 mb-0 text-center text-muted-2">New here? <a href="${root}/register.jsp">Create an account</a></p>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
