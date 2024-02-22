<%@ page contentType="text/html; charset=UTF-8" 
	import="java.util.*"
    	  %>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Seo -->
    <title>Bean2B</title>
	<%@ include file = "/WEB-INF/views/header.jsp" %>
	<!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/signupStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/productStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/myPageStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/mainStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/cartStyle.css">
    <!-- Javascript -->
    <script type="module" src="${pageContext.request.contextPath }/js/slideShow.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/login.js" defer></script>
	<script type="module" src="${pageContext.request.contextPath }/js/category.js" defer></script>
	<script type="module" src="${pageContext.request.contextPath }/js/bestBean.js" defer></script>
	<script type="module" src="${pageContext.request.contextPath }/js/loginNon2.js" defer></script>
	<script type="module" src="${pageContext.request.contextPath }/js/servicePopup.js" defer></script>
    <script>
    let loginResult = '${login}';
    window.onload = function (){
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
        if (loginResult === 'fail1') {
            msg = '<i class="fa-solid fa-triangle-exclamation"></i> 해당 아이디가 존재하지 않습니다.';
            userId.value = '';
            loginLabels[0].classList.add('error');
            loginIcons[0].classList.add('error');
            console.log('Error: 비밀번호 틀렸습니다.');
            console.log(loginResult)
        }
        else if (loginResult === 'fail2') {
                    msg = '<i class="fa-solid fa-triangle-exclamation"></i> 비밀번호 틀렸습니다.';
                    userPassword.value = '';
                    loginLabels[1].classList.add('error');
                    loginIcons[1].classList.add('error');
                    console.log('Error: 비밀번호 틀렸습니다.');
                    console.log(loginResult)
                }
        if (msg !== '') {
            loginMsg.innerHTML = msg;
            loginResult = ''
        }
    }
    </script>
</head>
<body>
<%@ include file = "/WEB-INF/views/headerNav.jsp" %>
 <!-- Main -->
    <section id="mainIntro" class="section">
        <div class="max-container">
            <div class="mainIntro">
                <div id="slideShow" class="mainIntro__intro">
                    <ul class="slides">
                        <li><img class="introImg" src="images/main1.gif" alt=""></li>
                        <li><img class="introImg" src="images/main2.png" alt=""></li>
                        <li><img class="introImg" src="images/main3.png" alt=""></li>
                    </ul>  
                    <div class="controller">
                        <span class="prev">&lang;</span>  
                        <span class="next">&rang;</span>
                    </div>
                </div>
                <div class="mainIntro__loginAll">
                    
                    <div class="mainIntro__login">
                   
                    	<div class="userImgDiv">
                            <img src="${pageContext.request.contextPath }/images/userImginit.png" alt="" class="userImg">
                        </div>
                        <div>
                        	<form id="loginForm" class="mainIntro__loginForm" method="post" action="mainLogin">
                            <div class="loginRadio">
                                <input type="radio" name="user" value="buyer" checked/><label class="radioLabel">구매자</label>
                                <input type="radio" name="user" value="seller" /><label class="radioLabel">판매자</label>
                            </div>
                                   
                            <label for="id" class="login__label">
                                <i class="fa-regular fa-user login__icon"></i>
                                <input
                                    class="login__input"
                                    type="email"
                                    id="userId"
                                    name="id"
                                    placeholder="email@example.com"
                                />
                            </label> 
                            <label for="password" class="login__label">
                                <i class="fa-solid fa-lock login__icon"></i>
                                <input
                                    class="login__input"
                                    type="password"
                                    id="userPassword"
                                    name="passwd"
                                    placeholder="비밀번호 입력"
                                />
                            </label>
                            <div class="mainIntro__loginFormButton">
                                <button id="loginButton" class="mainIntro__loginButton" type="submit" name="action" value="login">로그인</button>
                                <button class="mainIntro__loginButton " type="submit" name="action" value="signup">회원가입</button>
                            </div>
                        </form>
                        <div class="loginErrorMsg" id="loginMsg"></div>
                        </div>
                    
                        
                    </div>
                   
                </div>
            </div>
        </div>

    </section>
    <!-- Category -->
	<%@ include file = "/WEB-INF/views/category.jsp" %> 
    <!-- BeanBest -->
    <section id="mainBeanBest" class="section">
         <div class="max-container">
        <h1 class="mainBeanBest__title">Best</h1>
            <div class="mainBeanBest">
  				<c:forEach items="${bestBean}" var="beansDO" >
                    <div class="mainBeanBest__product">
                    	<img src="" alt="" class="beanBest__number">

        				<img src="${beansDO.beanImg}"  alt="" class="mainBeanBest__productImg" id="${ beansDO.beansNum}" >
                    	<form method="get" action="goListDetail" class="bestBeanForm">
                			<input type="hidden" id="beansNum" name="beansNum" value="${beansDO.beansNum}" />
                			<button>
                			</button>
                   		</form>
        				<p class="productList__productTitle"><span class="bestBean__span">상품명</span> ${beansDO.beanName }</p>
        				<p class="bestBean__productPrice"><span class="bestBean__span">가격</span> ${beansDO.beanPrice}원</p>
        				<div class="likeButton">
                        	<button class="myPageLike__button NonLikeButton"><i class="fa-regular fa-heart"></i></button>
                        	<p class="mainBeanBest__productLikeCount">${beansDO.likeCount}</p>
                    	</div>
                    </div>

    			</c:forEach>
            </div>
 	         <div class="mainBeanBest__button">
 	         	<h2 class="mainBeanBest__buttonTitle">더 많은 원두를 보려면?</h2>
 	         	<form method="get" action="goProductList">
 	         	    <button id="popupButton"  class="mainBeanBest__plusButton"><i class="fa-solid fa-angles-right"></i></button>	
 	 			</form>

            </div>
        </div>
    </section>
    
    
<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>