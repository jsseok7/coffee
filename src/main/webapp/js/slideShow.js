const slides = document.querySelector('.slides'); 
const slideImg = document.querySelectorAll('.slides li'); 
let currentIdx = 0; 
const slideCount = slideImg.length; 
const prev = document.querySelector('.prev'); 
const next = document.querySelector('.next'); 
const slideWidth = 700; 
const slideMargin = 100; 
let slideShow = document.querySelector('#slideShow');

slides.style.width = (slideWidth + slideMargin) * slideCount + 'px';

function moveSlide(num) {
  slides.style.left = -num * 800 + 'px';
  currentIdx = num;
}

//자동 전환 국기 이미지
function autoCycleCategoryListHandler(){
	
    let firstChild = slides.firstElementChild;

    slides.insertBefore(firstChild , null);
}

function prevHandler(event) {
    if (currentIdx !== 0) moveSlide(currentIdx - 1);
}

function nextHandler(event) {
    if (currentIdx !== slideCount - 1) {
        moveSlide(currentIdx + 1);
      }
}


function init2() {
	
	prev.addEventListener('click', prevHandler);
    next.addEventListener('click', nextHandler);
    slides.addEventListener('load', autoCycleCategoryListHandler);
}

init2();

//국기이미지 자동으로 넘어가기, 8초(8000ms)로 설정
setInterval(autoCycleCategoryListHandler, 7000);
