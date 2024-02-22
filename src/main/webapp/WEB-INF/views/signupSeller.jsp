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
    <script type="module" src="${pageContext.request.contextPath }/js/signupSeller.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/servicePopup.js" defer></script>
<%--     <script type="module" src="${pageContext.request.contextPath }/js/slideShow.js" defer></script> --%>
    
<%--     <script type="module" src="${pageContext.request.contextPath }/js/login.js" defer></script> --%>
    <%-- <script type="module" src="${pageContext.request.contextPath }/js/signup.js" defer></script> --%>
     <%--<script type="module" src="${pageContext.request.contextPath }/js/myPage.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/main.js" defer></script> --%>
</head>
<body>
<%@ include file = "/WEB-INF/views/headerNav.jsp" %>

<!-- SignupSeller -->
    <section id="signup" class="section">
        <div class="max-container">
            <div class="signup">
                <div class="signup__form-div">
                    <h2 class="signup__title">Bean2B 비즈니스 회원 가입을 진행합니다.</h2> 
                    <h4 class="signup__description">커피도시 부산의 신선하고 맛있는 원두를 공급할 사장님들을 기다리고 있습니다.</h4> 
                    <form id="signupSeller__form" class="signup__form" method="post" action="signupSeller">
                        <label for="new-userId" class="signup__label">
                            <i class="fa-regular fa-envelope signup__icon"></i>
                            <input
                                class="signup__input"
                                type="email"
                                id="new-userId"
                                name="sellerEmail"
                                placeholder="email@example.com"
                            />
                        </label> 
                        <p id="idCheckMsg"></p>
                        <label for="new-password" class="signup__label">
                            <i class="fa-solid fa-key signup__icon"></i>
                            <input
                                class="signup__input"
                                type="password"
                                id="new-password"
                                name="passwd"
                                placeholder="4자리 이상 입력해주세요."
                            />
                        </label>
                        <div class="passwdMsg">
                            <p id="strengthDisp"></p>
                            <p id="strengthMsg"></p>
                        </div>
                        <label for="new-passwordConfirm" class="signup__label">
                            <i class="fa-solid fa-check signup__icon"></i>
                            <input
                                class="signup__input"
                                type="password"
                                id="new-passwordConfirm"
                                name="passwdConfirm"
                                placeholder="비밀번호 확인"
                            />
                        </label>
                        <p id="confirmMsg"></p>
                        <label for="new-sellerName" class="signup__label">
                            <i class="fa-regular fa-circle-user signup__icon"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-nickname"
                                name="nickname"
                                placeholder="닉네임을 입력해주세요."
                            />
                        </label>
                        <label for="new-phoneNumber" class="signup__label">
                            <i class="fa-solid fa-phone signup__icon"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-tel"
                                name="tel"
                                placeholder="휴대폰번호를 입력해주세요."
                            />
                        </label>
                        <h4 class="business__title">사업자 정보</h4>
                        <label for="new-businessName" class="signup__label">
                            <i class="fa-solid fa-store signup__icon"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-businessName"
                                name="businessName"
                                placeholder="상호명을 입력해주세요."
                            />
                        </label>
                        <label for="new-businessNumber" class="signup__label">
                            <i class="fa-regular fa-address-card signup__icon"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-businessNumber"
                                name="businessNum"
                                oninput="businessNumber(this)"
                                placeholder="사업자번호를 입력해주세요."
                                maxlength="13"
                            />
                        </label>
                        
                        <label for="new-address" class="signup__label">
                        	<i class="fa-solid fa-map-location-dot signup__icon"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-address"
                                name="address"
                                placeholder="주소를 입력해주세요."
                            />
                        </label>
                        <button class="signup__button" id="signup-button" type="submit">회원가입</button>
                    </form>
                    <div id="signUpMsg">${msg}</div>
                </div>
            </div>
        </div>
    </section>

<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>