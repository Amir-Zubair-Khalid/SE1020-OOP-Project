</div>
</main>

<footer class="app-footer">
    <div class="container d-flex flex-wrap justify-content-between gap-2">
        <span><b>DriveEasy</b> Vehicle Rental System</span>
        <span>Cars, vans and bikes across Sri Lanka &middot; <a href="${root}/images/vehicles/credits.html">Photo credits</a></span>
    </div>
</footer>

<%-- Confirm pop-up used by any form with data-confirm="..." (replaces the browser's confirm box) --%>
<div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content p-2">
            <div class="modal-body">
                <div class="modal-icon"><i class="bi bi-exclamation-triangle"></i></div>
                <h5 class="mb-1" id="confirmTitle">Are you sure?</h5>
                <p class="text-muted-2 mb-0" id="confirmText">This can't be undone.</p>
            </div>
            <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Go back</button>
                <button type="button" class="btn btn-danger" id="confirmOk">Yes, continue</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
(function () {
    // 1. Confirm pop-up for delete / cancel forms
    var pending = null;
    var modalEl = document.getElementById('confirmModal');
    var modal = (window.bootstrap && modalEl) ? new bootstrap.Modal(modalEl) : null;
    document.querySelectorAll('form[data-confirm]').forEach(function (form) {
        form.addEventListener('submit', function (e) {
            if (form.dataset.confirmed === 'yes') return;
            e.preventDefault();
            if (!modal) { if (window.confirm(form.dataset.confirm)) { form.dataset.confirmed = 'yes'; form.submit(); } return; }
            pending = form;
            document.getElementById('confirmTitle').textContent = form.dataset.confirm;
            document.getElementById('confirmText').textContent = form.dataset.confirmText || "This can't be undone.";
            document.getElementById('confirmOk').textContent = form.dataset.confirmButton || 'Yes, continue';
            modal.show();
        });
    });
    var ok = document.getElementById('confirmOk');
    if (ok) ok.addEventListener('click', function () {
        if (pending) { pending.dataset.confirmed = 'yes'; pending.submit(); }
    });

    // 2. Success messages fade away after 5 seconds
    document.querySelectorAll('.flash.alert-success').forEach(function (el) {
        setTimeout(function () { if (window.bootstrap) bootstrap.Alert.getOrCreateInstance(el).close(); }, 5000);
    });

    // 3. Date inputs with data-min-today can't pick a past date
    var t = new Date();
    var today = t.getFullYear() + '-' + String(t.getMonth() + 1).padStart(2, '0') + '-' + String(t.getDate()).padStart(2, '0');
    document.querySelectorAll('input[type=date][data-min-today]').forEach(function (el) { el.min = today; });
})();
</script>
</body>
</html>
