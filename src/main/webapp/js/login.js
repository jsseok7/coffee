function loginHandler(event) {
    console.log('Event:', event);
    
    let userId = document.querySelector('#userId');
    let userPassword = document.querySelector('#userPassword');
    let loginMsg = document.querySelector('#loginMsg');
    let loginLabels = document.querySelectorAll('.login__label');
    let loginIcons = document.querySelectorAll('.login__icon');

    let msg = '';

    loginMsg.innerHTML = '';

    loginLabels.forEach(label => label.classList.remove('error'));
    loginIcons.forEach(icon => icon.classList.remove('error'));

    console.log('userId value:', userId.value);
    console.log('userPassword value:', userPassword.value);

    if (event.submitter && event.submitter.value === 'login') {
        if (userId.value.trim() === '' && userPassword.value.trim() === '') {
            msg = '<i class="fa-solid fa-triangle-exclamation"></i> 아이디와 비밀번호를 모두 입력해야 합니다.';
            loginLabels[0].classList.add('error');
            loginIcons[0].classList.add('error');
            loginLabels[1].classList.add('error');
            loginIcons[1].classList.add('error');
            console.log('Error: 아이디 또는 비밀번호가 비어 있습니다.');
        } else if (userId.value.trim() === '') {
            msg = '<i class="fa-solid fa-triangle-exclamation"></i> 아이디를 입력해주세요.';
            userId.value = '';
            loginLabels[0].classList.add('error');
            loginIcons[0].classList.add('error');
            console.log('Error: 아이디를 입력해주세요.');
        } else if (userPassword.value.trim() === '') {
            msg = '<i class="fa-solid fa-triangle-exclamation"></i> 비밀번호를 입력해주세요.';
            userPassword.value = '';
            loginLabels[1].classList.add('error');
            loginIcons[1].classList.add('error');
            console.log('Error: 비밀번호를 입력해주세요.');
        } else {
            if (loginResult === 'fail') {
                msg = '<i class="fa-solid fa-triangle-exclamation"></i> 비밀번호 틀렸습니다.';
                userPassword.value = '';
                loginLabels[1].classList.add('error');
                loginIcons[1].classList.add('error');
                console.log('Error: 비밀번호 틀렸습니다.');
            }
        }
    } else if (event.submitter && event.submitter.value === 'signup') {
        console.log('Changing action for signup');
		document.forms["loginForm"].action = "/coffee/mainLogin";
        document.forms["loginForm"].submit();
    }

    if (msg !== '') {
        event.preventDefault();
        loginMsg.innerHTML = msg;
    }
}

function init() {
    let loginForm = document.querySelector('#loginForm');
    loginForm.addEventListener('submit', loginHandler);
}

init();
