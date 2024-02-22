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

<<!-- Cart -->
    <section id="cart" class="section">
        <div class="max-container">
            <div class="cart">
                <h2 class="signup__title">${buyer.buyerName}님의 구매 내역</h2>
                <c:set var="totalPrice" value="0"/>
                <c:forEach items="${bean}" var="beans">
                	<c:set var="totalPrice" value="${ beans.beansDO.beanPrice * beans.orderProductDetailDO.qty }" />
                	<div class="paymentProduct">
                    	<img class="cartProduct__img" src="${beans.beansDO.beanImg}" alt="">
                    	<div class="cartProductInfo">
                        	<p class="cartProductInfo__Name">${beans.beansDO.beanName}</p>
                        	<div class="cartProductInfo__QtyDiv">
                            	<p class="cartProductInfo__QtyText">${beans.orderProductDetailDO.qty} 개</p>	
                        	</div>
                        	<p class="cartProductInfo__price"><fmt:formatNumber pattern="#,###" value="${beans.beansDO.beanPrice}"/>원</p>
                    	</div>
                	</div>
                </c:forEach>

                <div class="paymentCompletePrice">
                    <p class="cartTotalPriceText">결제 금액 : <p class="cartTotalPrice"><fmt:formatNumber pattern="#,###" value="${beforeOrderPoint.orderTotalPrice}"/>원</p></p>

                    <p class="cartTotalPriceText">주문 후 잔액 : <p class="cartTotalPrice"><fmt:formatNumber pattern="#,###" value="${beforeOrderPoint.beforeOrderPoint}"/>원</p></p>
                </div>
                <div class="paymentCompleteButton">
                <form  method="get" action="goProductList">
                    <button class="cartPayment">확인</button>
                </form>
                </div>
            </div>
        </div>
    </section>

<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>