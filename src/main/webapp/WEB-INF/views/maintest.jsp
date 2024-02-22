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
<%--     <script type="module" src="${pageContext.request.contextPath }/js/slideShow.js" defer></script> --%>
    
<%--     <script type="module" src="${pageContext.request.contextPath }/js/login.js" defer></script> --%>
    <%-- <script type="module" src="${pageContext.request.contextPath }/js/signup.js" defer></script> --%>
     <%--<script type="module" src="${pageContext.request.contextPath }/js/myPage.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/main.js" defer></script> --%>
</head>
<body>
<%@ include file = "/WEB-INF/views/headerNav.jsp" %>
<!-- Main -->
    <section id="mainIntro">
        <div class="max-container">
            <div class="mainIntro">
                <div class="mainIntro__intro">
                    <img src="images/mainTest1.gif" alt="">
                </div>
                <div class="mainIntro__login">
                    <form id="mainIntro__loginForm" action="Controller">
                        <label><input type="radio" name="login" value="buyer"/>구매자</label>
                        <label><input type="radio" name="login" value="seller"/>판매자</label>
                        <label for="id" class="login__label">
                            <i class="fa-regular fa-user"></i>
                            <input
                                class="login__input"
                                type="email"
                                id="userId"
                                name="id"
                                placeholder="email@example.com"
                            />
                        </label> 
                        <label for="password" class="login__label">
                            <i class="fa-solid fa-lock"></i>
                            <input
                                class="login__input"
                                type="password"
                                id="userPassword"
                                name="passwd"
                                placeholder="비밀번호 입력"
                            />
                        </label>
                        <button class="mainIntro__loginButton">로그인</button>
                        <button class="mainIntro__loginButton">회원가입</button>
                    </form>
                </div>
            </div>
        </div>

    </section>
    <!-- Category --><!-- js적용시키려고 div id를 categoryList로 변경 -->
    <section id="mainCategory">
        <div class="max-container">
        <button id="nextBtn"> > </button>
            <div id="categoryList">
                   <c:forEach items="${categoryList}" var="categoryDO" >
        			<span class="mainCategory__detailTitle"></span>
        			<button id="categoryName" categoryName="${categoryDO.categoryName}" >${categoryDO.categoryName}</button>
        			</c:forEach>
            </div>
            <button id="prevBtn"> < </button>
        </div>
    </section>
    <!-- BeanBest --><!-- 좋아요 정보 ${beansDO.likeCount} 를 이미지 오른쪽 구석에 넣어주세요
    					  이미지를 가로로 정렬해주세요, 크기도 맞춰주세요-->
    <section id="mainBeanBest">
        <div class="max-container">
            <div class="mainBeanBest">
                <div class="mainBeanBest__product">
                    <p class="mainBeanBest__productTitle"></p>
                    <c:forEach items="${bestBean}" var="beansDO" >
        			<div><img src="${beansDO.beanImg}" ></div>
       				<span>${beansDO.likeCount}</span>
    				</c:forEach>
                    <p class="mainBeanBest__productLikeCount"></p>
                </div>
                <div class="mainBeanBest__button">
                    <button class="mainBeanBest__plusButton">더보기</button>
                </div>
            </div>
        </div>
    </section>


<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>