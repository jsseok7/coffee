let timeout;
let idCheckMsg = document.getElementById('idCheckMsg');


function checkPasswordStrength(){
	
	let password = document.getElementById('new-password');
	let strongPassword = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,}$/;
	let mediumPassword = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,}$/;
	let strengthBadge = document.getElementById('strengthDisp');
	let strengthMsg = document.getElementById('strengthMsg');
	
	
  if (strongPassword.test(password.value)) {
	strengthMsg.style.display = 'block'; 
	strengthBadge.style.display = 'block'; 
    strengthBadge.style.backgroundColor = "green";
    strengthBadge.textContent = 'Strong';
    strengthMsg.textContent = '비밀번호가 강력합니다.';
  } else if (mediumPassword.test(password.value)) {
	strengthMsg.style.display = 'block'; 
	strengthBadge.style.display = 'block'; 
    strengthBadge.style.backgroundColor = 'blue';
    strengthBadge.textContent = 'Medium';
    strengthMsg.textContent = '비밀번호가 중간입니다.';
  } else {
	strengthMsg.style.display = 'block'; 
	strengthBadge.style.display = 'block'; 
    strengthBadge.style.backgroundColor = 'red';
    strengthBadge.textContent = 'Weak';
    strengthMsg.textContent = '비밀번호가 약합니다.';
  }
  
  
};

function confirmPassword(){
	let password = document.getElementById('new-password');
	let passwordConfirm = document.getElementById('new-passwordConfirm');
	let confirmMsg = document.getElementById('confirmMsg');
	
	if(passwordConfirm.value !='' && passwordConfirm.value!=''){
            if(password.value==passwordConfirm.value){
				confirmMsg.style.display = 'block'; 
                confirmMsg.textContent='비밀번호가 일치합니다.'
                confirmMsg.style.color='blue';
            }
            else{
				confirmMsg.style.display = 'block'; 
                confirmMsg.textContent='비밀번호가 일치하지 않습니다.';
                confirmMsg.style.color='red';
            }
        }
};

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

function businessNumberHyphen() {
  let businessNumber = document.getElementById('new-businessNumber');
  const phoneNumberValue = businessNumber.value.replace(/[^0-9]/g, ''); 
  let formattedNumber = '';

  if (phoneNumberValue.length >= 4 && phoneNumberValue.length <= 5) {
    formattedNumber = phoneNumberValue.replace(/(\d{3})(\d{1,2})/, '$1-$2');
  } else if (phoneNumberValue.length > 5) {
    formattedNumber = phoneNumberValue.replace(/(\d{3})(\d{2})(\d{0,5})/, '$1-$2-$3');
  } else {
    formattedNumber = phoneNumberValue;
  }

  businessNumber.value = formattedNumber; 
};


function signupSellerSubmitHandler(event) {
    let userId = document.getElementById('new-userId');
    let password = document.getElementById('new-password');
    let passwordConfirm = document.getElementById('new-passwordConfirm');
    let nickname = document.getElementById('new-nickname');
    let tel = document.getElementById('new-tel');
    let businessName = document.getElementById('new-businessName');
    let businessNumber = document.getElementById('new-businessNumber');
    let address = document.getElementById('new-address');
    let msgDiv = document.querySelector('#signUpMsg');
    let signupLabels = document.querySelectorAll('.signup__label');
    let signupIcons = document.querySelectorAll('.signup__icon');
    let msg = '';
    let allckCnt = 0;

    msgDiv.innerHTML = '';

    signupLabels.forEach(label => label.classList.remove('error'));
    signupIcons.forEach(icon => icon.classList.remove('error'));

    [userId, password, passwordConfirm, nickname, tel, businessName, businessNumber, address].forEach((field, index) => {
        if (field.value.trim() === "") {
            field.value = '';
            signupLabels[index].classList.add('error');
            signupIcons[index].classList.add('error');
            msg = '<i class="fa-solid fa-triangle-exclamation"></i> 모든 정보를 필수로 입력해야 합니다.';
        }else {
			allckCnt++;
		}
    });
	if(allckCnt==7){
		if (password.value.length < 4) {
	        msg = '<i class="fa-solid fa-triangle-exclamation"></i> 비밀번호는 4글자 이상이어야 합니다!';
	        password.value = '';
	        passwordConfirm.value = '';
	        signupLabels[1].classList.add('error');
	        signupIcons[1].classList.add('error');
	    } else if (password.value !== passwordConfirm.value) {
	        msg = '<i class="fa-solid fa-triangle-exclamation"></i> 비밀번호와 비밀번호 확인은 서로 일치해야 합니다!';
	        password.value = '';
	        passwordConfirm.value = '';
	        signupLabels[1].classList.add('error');
	        signupIcons[1].classList.add('error');
	        signupLabels[2].classList.add('error');
	        signupIcons[2].classList.add('error');
	    } else if (nickname.value.length < 2) {
	        msg = '<i class="fa-solid fa-triangle-exclamation"></i> 닉네임은 2글자 이상이어야 합니다!';
	        nickname.value = '';
	        signupLabels[3].classList.add('error');
	        signupIcons[3].classList.add('error');
	    }
	    allckCnt=0;
	}
	
    
 

    if (msg !== '') {
        msgDiv.style.display = 'block';
        msgDiv.innerHTML = msg;
        setTimeout(() => {
            signupIcons.forEach(icon => icon.classList.remove('error'));
        }, 500);
        event.preventDefault();
    }
}


		
function init() {
	let signUpSellerForm = document.getElementById('signupSeller__form');
    let password = document.getElementById('new-password');
    let passwordConfirm = document.getElementById('new-passwordConfirm');
    let tel = document.getElementById('new-tel');
    let businessNumber = document.getElementById('new-businessNumber');
	

	signUpSellerForm.addEventListener('submit', signupSellerSubmitHandler);
	password.addEventListener('input', checkPasswordStrength);
	passwordConfirm.addEventListener('input', confirmPassword);
	tel.addEventListener('input', telHyphen);
	businessNumber.addEventListener('input', businessNumberHyphen);
}

init();