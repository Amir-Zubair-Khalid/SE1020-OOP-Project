<%@ include file="/WEB-INF/views/header.jsp" %>

<h2>Customers</h2>

<form action="${root}/user" method="get" class="row g-2 mb-3">
    <input type="hidden" name="action" value="list">
    <div class="col-auto">
        <input type="text" name="keyword" class="form-control" placeholder="Username or email" value="<c:out value='${keyword}'/>">
    </div>
    <div class="col-auto">
        <button type="submit" class="btn btn-primary">Search</button>
    </div>
</form>

<table class="table table-bordered">
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Phone</th>
        <th>License</th>
        <th>Membership</th>
        <th>Action</th>
    </tr>
    <c:forEach var="u" items="${users}">
        <tr>
            <td>${u.userId}</td>
            <td><c:out value="${u.username}"/></td>
            <td><c:out value="${u.email}"/></td>
            <td><c:out value="${u.phone}"/></td>
            <td><c:out value="${u.licenseNumber}"/></td>
            <td>${u.role}</td>
            <td>
                <form action="${root}/user" method="post" onsubmit="return confirm('Delete this customer?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="userId" value="${u.userId}">
                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

<%@ include file="/WEB-INF/views/footer.jsp" %>
