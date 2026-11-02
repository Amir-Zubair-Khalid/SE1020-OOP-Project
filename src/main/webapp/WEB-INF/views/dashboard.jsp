<%@ include file="/WEB-INF/views/header.jsp" %>

<h2>Admin Dashboard</h2>

<div class="row">
    <div class="col-md-3">
        <div class="card text-center mb-3">
            <div class="card-body">
                <h6 class="card-title">Total Users</h6>
                <h3>${totalUsers}</h3>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-center mb-3">
            <div class="card-body">
                <h6 class="card-title">Total Vehicles</h6>
                <h3>${totalVehicles}</h3>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-center mb-3">
            <div class="card-body">
                <h6 class="card-title">Total Bookings</h6>
                <h3>${totalBookings}</h3>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-center mb-3">
            <div class="card-body">
                <h6 class="card-title">Revenue (Rs.)</h6>
                <h3><fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00"/></h3>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
