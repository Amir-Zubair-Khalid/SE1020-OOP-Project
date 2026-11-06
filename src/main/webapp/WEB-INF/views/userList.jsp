<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="page-head">
    <div>
        <h1>Customers</h1>
        <p>Regular and premium customers. Customers with bookings can't be deleted.</p>
    </div>
</div>

<form action="${root}/user" method="get" class="toolbar">
    <input type="hidden" name="action" value="list">
    <div class="input-icon"><i class="bi bi-search"></i>
        <input type="text" name="keyword" class="form-control" placeholder="Search username or email" value="<c:out value='${keyword}'/>" aria-label="Search customers">
    </div>
    <button type="submit" class="btn btn-light">Search</button>
    <c:if test="${not empty keyword}"><a class="btn btn-link text-decoration-none" href="${root}/user?action=list">Clear</a></c:if>
</form>

<c:choose>
    <c:when test="${empty users}">
        <div class="panel empty-state">
            <i class="bi bi-people"></i>
            <h3>No customers found</h3>
            <p class="mb-0">${empty keyword ? 'Customers appear here after they register.' : 'Try a different search.'}</p>
        </div>
    </c:when>
    <c:otherwise>
        <div class="table-card">
            <div class="table-responsive">
                <table class="table table-modern">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Customer</th>
                        <th>Phone</th>
                        <th>Licence</th>
                        <th>Membership</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td class="id-cell">${u.userId}</td>
                            <td>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="user-avatar" style="width:32px;height:32px;font-size:13px">${fn:substring(u.username, 0, 1)}</span>
                                    <div><div class="fw-semibold"><c:out value="${u.username}"/></div><div class="text-muted-2 small"><c:out value="${u.email}"/></div></div>
                                </div>
                            </td>
                            <td><c:out value="${u.phone}"/></td>
                            <td><c:out value="${u.licenseNumber}"/></td>
                            <td><span class="status status-${u.role}">${u.role}</span></td>
                            <td class="text-end">
                                <form action="${root}/user" method="post" class="d-inline" data-confirm="Delete ${fn:escapeXml(u.username)}?" data-confirm-text="Customers who have bookings can't be deleted." data-confirm-button="Delete customer">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="userId" value="${u.userId}">
                                    <button type="submit" class="btn btn-soft-danger btn-sm"><i class="bi bi-trash"></i> Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/views/footer.jsp" %>
