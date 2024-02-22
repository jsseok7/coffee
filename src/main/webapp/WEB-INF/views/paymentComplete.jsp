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
    <script type="module" src="${pageContext.request.contextPath }/js/servicePopup.js" defer></script>
</head>
<body>
    <%@ include file = "/WEB-INF/views/headerNav.jsp" %>

    <!-- Cart -->
    <section id="cart" >
        <div class="max-container">
            <div class="cart">
                <h2 class="signup__title">상품 결제가 완료되었습니다.</h2> 
                <h4 class="signup__description">즐거운 쇼핑 되세요.</h4>
                <c:forEach items="${beansList}" var="list">

                	<div class="paymentProduct">
                    	<img class="cartProduct__img" src="${list.beansDO.beanImg}" alt="">
                    	<div class="cartProductInfo">
                        	<p class="cartProductInfo__Name">상품명 : ${list.beansDO.beanName}</p>
                        	<p class="cartProductInfo__Name">수량 : ${list.qty}개</p>
                        	<p class="cartProductInfo__price">상품 가격 : ${list.beansDO.beanPrice}원</p>
                    	</div>
                	</div>

                </c:forEach>

                <div class="paymentCompletePrice">
                    <p class="cartTotalPriceText">결제 금액 : <p class="cartTotalPrice"><fmt:formatNumber pattern="#,###" value="${orderList.orderTotalPrice}"/>원</p></p>
                    <p class="cartTotalPriceText">주문 후 잔액 : <p class="cartTotalPrice"><fmt:formatNumber pattern="#,###" value="${orderList.beforeOrderPoint - orderList.orderTotalPrice}"/>원</p></p>
                </div>
                <div class="paymentCompleteButton">
                    <form id="completeForm" method="get" action="goProductList">
                        <button class="cartPayment">확인</button>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>
