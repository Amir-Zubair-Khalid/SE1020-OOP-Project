<%@ include file="/WEB-INF/views/header.jsp" %>

<div class="page-head">
    <div>
        <a class="text-decoration-none small" href="${root}/vehicle?action=list"><i class="bi bi-arrow-left"></i> Back to vehicles</a>
        <h1 class="mt-1">Book <c:out value="${vehicle.name}"/></h1>
        <p>Choose when you'll pick it up and bring it back.</p>
    </div>
</div>

<div class="row g-4">
    <div class="col-lg-7">
        <div class="panel">
            <div class="panel-title"><i class="bi bi-calendar-range"></i> Your dates</div>
            <form action="${root}/booking" method="post" id="bookForm">
                <input type="hidden" name="action" value="book">
                <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">
                <div class="row g-3">
                    <div class="col-sm-6">
                        <label class="form-label" for="pickupDate">Pickup date</label>
                        <input type="date" id="pickupDate" name="pickupDate" class="form-control" value="${param.pickupDate}" data-min-today required>
                    </div>
                    <div class="col-sm-6">
                        <label class="form-label" for="returnDate">Return date</label>
                        <input type="date" id="returnDate" name="returnDate" class="form-control" value="${param.returnDate}" data-min-today required>
                    </div>
                </div>
                <div class="estimate mt-4">
                    <div>
                        <div class="fw-semibold">Estimated price</div>
                        <div class="form-hint mt-0" id="estimateNote">Pick both dates to see the price.</div>
                    </div>
                    <b id="estimateTotal">&ndash;</b>
                </div>
                <div class="form-hint mt-2"><i class="bi bi-info-circle"></i> You pay when you return the vehicle. Late returns add a daily late fee.</div>
                <div class="d-flex gap-2 mt-4">
                    <button type="submit" class="btn btn-primary"><i class="bi bi-check2-circle"></i> Confirm booking</button>
                    <a class="btn btn-light" href="${root}/vehicle?action=list">Cancel</a>
                </div>
            </form>
        </div>
    </div>
    <div class="col-lg-5">
        <div class="panel">
            <div class="book-photo">
                <c:choose>
                    <c:when test="${vehicle.type == 'VAN'}"><i class="bi bi-truck-front"></i></c:when>
                    <c:when test="${vehicle.type == 'BIKE'}"><i class="bi bi-scooter"></i></c:when>
                    <c:when test="${vehicle.type == 'LUXURY'}"><i class="bi bi-gem"></i></c:when>
                    <c:otherwise><i class="bi bi-car-front"></i></c:otherwise>
                </c:choose>
                <img src="${root}/images/vehicles/${fn:toLowerCase(fn:replace(vehicle.name, ' ', '-'))}.jpg" alt="<c:out value='${vehicle.name}'/>" onerror="this.remove()">
            </div>
            <c:if test="${vehicle.premiumOnly}">
                <div class="alert alert-info flash mb-3"><i class="bi bi-gem"></i> Part of our Premium Collection, available exclusively to Premium members.</div>
            </c:if>
            <div class="summary">
                <div class="summary-row"><span>Vehicle</span><span><c:out value="${vehicle.name}"/></span></div>
                <div class="summary-row"><span>Type</span><span>${vehicle.type}</span></div>
                <div class="summary-row"><span>Plate</span><span class="plate"><c:out value="${vehicle.plateNumber}"/></span></div>
                <div class="summary-row"><span>Daily rate</span><span>Rs. <fmt:formatNumber value="${vehicle.dailyRate}" pattern="#,##0.00"/></span></div>
                <c:if test="${vehicle.type == 'VAN'}">
                    <div class="summary-row"><span>Van charge</span><span>Rs. 1,000.00</span></div>
                </c:if>
                <div class="summary-row"><span>Your discount</span><span><fmt:formatNumber value="${sessionScope.loggedUser.discountRate * 100}" pattern="0"/>% (${sessionScope.loggedUser.role})</span></div>
            </div>
        </div>
    </div>
</div>

<script>
(function () {
    var rate = ${vehicle.dailyRate};
    var extra = ${vehicle.type == 'VAN' ? 1000 : 0};
    var discount = ${sessionScope.loggedUser.discountRate};
    var p = document.getElementById('pickupDate'), r = document.getElementById('returnDate');
    var out = document.getElementById('estimateTotal'), note = document.getElementById('estimateNote');
    function toDays(a, b) { return Math.round((Date.parse(b) - Date.parse(a)) / 86400000); }
    function update() {
        if (p.value) r.min = p.value;
        if (!p.value || !r.value) { out.textContent = '–'; note.textContent = 'Pick both dates to see the price.'; return; }
        var days = toDays(p.value, r.value);
        if (days < 1) { out.textContent = '–'; note.textContent = 'Return date must be after the pickup date.'; return; }
        var rent = rate * days + extra;
        var total = rent - rent * discount;
        out.textContent = 'Rs. ' + total.toLocaleString('en-LK', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        note.textContent = days + (days === 1 ? ' day' : ' days') + (discount > 0 ? ', ' + Math.round(discount * 100) + '% member discount applied' : '');
    }
    p.addEventListener('change', update); r.addEventListener('change', update); update();
})();
</script>

<%@ include file="/WEB-INF/views/footer.jsp" %>
