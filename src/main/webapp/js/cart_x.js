let totalPrice = document.querySelector('#totalPrice');
let sum = totalPrice.innerHTML * 1;

function clickHandler(e) {

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
		if ((qtySpan.innerHTML * 1) >= 2) {
			sum -= priceInput * 1 ;
			qtySpan.innerHTML = (qtySpan.innerHTML * 1) - 1;
		}
	}



	document.querySelector('#totalPrice').innerHTML = sum;
}

// 페이지 로드 된 이후 체인지 동장
function changeHandler(e) {
	if (e.target.getAttribute('type') !== 'checkbox') {
		return;
	}

	// 상품 하나에 대한 요소들만 찾도록 변경
	const cartProduct = e.target.closest('.cartProduct');
	const cartProductCheck = cartProduct.querySelector('.cartProduct__check');
	const totalPrice = document.querySelector('#totalPrice');
	const cartProductPrice = cartProduct.querySelector(".cartProductInfo__price");
	let price = 0;
	// let price = cartProduct.querySelector('.cartProductInfo__price').innerHTML;
	let qtySpan = cartProduct.querySelector('.qty');
	let plusButton = cartProduct.querySelector('.cartProductInfo__plus');
	let minusButton = cartProduct.querySelector('.cartProductInfo__minus');
	
	if (cartProductCheck.checked) {
		price = cartProductPrice.innerText * qtySpan.innerText;
	} else {
		price = 0
	}
	
	if (cartProductCheck.checked) {
		plusButton.disabled = false;
		minusButton.disabled = false;

		// sum += cartProductPrice.innerText * (qtySpan.innerHTML * 1);
	} else {
		plusButton.disabled = true;
		minusButton.disabled = true;

		// sum -= cartProductPrice.innerText * (qtySpan.innerHTML * 1);
	}
	
	totalPrice.innerHTML = price;
}

function payHandler(){
	
}

const onCartProductClick = (cartProducts) => {
	const cartPayment = document.querySelector('.cartPayment');
	let isChecked = false;
	cartProducts.forEach(cartProduct => {
		const cartProductCheck = cartProduct.querySelector('.cartProduct__check');
		if (cartProductCheck.checked) {
			isChecked = cartProductCheck.checked;
		}
	})
	cartPayment.disabled = !isChecked
} 

const handleInputValues = e => {
	// 다른 input 태그가 checked 상태이면 끈다.
	const target = e.target;
	const cartProductChecks = document.querySelectorAll(".cartProduct__check");
	if (target.checked) {
		cartProductChecks.forEach(cartProductCheck => {
			if(cartProductCheck.id != target.id) {
				cartProductCheck.checked = false;
			}
		})
	}
	// checked 인 인풋태그의 값으로 form 태그 내부의 input value들 수정
}

const onPlusQtyBtnClick = e => {
	const cartProductInfo = e.target.closest(".cartProductInfo");
	const productPrice = cartProductInfo.querySelector(".cartProductInfo__price").innerText;
	const cartProductCheck = cartProductInfo.querySelector(".qty");
	const totalPrice = document.querySelector('#totalPrice');
	const currentPrice = totalPrice.innerText;
	totalPrice.innerText = parseInt(currentPrice) + parseInt(productPrice);
	cartProductCheck.innerText = parseInt(cartProductCheck.innerText) + 1;
}

const onMinusQtyBtnClick = e => {
	const cartProductInfo = e.target.closest(".cartProductInfo");
	const productPrice = cartProductInfo.querySelector(".cartProductInfo__price").innerText;
	const cartProductCheck = cartProductInfo.querySelector(".qty");
	const totalPrice = document.querySelector('#totalPrice');
	const currentPrice = totalPrice.innerText;
	totalPrice.innerText = parseInt(currentPrice) - parseInt(productPrice);
	cartProductCheck.innerText = parseInt(cartProductCheck.innerText) - 1;
}

function initCartProcuts (cartProducts) {
	cartProducts.forEach(cartProduct => {
		const cartProductCheck = cartProduct.querySelector(".cartProduct__check");
		cartProductCheck.addEventListener("click", () => {onCartProductClick(cartProducts)});
		cartProductCheck.addEventListener("click", (e) => {handleInputValues(e)})
	})
}

// 페이지 로드 시 버튼 활성화
function initQtyBtn(cartProducts) {
	cartProducts.forEach(cartProduct => {
		const cartProductsCheck = cartProduct.querySelector('.cartProduct__check');
		
		const plusBtn = cartProduct.querySelector('#plus');
		const minusBtn = cartProduct.querySelector('#minus');
		
		plusBtn.addEventListener("click", e => onPlusQtyBtnClick(e));
		minusBtn.addEventListener("click", e => onMinusQtyBtnClick(e));
		
		if(cartProductsCheck.checked) {
			plusBtn.disabled = false;
			minusBtn.disabled = false;
		}
	});
	
	
}

function init() {
	const cartProducts = document.querySelectorAll('.cartProduct');
	
	initQtyBtn(cartProducts);
	initCartProcuts(cartProducts);	
	
	cartProducts.forEach(function(cartProduct) {
		//console.log('cart box id:', cartProduct.id);
		// cartProduct.addEventListener('click', clickHandler);
		cartProduct.addEventListener('change', changeHandler);
	});
	document.querySelector('.cartPayment').addEventListener('click', payHandler);

}

window.addEventListener('load', init);