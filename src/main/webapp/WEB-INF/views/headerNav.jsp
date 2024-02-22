<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Header -->
    <header class="header">
        <nav class="header__nav">
            <ul class="header__menu">
                <li><a class="header__menu__item" href="${pageContext.request.contextPath}/goProductList">STORE</a></li>
                <div class="header__menu__item header__logo">
                    <a href="${pageContext.request.contextPath}/main">
                        <img class="header__logo__img" src="images/logoName.png" alt="logo" />
                    </a>
                </div>
                <li><a class="header__menu__item servicePopup" >GROUP</a></li>
            </ul>
            <ul class="header__side">
            <c:choose>
                <c:when test="${not empty sellerEmail}">
                    <li class="header__userSeller">
                        <a class="header__menu__item" href="${pageContext.request.contextPath}/myPageSeller">
                            <i class="fa-regular fa-user"></i>
                        </a>
                    </li>
                </c:when>
                <c:when test="${not empty buyerEmail}">
                    <li class="header__cart">
                        <a class="header__menu__item" href="${pageContext.request.contextPath}/cartOrPayment">
                            <i class="fa-solid fa-cart-shopping"></i>
                        </a>
                    </li>
                    <li class="header__userBuyer">
                        <a class="header__menu__item" href="${pageContext.request.contextPath}/myPageBuyer">
                            <i class="fa-regular fa-user"></i>
                        </a>
                    </li>
                </c:when>
            </c:choose>
        </ul>
        </nav>
    </header>