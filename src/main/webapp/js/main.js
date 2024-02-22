function showCategoryHandler() {
    let categoryList = document.querySelectorAll('.mainCategory__detail');

    for (let i = 0; i < categoryList.length; i++) {
        if (i < 5) {
            categoryList[i].style.display = 'inline-flex';
        } else {
            categoryList[i].style.display = 'none';
        }
    }
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

//국기이미지 다음(>) 버튼 기능
function nextBtnHandler(){
	
	let categoryList = document.querySelector('#categoryList');
	let categoryImg = document.querySelectorAll('.mainCategory__detail');
    let firstChild = categoryList.firstElementChild;
	
	for (let i = 0; i < categoryImg.length; i++) {
        if (i < 5) {
            categoryImg[i].style.display = 'inline-flex';
        } else {
            categoryImg[i].style.display = 'none';
        }
    }
    firstChild.style.display = 'none'
    categoryList.insertBefore(firstChild,categoryImg[9]);
    categoryImg[5].style.display = 'inline-flex';
}

//국기 이미지 이전(<) 버튼 기능
function prevBtnHandler() {
	let categoryList = document.querySelector('#categoryList');
	let categoryImg = document.querySelectorAll('.mainCategory__detail');
    let firstChild = categoryList.firstElementChild;
	let lastChild = categoryList.lastElementChild;
	let nextChild = firstChild.nextElementSibling;
	
	for (let i = 0; i < categoryImg.length; i++) {
        if (i < 5) {
            categoryImg[i].style.display = 'inline-flex';
        } 
        else {
            categoryImg[i].style.display = 'none';
        }
    }
    if (nextChild) {
        categoryList.insertBefore(firstChild, nextChild);
    }
    categoryList.insertBefore(lastChild, categoryList.firstElementChild);
 	lastChild.style.display = 'inline-flex';
 	categoryImg[4].style.display = 'none';
	}

function getCategoryHandler(event){
    let id = event.currentTarget.id;
    let url = '/coffee/goProductList?category=' + id;
    location.href = url;
}

function init(){
	let category = document.querySelectorAll('.mainCategory__detail');
	
	let nextBtn = document.querySelector('#categoryNextBtn');
	let prevBtn = document.querySelector('#categoryPrevBtn');

	category.forEach(categoryElement => {
    categoryElement.addEventListener('click', getCategoryHandler);
	});
		
	
	//국기이미지 옆 버튼
	nextBtn.addEventListener('click', nextBtnHandler);
	prevBtn.addEventListener('click', prevBtnHandler);
	
	
		}
		
window.addEventListener('load', init);

showCategoryHandler();
bestBeansImgHandler();