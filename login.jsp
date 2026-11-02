<%@ include file="/WEB-INF/views/header.jsp" %>

<h2>Login</h2>

<form action="${root}/user" method="post" class="col-md-4">
    <input type="hidden" name="action" value="login">
    <div class="mb-3">
        <label class="form-label">Username</label>
        <input type="text" name="username" class="form-control" required>
    </div>
    <div class="mb-3">
        <label class="form-label">Password</label>
        <input type="password" name="password" class="form-control" required>
    </div>
    <button type="submit" class="btn btn-primary">Login</button>
</form>

<p class="mt-3">No account? <a href="${root}/register.jsp">Register here</a></p>

<%@ include file="/WEB-INF/views/footer.jsp" %>
