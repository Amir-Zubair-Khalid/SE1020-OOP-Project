<%@ include file="/WEB-INF/views/header.jsp" %>

<c:set var="u" value="${sessionScope.loggedUser}"/>

<h2>My Profile</h2>

<form action="${root}/user" method="post" class="col-md-5">
    <input type="hidden" name="action" value="update">
    <div class="mb-3">
        <label class="form-label">Username</label>
        <input type="text" class="form-control" value="<c:out value='${u.username}'/>" disabled>
    </div>
    <div class="mb-3">
        <label class="form-label">Email</label>
        <input type="text" name="email" class="form-control" value="<c:out value='${u.email}'/>" required>
    </div>
    <div class="mb-3">
        <label class="form-label">Phone</label>
        <input type="text" name="phone" class="form-control" value="<c:out value='${u.phone}'/>">
    </div>
    <div class="mb-3">
        <label class="form-label">Driving License Number</label>
        <input type="text" name="licenseNumber" class="form-control" value="<c:out value='${u.licenseNumber}'/>">
    </div>
    <c:if test="${not u.admin}">
        <div class="mb-3">
            <label class="form-label">Membership</label>
            <select name="membership" class="form-select">
                <option value="REGULAR" ${u.role == 'REGULAR' ? 'selected' : ''}>Regular</option>
                <option value="PREMIUM" ${u.role == 'PREMIUM' ? 'selected' : ''}>Premium (10% discount)</option>
            </select>
        </div>
    </c:if>
    <div class="mb-3">
        <label class="form-label">New Password (leave empty to keep the old one)</label>
        <input type="password" name="newPassword" class="form-control">
    </div>
    <button type="submit" class="btn btn-primary">Update Profile</button>
</form>

<%@ include file="/WEB-INF/views/footer.jsp" %>
