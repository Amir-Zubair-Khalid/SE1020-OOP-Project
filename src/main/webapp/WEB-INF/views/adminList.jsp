<%@ include file="/WEB-INF/views/header.jsp" %>

<h2>Admin Accounts</h2>

<a class="btn btn-success mb-3" href="${root}/admin?action=addForm">Add Admin</a>

<table class="table table-bordered">
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Action</th>
    </tr>
    <c:forEach var="a" items="${admins}">
        <tr>
            <td>${a.userId}</td>
            <td><c:out value="${a.username}"/></td>
            <td><c:out value="${a.email}"/></td>
            <td><c:out value="${a.phone}"/></td>
            <td>
                <c:if test="${a.userId != sessionScope.loggedUser.userId}">
                    <form action="${root}/admin" method="post" onsubmit="return confirm('Delete this admin?');">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="userId" value="${a.userId}">
                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                    </form>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>

<%@ include file="/WEB-INF/views/footer.jsp" %>
