document.addEventListener('DOMContentLoaded', function () {
    var buyNowNon = document.getElementById('buyNowNon');
    var cartNon = document.getElementById('cartNon');
    var NonLikeButton = document.getElementById('NonLikeButton');
    
    if (buyNowNon) {
        buyNowNon.addEventListener('click', function () {
            var popup = window.open('/coffee/views/popup.jsp', 'popup', 'width=600,height=400');


            popup.focus();
        });
    } 
    if (cartNon) {
        cartNon.addEventListener('click', function () {
            var popup = window.open('/coffee/views/popup.jsp', 'popup', 'width=600,height=400');


            popup.focus();
        });
    } 
    if (NonLikeButton) {
        NonLikeButton.addEventListener('click', function () {
            var popup = window.open('/coffee/views/popup.jsp', 'popup', 'width=600,height=400');


            popup.focus();
        });
    } 
});