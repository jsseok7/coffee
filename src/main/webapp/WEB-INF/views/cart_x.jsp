<%@ page contentType="text/html; charset=UTF-8" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Seo -->
<title>Bean2B</title>
<%@ include file="/WEB-INF/views/header.jsp"%>
<!-- CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/signupStyle.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/productStyle.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/myPageStyle.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/mainStyle.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/cartStyle.css">
<!-- Javascript -->
<script type="module"
	src="${pageContext.request.contextPath }/js/cart.js" defer></script>
<%--     <script type="module" src="${pageContext.request.contextPath }/js/slideShow.js" defer></script> --%>

<%--     <script type="module" src="${pageContext.request.contextPath }/js/login.js" defer></script> --%>
<%-- <script type="module" src="${pageContext.request.contextPath }/js/signup.js" defer></script> --%>
<%--<script type="module" src="${pageContext.request.contextPath }/js/myPage.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/main.js" defer></script> --%>
</head>
<body>
	<%@ include file="/WEB-INF/views/headerNav.jsp"%>

	<!-- Cart -->
	<section id="cart" class="section">
		<div class="max-container">
			<div class="cart" id="cartList">
				<h2 class="cartTitle">님의 장바구니</h2>
				<c:forEach items="${cart}" var="cart" varStatus="index">
					<div class="cartProduct">

						<c:choose>
							<c:when test="${cart.beansDO.beansNum eq checkedBeansNum}">
								<input type="checkbox" class="cartProduct__check"
									id="${cart.beansDO.beansNum}" value="${cart.cartDO.qty}"
									data-index="${index.count}" checked />
							</c:when>
							<c:otherwise>
								<input type="checkbox" class="cartProduct__check"
									id="${cart.beansDO.beansNum}" value="${cart.cartDO.qty}"
									data-index="${index.count}" />
							</c:otherwise>
						</c:choose>
						<img class="cartProduct__img" src="${cart.beansDO.beanImg}" alt="">

						<div class="cartProductInfo">
							<p class="cartProductInfo__Name">${cart.beansDO.beanName}</p>
							<div class="cartProductInfo__QtyDiv" id="qtyBtn">
								<button class="cartProductInfo__plus cartProduct__check"
									id="plus" disabled>
									<i class="fa-solid fa-plus"></i>
								</button>
								<span class="qty cartProduct__check">${cart.cartDO.qty}</span>개
								<button class="cartProductInfo__minus cartProduct__check"
									id="minus" disabled>
									<i class="fa-solid fa-minus"></i>
								</button>
							</div>
							<p class="cartProductInfo__price">${cart.beansDO.beanPrice}</p>
						</div>
						<form method="post" id="hiddenForm">
							<input type="hidden" id="beansNum" name="beansNum" value="${checkedBeansNum}">
							<input type="hidden" id="qty" name="qty" value="${checkedQty}">
						</form>
						<form method="POST" type="hidden" id="hiddenForm"
							action="/deleteItem">
							<input type="hidden" name="beansNum"
								value="${cart.beansDO.beansNum}" />
							<button type="submit" class="cartProductInfo__delete" id="delete">
								<i class="fa-solid fa-trash"></i>
							</button>
						</form>
					</div>
				</c:forEach>

				<div class="cartPrice">

					<p class="cartTotalPriceText">
						합산 금액: <span id="totalPrice">${totalPrice}</span>원
					</p>
					<button type="submit" class="cartPayment">결제</button>

				</div>
			</div>
		</div>
	</section>

	<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>
