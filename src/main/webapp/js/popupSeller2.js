document.addEventListener('DOMContentLoaded', function () {
    var likeButtons = document.querySelectorAll('.myPageLike__button');

    if (likeButtons) {
        likeButtons.forEach(function (button) {
            button.addEventListener('click', function () {
                var popup = window.open('/coffee/views/sellerPopup.jsp', 'popup', 'width=600,height=400');
                popup.focus();
            });
        });
    }
});
