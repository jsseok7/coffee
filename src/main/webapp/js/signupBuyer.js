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

function signupBuyerSubmitHandler(event) {
    let userId = document.getElementById('new-userId');
    let username = document.getElementById('new-username');
    let password = document.getElementById('new-password');
    let passwordConfirm = document.getElementById('new-passwordConfirm');
    let nickname = document.getElementById('new-nickname');
    let tel = document.getElementById('new-tel');
    let address = document.getElementById('new-address');
    let msgDiv = document.querySelector('#signUpMsg');
    let signupLabels = document.querySelectorAll('.signup__label');
    let signupIcons = document.querySelectorAll('.signup__icon');
    let msg = '';
	let allckCnt = 0;
    msgDiv.innerHTML = '';

    signupLabels.forEach(label => label.classList.remove('error'));
    signupIcons.forEach(icon => icon.classList.remove('error'));

    [userId, username, password, passwordConfirm, nickname, tel, address].forEach((field, index) => {
        if (field.value.trim() === "") {
            field.value = '';
            signupLabels[index].classList.add('error');
            signupIcons[index].classList.add('error');
            msg = '<i class="fa-solid fa-triangle-exclamation"></i> 모든 정보를 필수로 입력해야 합니다.';
           console.log(1);
        }else {
			allckCnt++;
		}
    });
	if(allckCnt==7){
	    if (password.value.length < 4) {
	        console.log(2);
	        msg = '<i class="fa-solid fa-triangle-exclamation"></i> 비밀번호는 4글자 이상이어야 합니다!';
	        password.value = '';
	        passwordConfirm.value = '';
	        signupLabels[2].classList.add('error');
	        signupIcons[2].classList.add('error');
	    } else if (password.value !== passwordConfirm.value) {
	        msg = '<i class="fa-solid fa-triangle-exclamation"></i> 비밀번호와 비밀번호 확인은 서로 일치해야 합니다!';
	        password.value = '';
	        passwordConfirm.value = '';
	        signupLabels[2].classList.add('error');
	        signupIcons[2].classList.add('error');
	        signupLabels[3].classList.add('error');
	        signupIcons[3].classList.add('error');
	    } else if (username.value.length < 2 || nickname.value.length < 2) {
	        msg = '<i class="fa-solid fa-triangle-exclamation"></i> 이름은 2글자 이상이어야 합니다!';
	        username.value = '';
	        nickname.value = '';
	        signupLabels[1].classList.add('error');
	        signupIcons[1].classList.add('error');
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
	let signUpBuyerForm = document.getElementById('signupBuyer__form');
    let password = document.getElementById('new-password');
    let passwordConfirm = document.getElementById('new-passwordConfirm');
    let tel = document.getElementById('new-tel');
	
	
	signUpBuyerForm.addEventListener('submit', signupBuyerSubmitHandler);
	password.addEventListener('input', checkPasswordStrength);
	passwordConfirm.addEventListener('input', confirmPassword);
	tel.addEventListener('input', telHyphen);
}

init();


//window.addEventListener('load', init);










 	/* var input_val=0;
    $('#btn1').on('click',function(){
    	$('#tel').val(input_val);
    	//document.
    	console.log(input_val);
    }); 
    
    const phoneNumber = (target) => {
        
        const phoneNumberValue = target.value.replace(/[^0-9]/g, '');
        let formattedNumber = "";
		
        
       	if(value.startsWith("02")) {
       		if (phoneNumberValue.length >= 3 && phoneNumberValue.length <= 6) {
                formattedNumber = phoneNumberValue.replace(/(\d{2})(\d{1,3})/g, "$1-$2");
            } else if (phoneNumberValue.length > 6) {
                formattedNumber = phoneNumberValue.replace(/(\d{2})(\d{3})(\d{0,4})/g, "$1-$2-$3");
            } else {
                formattedNumber = phoneNumberValue;
            }
       	}
       	else if(value.startsWith("1")) {
       		if (phoneNumberValue.length >= 4 && phoneNumberValue.length <= 8) {
                formattedNumber = phoneNumberValue.replace(/(\d{4})(\d{1,4})/g, "$1-$2");
            }  else {
                formattedNumber = phoneNumberValue;
            }
       	}
       	else {
       		if (phoneNumberValue.length >= 4 && phoneNumberValue.length <= 7) {
                formattedNumber = phoneNumberValue.replace(/(\d{3})(\d{1,4})/g, "$1-$2");
            } else if (phoneNumberValue.length > 7) {
                formattedNumber = phoneNumberValue.replace(/(\d{3})(\d{4})(\d{0,4})/g, "$1-$2-$3");
            } else {
                formattedNumber = phoneNumberValue;
            }
       	}
        

        target.value = formattedNumber;
        input_val=phoneNumberValue;
        //target.value=Number(phoneNumberValue);
    }
    function uf_aa(){
    	console.log('input_val',input_val);
    	console.log('input_val', Number(input_val));
    }
    function js_sub(){
    	$('#tel').value=input_val;
    	//console.log('input_val',input_val);
    	
    } 
    
    let timeout;
    let password = document.getElementById('new-password')
    let strengthBadge = document.getElementById('strengthDisp')
    let strengthMsg = document.getElementById('strengthMsg')
    let passwordConfirm = document.getElementById('new-passwordConfirm')
    let confirmMsg = document.getElementById('confirmMsg')
    let strongPassword = new RegExp('(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{8,})')
    let mediumPassword = new RegExp('((?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{6,}))|((?=.*[a-z])(?=.*[A-Z])(?=.*[^A-Za-z0-9])(?=.{8,}))')

    function StrengthChecker(PasswordParameter) {
      if (strongPassword.test(PasswordParameter)) {
        strengthBadge.style.backgroundColor = "green"
        strengthBadge.textContent = 'Strong'
        strengthMsg.textContent = '비밀번호가 강력합니다.'
      } else if (mediumPassword.test(PasswordParameter)) {
        strengthBadge.style.backgroundColor = 'blue'
        strengthBadge.textContent = 'Medium'
        strengthMsg.textContent = '비밀번호가 중간입니다.'
      } else {
        strengthBadge.style.backgroundColor = 'red'
        strengthBadge.textContent = 'Weak'
        strengthMsg.textContent = '비밀번호가 약합니다.'
      }
    }

    password.addEventListener("input", () => {
      strengthBadge.style.display = 'block'
      strengthMsg.style.display = 'block'
    
      clearTimeout(timeout);
    
      timeout = setTimeout(() => StrengthChecker(password.value), 100);
    
      if (password.value.length !== 0) {
        strengthBadge.style.display != 'block'
      } else {
        strengthBadge.style.display = 'none'
      }
    });

    const phoneNumber = (target) => {
    
    const phoneNumberValue = target.value.replace(/-/g, '').replace(/[^0-9]/g, '');
    let formattedNumber = "";
    
        if (phoneNumberValue.length >= 4 && phoneNumberValue.length <= 7) {
            formattedNumber = phoneNumberValue.replace(/(\d{3})(\d{1,4})/g, "$1-$2");
        } else if (phoneNumberValue.length > 7) {
            formattedNumber = phoneNumberValue.replace(/(\d{3})(\d{4})(\d{0,4})/g, "$1-$2-$3");
        } else {
            formattedNumber = phoneNumberValue;
        }
    
        target.value = formattedNumber;
    
    }   

    function confirmPw() {
        if(password.value !='' && passwordConfirm.value!=''){
            if(password.value==passwordConfirm.value){
                confirmMsg.textContent='비밀번호가 일치합니다.'
                confirmMsg.style.color='blue';
            }
            else{
                confirmMsg.textContent='비밀번호가 일치하지 않습니다.';
                confirmMsg.style.color='red';
            }
        }

    }*/
