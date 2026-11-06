<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="page-head">
    <div>
        <a class="text-decoration-none small" href="${root}/admin?action=list"><i class="bi bi-arrow-left"></i> Back to admins</a>
        <h1 class="mt-1">Add an admin</h1>
        <p>Admins can manage vehicles, customers, bookings and payments.</p>
    </div>
</div>

<div class="panel form-narrow">
    <form action="${root}/admin" method="post">
        <input type="hidden" name="action" value="add">
        <div class="row g-3">
            <div class="col-sm-6">
                <label class="form-label" for="username">Username *</label>
                <input type="text" id="username" name="username" class="form-control" value="<c:out value='${param.username}'/>" required>
            </div>
            <div class="col-sm-6">
                <label class="form-label" for="email">Email *</label>
                <input type="email" id="email" name="email" class="form-control" value="<c:out value='${param.email}'/>" required>
            </div>
            <div class="col-sm-6">
                <label class="form-label" for="password">Password *</label>
                <input type="password" id="password" name="password" class="form-control" minlength="6" autocomplete="new-password" required>
                <div class="form-hint">At least 6 characters</div>
            </div>
            <div class="col-sm-6">
                <label class="form-label" for="phone">Phone</label>
                <input type="tel" id="phone" name="phone" class="form-control" value="<c:out value='${param.phone}'/>">
            </div>
        </div>
        <div class="d-flex gap-2 mt-4">
            <button type="submit" class="btn btn-primary"><i class="bi bi-person-plus"></i> Create admin</button>
            <a class="btn btn-light" href="${root}/admin?action=list">Cancel</a>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
