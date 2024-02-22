
document.addEventListener('DOMContentLoaded', function () {
    var popupButton = document.getElementById('popupButton');
    
    if (popupButton) {
        popupButton.addEventListener('click', function () {
            var popup = window.open('/coffee/views/popup.jsp', 'popup', 'width=600,height=400');


            popup.focus();
        });
    } 
});
