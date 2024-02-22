
function cartHandler() {
    	let qty1 = document.querySelector('.cartProductInfo__QtyText');
    	let hiddenForm = document.querySelector('#hiddenForm');
    	let qty = document.querySelector('#qty');

    	if (confirm('장바구니에 추가하시겠습니까?')) {
    		qty.value = qty1.value;
    		hiddenForm.setAttribute('action', '/coffee/cartOrPayment');
    		hiddenForm.submit();
    	}
    }

    function buyNowHandler() {
    	let qty1 = document.querySelector('.cartProductInfo__QtyText');
    	let hiddenForm = document.querySelector('#hiddenForm');
    	let qty = document.querySelector('#qty');

    	if (confirm('바로 구매하시겠습니까?')) {
    		qty.value = qty1.value;
    		hiddenForm.setAttribute('action', '/coffee/buyNow');
    		hiddenForm.submit();
    	}
    }

    function qtyHandler(e) {
    	let quantityInput = document.querySelector('#quantityInput');
    	let currentValue = parseInt(quantityInput.value);

    	if (e.target.id === 'increase') {
    		currentValue++;
    	} else if (e.target.id === 'decrease' && currentValue > 1) {
    		currentValue--;
    	}

    	quantityInput.value = currentValue;
    }

    function init() {
    	let cartButton = document.querySelector('#cartbuyer');
        let buyNowButton = document.querySelector('#buyNow');
        
        if (cartButton) {
            cartButton.addEventListener('click', cartHandler);
        }

        if (buyNowButton) {
            buyNowButton.addEventListener('click', buyNowHandler);
        }
    	document.querySelector('.cartProductInfo__QtyDiv').addEventListener('click', qtyHandler);
        
    }
    window.addEventListener('load', init);

