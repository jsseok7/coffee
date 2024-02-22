function buyHandler() {
//	let qty1 = document.querySelector('.cartProductInfo__QtyText');
	let hiddenForm = document.querySelector('#hiddenForm');
//	let qty = document.querySelector('#qty');

//	qty.value = qty1.value;
	hiddenForm.setAttribute('action', '/coffee/paymentComplete');
	hiddenForm.submit();
}

function cancelHandler(){
	let beansNum = document.querySelector('#beansNum').getAttribute('value')

	location.href = '/coffee/goListDetail?beansNum=' + beansNum;
}
function init() {
	document.querySelector('#buy').addEventListener('click', buyHandler);
	document.querySelector('#cancel').addEventListener('click', cancelHandler);

}
window.addEventListener('load', init);