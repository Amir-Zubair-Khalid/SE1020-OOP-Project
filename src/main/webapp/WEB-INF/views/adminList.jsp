<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="page-head">
    <div>
        <h1>Admin accounts</h1>
        <p>People who can manage the system. You can't delete your own account.</p>
    </div>
    <a class="btn btn-primary" href="${root}/admin?action=addForm"><i class="bi bi-person-plus"></i> Add admin</a>
</div>

<div class="table-card">
    <div class="table-responsive">
        <table class="table table-modern">
            <thead>
            <tr>
                <th>#</th>
                <th>Admin</th>
                <th>Phone</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="a" items="${admins}">
                <tr>
                    <td class="id-cell">${a.userId}</td>
                    <td>
                        <div class="d-flex align-items-center gap-2">
                            <span class="user-avatar" style="width:32px;height:32px;font-size:13px">${fn:substring(a.username, 0, 1)}</span>
                            <div>
                                <div class="fw-semibold"><c:out value="${a.username}"/>
                                    <c:if test="${a.userId == sessionScope.loggedUser.userId}"><span class="status status-BOOKED ms-1">You</span></c:if>
                                </div>
                                <div class="text-muted-2 small"><c:out value="${a.email}"/></div>
                            </div>
                        </div>
                    </td>
                    <td><c:out value="${a.phone}"/></td>
                    <td class="text-end">
                        <c:if test="${a.userId != sessionScope.loggedUser.userId}">
                            <form action="${root}/admin" method="post" class="d-inline" data-confirm="Delete admin ${fn:escapeXml(a.username)}?" data-confirm-text="They will no longer be able to log in." data-confirm-button="Delete admin">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="userId" value="${a.userId}">
                                <button type="submit" class="btn btn-soft-danger btn-sm"><i class="bi bi-trash"></i> Delete</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
