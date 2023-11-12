/*
 */
function detailDescriptSizeHandler(){
	 let detailDescriptSize = document.querySelectorAll('.productListDetail__bottomImg');
	 
	 for(let i = 0; i<detailDescriptSize.length;i++){
		 detailDescriptSize[i].style.width = '1100px';
		 detailDescriptSize[i].style.height = '820px';
	 }
}


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


function init() {
	document.querySelector('#cart').addEventListener('click', cartHandler);
	document.querySelector('#buyNow').addEventListener('click', buyNowHandler);
}
detailDescriptSizeHandler();
window.addEventListener('load', init);