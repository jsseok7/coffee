let totalPrice = document.querySelector('#totalPrice');
let sum = totalPrice.innerHTML * 1;

function clickHandler(e) {
	
	 if (e.target.className === 'fa-solid fa-trash'){
       if (confirm('장바구니에서 삭제 하시겠습니까?')) {
          let beansNum = e.target.parentElement.value;
          location.href = '/coffee/deleteItem?beansNum=' + beansNum;
       }
    }
	
	if (e.target.nodeName !== 'BUTTON') {
		return;
	}

	// 상품 하나에 대한 요소들만 찾도록 변경
	let cartProduct = e.target.closest('.cartProduct');
	let priceInput = cartProduct.querySelector('.cartProductInfo__price').innerHTML;
	let qtySpan = cartProduct.querySelector('.qty');

	if (e.target.classList.contains('cartProductInfo__plus')) {
		sum += priceInput * 1;
		qtySpan.innerHTML = (qtySpan.innerHTML * 1) + 1;
	} else if (e.target.classList.contains('cartProductInfo__minus')) {
		if ((qtySpan.innerHTML * 1) >= 1) {
			sum -= priceInput * 1 ;
			qtySpan.innerHTML = (qtySpan.innerHTML * 1) - 1;
		}
	}

	document.querySelector('#totalPrice').innerHTML = sum;
	
	if (e.target.classList.contains('cartProductInfo__delete') ) {
        if (confirm('장바구니에서 삭제 하시겠습니까?')) {
            // let hiddenForm = document.querySelector('#hiddenForm');
            // if (hiddenForm) {
             let beansNum = e.target.value;
             location.href = '/coffee/deleteItem?beansNum=' + beansNum;
            // } else {
            //     console.error('#hiddenForm이 존재하지 않습니다.');
            // }
        }
    }

}

function changeHandler(e) {
	if (e.target.getAttribute('type') !== 'checkbox') {
		return;
	}

	// 상품 하나에 대한 요소들만 찾도록 변경
	let cartProduct = e.target.closest('.cartProduct');
	let price = cartProduct.querySelector('.cartProductInfo__price').innerHTML;
	let qtySpan = cartProduct.querySelector('.qty');
	let plusButton = cartProduct.querySelector('.cartProductInfo__plus');
	let minusButton = cartProduct.querySelector('.cartProductInfo__minus');

	
	if (e.target.checked) {
		plusButton.disabled = false;
		minusButton.disabled = false;


		sum += (price * 1) * (qtySpan.innerHTML * 1);
	} else {
		plusButton.disabled = true;
		minusButton.disabled = true;
		sum -= (price * 1) * (qtySpan.innerHTML * 1);
	}
	document.querySelector('#totalPrice').innerHTML = sum;
}
function init() {
	const cartProducts = document.querySelectorAll('.cartProduct');

	cartProducts.forEach(function(cartProduct) {
		const checkbox = cartProduct.querySelector('.cartProduct__check');
		cartProduct.addEventListener('click', clickHandler);
		cartProduct.addEventListener('change', changeHandler);
	});
}
window.addEventListener('load', init);