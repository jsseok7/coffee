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
    <script type="module" src="${pageContext.request.contextPath }/js/servicePopup.js" defer></script>
    <%--     <script type="module" src="${pageContext.request.contextPath }/js/slideShow.js" defer></script> --%>

    <%--     <script type="module" src="${pageContext.request.contextPath }/js/login.js" defer></script> --%>
    <%-- <script type="module" src="${pageContext.request.contextPath }/js/signup.js" defer></script> --%>
    <%--<script type="module" src="${pageContext.request.contextPath }/js/myPage.js" defer></script>
   <script type="module" src="${pageContext.request.contextPath }/js/main.js" defer></script> --%>
</head>
<body>
<%@ include file = "/WEB-INF/views/headerNav.jsp" %>
<!-- registerProduct -->
<section id="signup__buyerModify" class="section">
    <div class="max-container">
    <div class="signup__buyerModify">
        <div class="modify__form-div">
            <h2 class="signup__title">Bean2B 일반 상품 수정을 진행합니다.</h2>
            <h4 class="signup__description">수정 가능한 부분을 수정해주세요!</h4>

            <form id="modify__form" enctype="multipart/form-data" method="get" action="setStatus">
                <label for="beanName" class="signup__label">
                    <img src="${pageContext.request.contextPath}/images/bean.png" alt="" class="bean__img signup__icon">
                    <input
                            class="signup__input"
                            type="text"
                            id="beansNum"
                            name="beansNum"
                            placeholder="${bean.beanName}"
                            disabled
                    />
                </label>
                <label for="beanPrice" class="signup__label">
                    <i class="fa-solid fa-tags signup__icon"></i>
                    <input
                            class="signup__input"
                            type="text"
                            id="beanPrice"
                            name="beanPrice"
                            placeholder="${bean.beanPrice}"
                            disabled
                    />
                </label>
                <label for="cName" class="signup__label">
                    <i class="fa-solid fa-flag-checkered signup__icon"></i>
                    <select class="signup__input" name="categoryNum" disabled>
                        <option value="0">${cname}</option>
                        <option value="1">베트남</option>
                    </select>
                </label>
                <label for="deliveryCharge" class="signup__label">
                    <i class="fa-solid fa-truck-fast signup__icon"></i>
                    <input
                            class="signup__input"
                            type="text"
                            id="deliveryCharge"
                            name="deliveryCharge"
                            placeholder="배송료: Free"
                            disabled
                    />
                </label>
                <label for="cName" class="signup__label">
                    <i class="fa-solid fa-flag-checkered signup__icon"></i>
                    <select class="signup__input" name="statusNumber">
                        <option value="0" >판매 중</option>
                        <option value="1">판매 종료</option>
                    </select>
                </label>
                <div class="signup__button-div">
                    <button class="signup__button" id="signup-button" name="command" value="cancel" type="submit">취소</button>
                    <button class="signup__button" id="signup-button" name="command" value="register" type="submit">등록</button>
                    <input type="hidden" id="beansNum" name="beansNum" value="${bean.beansNum }"/>
                </div>
            </form>
        </div>
    </div>
    </div>
</section>
<div class="sources">
    <a href="https://www.flaticon.com/kr/free-icons/" title="커피 아이콘">커피 아이콘  제작자: Freepik - Flaticon</a>
</div>
<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>