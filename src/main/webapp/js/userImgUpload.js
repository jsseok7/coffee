$(document).ready(function() {
    $("#beanImgFile").on('change', function() {
        var fileName = $(this).val().split('\\').pop();
        $(".beanImg-name").val(fileName || "대표이미지를 넣어주세요.");
    });
});

function telHyphen() {
  let tel = document.getElementById('new-tel');
  const phoneNumberValue = tel.value.replace(/[^0-9]/g, ''); 
  let formattedNumber = '';

  if (phoneNumberValue.length >= 4 && phoneNumberValue.length <= 7) {
    formattedNumber = phoneNumberValue.replace(/(\d{3})(\d{1,4})/, '$1-$2');
  } else if (phoneNumberValue.length > 7) {
    formattedNumber = phoneNumberValue.replace(/(\d{3})(\d{4})(\d{0,4})/, '$1-$2-$3');
  } else {
    formattedNumber = phoneNumberValue;
  }

  tel.value = formattedNumber; 
};



function init() {
    let tel = document.getElementById('new-tel');
	tel.addEventListener('input', telHyphen);
}

init();