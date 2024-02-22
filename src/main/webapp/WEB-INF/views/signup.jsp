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
    <!-- javaScript -->
    <script type="module" src="${pageContext.request.contextPath }/js/servicePopup.js" defer></script>
</head>
<body>
<%@ include file = "/WEB-INF/views/headerNav.jsp" %>

    <!-- Signup -->
    <section id="signupSelect" class="section">
        <div class="max-container">
            <div class="signupSelect">
                <h2 class="signup__title">Bean2B 신규 회원 가입을 진행합니다.</h2> 
                <div class="signupSelect__div">
                    <div class="signupSelect__form-div">
                        <form id="signupSelect__form" method="get" action="goSignupSeller">
                            <div class="signupSelect__seller">
                                <h4 class="signupSelect__description"><p class="description__accent">Bean2B</p>와 함께 나만의 <p class="description__accent">&nbsp비즈니스</p>를 시작해보세요!</h4>
                                <img class="signup__img seller__img" src="${pageContext.request.contextPath}/images/sellerSignup.png" alt="Seller" />
                                <button class="signupSelect__button" id="signup-button" type="submit">판매회원 가입하기</button>
                            </div>
                        </form>
                    </div>
                    <div class="signupSelect__form-div">

                        <form id="signupSelect__form" method="get" action="goSignupBuyer">
                            <div class="signupSelect__seller">
                  				<h4 class="signupSelect__description"><p class="description__accent">Bean2B</p>에서 신선한 <p class="description__accent">&nbsp원두</p>를 만나보세요!</h4>
                                <img class="signup__img buyer__img" src="${pageContext.request.contextPath}/images/buyerSignup.png" alt="buyer" />
                                <button class="signupSelect__button" id="signup-button" type="submit">구매회원 가입하기</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="sources">
        <p> 이미지 출처: <a href="https://kr.freepik.com/free-vector/group-of-customers-shopping-in-online-store-and-huge-tablet-sale-at-internet-shop-buyer-with-purchases-in-cart-flat-illustration_16375160.htm#query=%EA%B5%AC%EB%A7%A4%EC%9E%90&position=0&from_view=search&track=sph">작가 pch.vector 출처 Freepik </a> 
            , <a href="https://kr.freepik.com/free-vector/shop-with-open-sign_8478120.htm#query=seller&position=4&from_view=search&track=sph#position=4&query=seller">Freepik</a>
        </p>
    </div>
    
<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>
     