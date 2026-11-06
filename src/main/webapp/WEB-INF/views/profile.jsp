<%@ include file="/WEB-INF/views/header.jsp" %>

<c:set var="u" value="${sessionScope.loggedUser}"/>

<div class="page-head">
    <div>
        <h1>My profile</h1>
        <p>Update your contact details, membership or password.</p>
    </div>
</div>

<div class="row g-4">
    <div class="col-lg-4">
        <div class="panel">
            <div class="profile-card mb-3">
                <span class="profile-avatar">${fn:substring(u.username, 0, 1)}</span>
                <div>
                    <div class="fw-bold fs-5"><c:out value="${u.username}"/></div>
                    <span class="status status-${u.role}">${u.role}</span>
                </div>
            </div>
            <c:if test="${not u.admin}">
                <ul class="perk-list">
                    <li><span>Discount</span><span><fmt:formatNumber value="${u.discountRate * 100}" pattern="0"/>% off every rental</span></li>
                    <li><span>Late fee</span><span>Rs. <fmt:formatNumber value="${u.lateFeePerDay}" pattern="#,##0"/> per day</span></li>
                </ul>
                <c:if test="${u.role == 'REGULAR'}">
                    <div class="estimate mt-3"><span class="small">Switch to <b>Premium</b> to get 10% off, half the late fee and access to luxury cars (Mercedes-Benz, BMW, Audi).</span></div>
                </c:if>
            </c:if>
        </div>
    </div>
    <div class="col-lg-8">
        <div class="panel">
            <form action="${root}/user" method="post">
                <input type="hidden" name="action" value="update">
                <div class="row g-3">
                    <div class="col-sm-6">
                        <label class="form-label" for="usernameView">Username</label>
                        <input type="text" id="usernameView" class="form-control" value="<c:out value='${u.username}'/>" disabled>
                        <div class="form-hint">Usernames can't be changed</div>
                    </div>
                    <div class="col-sm-6">
                        <label class="form-label" for="email">Email</label>
                        <input type="email" id="email" name="email" class="form-control" value="<c:out value='${u.email}'/>" required>
                    </div>
                    <div class="col-sm-6">
                        <label class="form-label" for="phone">Phone</label>
                        <input type="tel" id="phone" name="phone" class="form-control" value="<c:out value='${u.phone}'/>">
                    </div>
                    <div class="col-sm-6">
                        <label class="form-label" for="licenseNumber">Driving licence no.</label>
                        <input type="text" id="licenseNumber" name="licenseNumber" class="form-control" value="<c:out value='${u.licenseNumber}'/>">
                    </div>
                    <c:if test="${not u.admin}">
                        <div class="col-sm-6">
                            <label class="form-label" for="membership">Membership</label>
                            <select id="membership" name="membership" class="form-select">
                                <option value="REGULAR" ${u.role == 'REGULAR' ? 'selected' : ''}>Regular</option>
                                <option value="PREMIUM" ${u.role == 'PREMIUM' ? 'selected' : ''}>Premium (10% off)</option>
                            </select>
                        </div>
                    </c:if>
                    <div class="col-sm-6">
                        <label class="form-label" for="newPassword">New password</label>
                        <input type="password" id="newPassword" name="newPassword" class="form-control" minlength="6" autocomplete="new-password" placeholder="Leave empty to keep current">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary mt-4"><i class="bi bi-check-lg"></i> Save changes</button>
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
