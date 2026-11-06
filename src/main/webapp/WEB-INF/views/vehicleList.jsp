<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="page-head">
    <div>
        <h1>Vehicles</h1>
        <c:choose>
            <c:when test="${sessionScope.loggedUser.admin}"><p>Add, edit or remove vehicles in the fleet.</p></c:when>
            <c:otherwise><p>Pick an available vehicle and choose your dates.</p></c:otherwise>
        </c:choose>
    </div>
    <c:if test="${sessionScope.loggedUser.admin}">
        <a class="btn btn-primary" href="${root}/vehicle?action=addForm"><i class="bi bi-plus-lg"></i> Add vehicle</a>
    </c:if>
</div>

<form action="${root}/vehicle" method="get" class="toolbar">
    <input type="hidden" name="action" value="list">
    <div class="input-icon"><i class="bi bi-search"></i>
        <input type="text" name="keyword" class="form-control" placeholder="Search brand, model or plate" value="<c:out value='${keyword}'/>" aria-label="Search">
    </div>
    <select name="type" class="form-select" aria-label="Vehicle type" onchange="this.form.submit()">
        <option value="">All types</option>
        <option value="CAR" ${type == 'CAR' ? 'selected' : ''}>Cars</option>
        <option value="VAN" ${type == 'VAN' ? 'selected' : ''}>Vans</option>
        <option value="BIKE" ${type == 'BIKE' ? 'selected' : ''}>Bikes</option>
        <option value="LUXURY" ${type == 'LUXURY' ? 'selected' : ''}>Luxury (Premium only)</option>
    </select>
    <button type="submit" class="btn btn-light">Search</button>
    <c:if test="${not empty keyword || not empty type}">
        <a class="btn btn-link text-decoration-none" href="${root}/vehicle?action=list">Clear</a>
    </c:if>
</form>

<c:choose>
    <c:when test="${empty vehicles}">
        <div class="panel empty-state">
            <i class="bi bi-car-front"></i>
            <h3>No vehicles found</h3>
            <p class="mb-0">Try a different search or vehicle type.</p>
        </div>
    </c:when>
    <c:otherwise>
        <div class="vehicle-grid">
            <c:forEach var="v" items="${vehicles}">
                <c:set var="photo" value="${fn:toLowerCase(fn:replace(v.name, ' ', '-'))}"/>
                <div class="vehicle-card ${v.status != 'AVAILABLE' ? 'unavailable' : ''} ${v.premiumOnly ? 'luxury' : ''}">
                    <div class="vehicle-visual">
                        <c:choose>
                            <c:when test="${v.type == 'VAN'}"><i class="bi bi-truck-front"></i></c:when>
                            <c:when test="${v.type == 'BIKE'}"><i class="bi bi-scooter"></i></c:when>
                            <c:when test="${v.type == 'LUXURY'}"><i class="bi bi-gem"></i></c:when>
                            <c:otherwise><i class="bi bi-car-front"></i></c:otherwise>
                        </c:choose>
                        <img src="${root}/images/vehicles/${photo}.jpg" alt="<c:out value='${v.name}'/>" loading="lazy" onerror="this.remove()">
                        <span class="type-label">${v.type}</span>
                        <span class="status status-${v.status}">${v.status}</span>
                        <c:if test="${v.premiumOnly}"><span class="lux-ribbon"><i class="bi bi-gem"></i> Premium Collection</span></c:if>
                    </div>
                    <div class="vehicle-body">
                        <h3 class="vehicle-name"><c:out value="${v.name}"/></h3>
                        <div class="vehicle-meta">
                            <span class="plate"><c:out value="${v.plateNumber}"/></span>
                            <span class="vehicle-note">
                                <c:choose>
                                    <c:when test="${v.type == 'VAN'}">+ Rs. 1,000 per booking</c:when>
                                    <c:when test="${v.premiumOnly}">Premium members</c:when>
                                    <c:otherwise>Self drive</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="vehicle-price"><b>Rs. <fmt:formatNumber value="${v.dailyRate}" pattern="#,##0"/></b> per day</div>
                        <div class="vehicle-actions">
                            <c:choose>
                                <c:when test="${sessionScope.loggedUser.admin}">
                                    <a class="btn btn-soft btn-sm" href="${root}/vehicle?action=editForm&vehicleId=${v.vehicleId}"><i class="bi bi-pencil"></i> Edit</a>
                                    <form action="${root}/vehicle" method="post" data-confirm="Delete <c:out value='${v.name}'/>?" data-confirm-text="Vehicles that have bookings can't be deleted." data-confirm-button="Delete vehicle">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="vehicleId" value="${v.vehicleId}">
                                        <button type="submit" class="btn btn-soft-danger btn-sm"><i class="bi bi-trash"></i> Delete</button>
                                    </form>
                                </c:when>
                                <c:when test="${v.premiumOnly && sessionScope.loggedUser.role != 'PREMIUM'}">
                                    <a class="btn btn-locked" href="${root}/user?action=profile" title="Upgrade your membership to book this vehicle"><i class="bi bi-gem"></i> Available to Premium members</a>
                                </c:when>
                                <c:when test="${v.status == 'AVAILABLE'}">
                                    <a class="btn btn-primary" href="${root}/booking?action=bookForm&vehicleId=${v.vehicleId}">Book now <i class="bi bi-arrow-right"></i></a>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-light" type="button" disabled>Not available</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/views/footer.jsp" %>
