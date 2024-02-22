document.addEventListener('DOMContentLoaded', function () {
    var servicePopup = document.querySelectorAll('.servicePopup');

    if (servicePopup) {
        servicePopup.forEach(function (button) {
            button.addEventListener('click', function () {
                var popup = window.open('/coffee/views/servicePopup.jsp', 'popup', 'width=600,height=400');
                popup.focus();
            });
        });
    }
});
