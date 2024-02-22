//이미지 크기 고정
function bestBeanCenterHandler(){
	let bestBeanCenter = document.querySelectorAll('.mainBeanBest');
	
	for(let i=0;i<bestBeanCenter.length;i++){
		bestBeanCenter[i].style.margin = 'auto';	
		}
}
function fixedBestBeanImgHandler(){
	let fixedBestBeanImg = document.querySelectorAll('.mainBeanBest__productImg');
	
	for(let i=0;i<fixedBestBeanImg.length;i++){
		fixedBestBeanImg[i].style.width = '150px';
		fixedBestBeanImg[i].style.height = '120px';
		fixedBestBeanImg[i].style.margin = 'auto';
	
	}
}

function fixedBestBeanFontBoxHandler(){
	let fixedBestBeanFontBox = document.querySelectorAll('.productList__productTitle');
	
	for(let i=0;i<fixedBestBeanFontBox.length;i++){
		fixedBestBeanFontBox[i].style.width = '180px';
		fixedBestBeanFontBox[i].style.height = '0px';
		fixedBestBeanFontBox[i].style.margin = 'auto';
		
	}
}

//베스트 상품 클릭하면 상품 상세로 가기
function goBestBeanDetailHandler(event){
    let id = event.currentTarget.id;
    let url = '/coffee/goListDetail?beansNum=' + id;
    location.href = url;
}

//1~5등 이미지 연결//
function bestBeansImgHandler(){
	const images = ["/coffee/images/number1.png", "/coffee/images/number2.png", 
					"/coffee/images/number3.png", "/coffee/images/number4.png", 
					"/coffee/images/number5.png"];
	
	const bestBeans = document.querySelectorAll('.mainBeanBest__product');

    bestBeans.forEach((bean, index) => {
        const img = bean.querySelector('.beanBest__number');
            img.src = images[index];  
    });
}


function init(){
	let gobestBeanDetail = document.querySelectorAll('.mainBeanBest__productImg');
	
	gobestBeanDetail.forEach(bestBeanElement => {
    bestBeanElement.addEventListener('click', goBestBeanDetailHandler);
	});
}

bestBeanCenterHandler();
fixedBestBeanFontBoxHandler();
fixedBestBeanImgHandler();
bestBeansImgHandler();
window.addEventListener('load', init);