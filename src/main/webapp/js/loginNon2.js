document.addEventListener('DOMContentLoaded', function () {
    var NonLikeButtons = document.querySelectorAll('.NonLikeButton');

    if (NonLikeButtons) {
        NonLikeButtons.forEach(function (button) {
            button.addEventListener('click', function () {
                var popup = window.open('/coffee/views/popup.jsp', 'popup', 'width=600,height=400');
                popup.focus();
            });
        });
    }
});
