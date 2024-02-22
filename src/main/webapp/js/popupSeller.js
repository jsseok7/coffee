document.addEventListener('DOMContentLoaded', function () {
    var sellerLikeButton = document.getElementById('sellerLikeButton');
    var cartSeller = document.getElementById('cartSeller');
    var buyNowSeller = document.getElementById('buyNowSeller');
    
    if (sellerLikeButton) {
        sellerLikeButton.addEventListener('click', function () {
            var popup = window.open('/coffee/views/sellerPopup.jsp', 'popup', 'width=600,height=400');


            popup.focus();
        });
    } 
    if (cartSeller) {
        cartSeller.addEventListener('click', function () {
            var popup = window.open('/coffee/views/sellerPopup.jsp', 'popup', 'width=600,height=400');


            popup.focus();
        });
    } 
    if (buyNowSeller) {
        buyNowSeller.addEventListener('click', function () {
            var popup = window.open('/coffee/views/sellerPopup.jsp', 'popup', 'width=600,height=400');


            popup.focus();
        });
    } 
});