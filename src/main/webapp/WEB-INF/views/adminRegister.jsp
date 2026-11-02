<%@ include file="/WEB-INF/views/header.jsp" %>

<h2>Add Admin</h2>

<form action="${root}/admin" method="post" class="col-md-5">
    <input type="hidden" name="action" value="add">
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
    <button type="submit" class="btn btn-primary">Create Admin</button>
    <a class="btn btn-secondary" href="${root}/admin?action=list">Cancel</a>
</form>

<%@ include file="/WEB-INF/views/footer.jsp" %>
