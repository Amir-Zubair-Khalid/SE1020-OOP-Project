<%@ include file="/WEB-INF/views/header.jsp" %>

<section class="hero">
    <h1>Rent a car, van or bike in a few clicks.</h1>
    <p class="mt-3 mb-4">Choose a vehicle, pick your dates and pay online when you return it. Premium members save 10% on every rental.</p>
    <div class="d-flex flex-wrap gap-2 position-relative" style="z-index:1">
        <c:choose>
            <c:when test="${empty sessionScope.loggedUser}">
                <a class="btn btn-primary btn-lg" href="${root}/register.jsp"><i class="bi bi-person-plus"></i> Create an account</a>
                <a class="btn btn-outline-light btn-lg" href="${root}/login.jsp">I already have one</a>
            </c:when>
            <c:when test="${sessionScope.loggedUser.admin}">
                <a class="btn btn-primary btn-lg" href="${root}/admin?action=dashboard"><i class="bi bi-speedometer2"></i> Go to dashboard</a>
            </c:when>
            <c:otherwise>
                <a class="btn btn-primary btn-lg" href="${root}/vehicle?action=list"><i class="bi bi-search"></i> Browse vehicles</a>
                <a class="btn btn-outline-light btn-lg" href="${root}/booking?action=myBookings">My bookings</a>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<div class="type-tiles">
    <div class="type-tile">
        <i class="bi bi-car-front"></i>
        <h3>Cars</h3>
        <p>Wagon R, Aqua, Prius, Axio, Vezel and more, from Rs. 9,000 a day.</p>
    </div>
    <div class="type-tile">
        <i class="bi bi-truck-front"></i>
        <h3>Vans</h3>
        <p>Suzuki Every and Toyota KDH for groups and family trips. A flat Rs. 1,000 extra charge applies.</p>
    </div>
    <div class="type-tile">
        <i class="bi bi-scooter"></i>
        <h3>Bikes</h3>
        <p>Scooters from Rs. 2,500 a day. The cheapest way to beat the traffic.</p>
    </div>
    <div class="type-tile">
        <i class="bi bi-gem"></i>
        <h3>Luxury</h3>
        <p>Mercedes-Benz, BMW, Audi and Land Cruiser Prado. For Premium members only.</p>
    </div>
</div>

<div class="panel mt-4">
    <div class="panel-title"><i class="bi bi-signpost-2"></i> How it works</div>
    <div class="steps mt-0">
        <div class="step"><span class="step-num">1</span><div><b>Pick a vehicle</b><div class="text-muted-2">Search by brand, model or type.</div></div></div>
        <div class="step"><span class="step-num">2</span><div><b>Choose your dates</b><div class="text-muted-2">We check it's free for those days.</div></div></div>
        <div class="step"><span class="step-num">3</span><div><b>Return it</b><div class="text-muted-2">Late returns add a small daily fee.</div></div></div>
        <div class="step"><span class="step-num">4</span><div><b>Pay your invoice</b><div class="text-muted-2">Cash, card or online.</div></div></div>
    </div>
</div>

<%@ include file="/WEB-INF/views/footer.jsp" %>
