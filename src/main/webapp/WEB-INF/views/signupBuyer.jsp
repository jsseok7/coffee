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
    <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
   	<script type="module" src="${pageContext.request.contextPath }/js/signupBuyer.js" defer></script>
   	<script type="module" src="${pageContext.request.contextPath }/js/servicePopup.js" defer></script>
<%--     <script type="module" src="${pageContext.request.contextPath }/js/slideShow.js" defer></script> --%>
    
<%--     <script type="module" src="${pageContext.request.contextPath }/js/login.js" defer></script> --%>
    <%-- <script type="module" src="${pageContext.request.contextPath }/js/signup.js" defer></script> --%>
     <%--<script type="module" src="${pageContext.request.contextPath }/js/myPage.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/main.js" defer></script> --%>
</head>
<body>
<%@ include file = "/WEB-INF/views/headerNav.jsp" %>


<!-- SignupBuyer -->
    <section id="signup" class="section">
        <div class="max-container">
            <div class="signup">
                <div class="signup__form-div">
                    <h2 class="signup__title">Bean2B 구매자 회원 가입을 진행합니다.</h2> 
                    <h4 class="signup__description">맛있는 커피를 찾고 계신가요? <br /> 커피도시 부산의 신선한 원두로 여러분을 기다리고 있습니다.</h4> 
                    <form method="post" action="signupBuyer" id="signupBuyer__form" class="signup__form">
                        <label for="new-userId" class="signup__label">
                            <i class="fa-regular fa-envelope signup__icon"></i>
                            <input
                                class="signup__input"
                                type="email"
                                id="new-userId"
                                name="buyerEmail"
                                placeholder="email@example.com"
                            />
                        </label> 
                        <c:if test="${not empty idCheck }">
                        	<p >${idCheck }</p>
                        </c:if>
                        <button name="command" value="idCheck">중복체크</button>
                        <label for="new-username" class="signup__label">
                            <i class="fa-regular fa-id-card signup__icon"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-username"
                                name="buyerName"
                                placeholder="이름을 입력해주세요."
                            />
                        </label>
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
                        <label for="new-nickname" class="signup__label">
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
                        <button class="signup__button" type="submit" name="command" value="signup">회원가입</button>
                    </form>
                    <div id="signUpMsg">${msg}</div>
                </div>
                
            </div>
        </div>
    </section>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        window.onload = function (){
            document.getElementById("new-address").addEventListener("click", function (){
                new daum.Postcode({
                    oncomplete: function (data){
                        document.getElementById("new-address").value = data.address;
                        document.querySelector("input[name=address]").focus();
                    }
                })
            })
        }
    </script>
   
<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>



















