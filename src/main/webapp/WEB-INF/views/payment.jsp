<%@ page contentType="text/html; charset=UTF-8" 
	import="java.util.*"
    	  %>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
    <script type="module" src="${pageContext.request.contextPath }/js/servicePopup.js" defer></script>
<%--     <script type="module" src="${pageContext.request.contextPath }/js/slideShow.js" defer></script> --%>
    
<%--     <script type="module" src="${pageContext.request.contextPath }/js/login.js" defer></script> --%>
    <%-- <script type="module" src="${pageContext.request.contextPath }/js/signup.js" defer></script> --%>
     <%--<script type="module" src="${pageContext.request.contextPath }/js/myPage.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/main.js" defer></script> --%>
</head>
<body>
<%@ include file = "/WEB-INF/views/headerNav.jsp" %>

<<!-- Payment -->
    <section id="cart" >
        <div class="max-container">
            <div class="cart">
                <h2 class="cartTitle">결제진행</h2>
                <c:forEach items="${bean}" var="beansDO">
                	<div class="paymentProduct">
                    	<img class="cartProduct__img" src="${beansDO.beanImg}" alt="">
                    	<div class="cartProductInfo">
                        	<p class="cartProductInfo__Name">상품명 : ${beansDO.beanName}</p>
                        	<div class="cartProductInfo__QtyDiv">
                            	<button class="cartProductInfo__QtyButton"><i class="fa-solid fa-plus"></i></button>
                            	<input type="text" class="cartProductInfo__QtyText" value="수량 : ${beansDO.beanPrice}개" />	
                            	<button class="cartProductInfo__QtyButton"><i class="fa-solid fa-minus"></i></button>
                        	</div>
                        	<p class="cartProductInfo__price"><fmt:formatNumber pattern="#,###" value="가격 : ${beansDO.beanPrice}"/>원</p>
                    	</div>
                	</div>
                </c:forEach>

                <div class="paymentPrice">
                    <p class="cartTotalPriceText">합산 금액 :</p>
                    <p class="cartTotalPrice"><fmt:formatNumber pattern="#,###" value="${beansDO.beanPrice}"/>원</p>
                </div>
                <div class="paymentPrice">
                    <button class="cartPayment">취소</button>
                    <button class="cartPayment">결제</button>
                </div>
            </div>
        </div>
    </section>

<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>