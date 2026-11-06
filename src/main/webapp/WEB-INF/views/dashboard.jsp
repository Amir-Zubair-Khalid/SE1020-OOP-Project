<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="page-head">
    <div>
        <h1>Dashboard</h1>
        <p>Welcome back, <c:out value="${sessionScope.loggedUser.username}"/>. Here's how the business is doing.</p>
    </div>
</div>

<div class="stat-grid">
    <div class="stat-card">
        <div class="stat-icon" style="background:var(--info-bg);color:var(--brand)"><i class="bi bi-people"></i></div>
        <div><div class="stat-label">Users</div><div class="stat-value">${totalUsers}</div></div>
    </div>
    <div class="stat-card">
        <div class="stat-icon" style="background:#efe9ff;color:#6b46c1"><i class="bi bi-car-front"></i></div>
        <div><div class="stat-label">Vehicles</div><div class="stat-value">${totalVehicles}</div></div>
    </div>
    <div class="stat-card">
        <div class="stat-icon" style="background:var(--warn-bg);color:var(--warn)"><i class="bi bi-calendar-check"></i></div>
        <div><div class="stat-label">Bookings</div><div class="stat-value">${totalBookings}</div></div>
    </div>
    <div class="stat-card">
        <div class="stat-icon" style="background:var(--good-bg);color:var(--good)"><i class="bi bi-cash-coin"></i></div>
        <div><div class="stat-label">Revenue (paid)</div><div class="stat-value">Rs. <fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/></div></div>
    </div>
</div>

<div class="panel mt-4">
    <div class="panel-title"><i class="bi bi-lightning-charge"></i> Quick actions</div>
    <div class="quick-links">
        <a class="quick-link" href="${root}/booking?action=all"><i class="bi bi-box-arrow-in-down"></i><div><b>Process returns</b><div class="text-muted-2 small">Mark vehicles as returned</div></div></a>
        <a class="quick-link" href="${root}/payment?action=all"><i class="bi bi-cash-stack"></i><div><b>Confirm cash payments</b><div class="text-muted-2 small">Mark pending payments as paid</div></div></a>
        <a class="quick-link" href="${root}/vehicle?action=addForm"><i class="bi bi-plus-circle"></i><div><b>Add a vehicle</b><div class="text-muted-2 small">Grow the fleet</div></div></a>
        <a class="quick-link" href="${root}/user?action=list"><i class="bi bi-search"></i><div><b>Find a customer</b><div class="text-muted-2 small">Search by name or email</div></div></a>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
