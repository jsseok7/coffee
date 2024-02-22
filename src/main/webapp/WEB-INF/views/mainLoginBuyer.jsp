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
    <script type="module" src="${pageContext.request.contextPath }/js/category.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/bestBean.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/servicePopup.js" defer></script>
<%--     <script type="module" src="${pageContext.request.contextPath }/js/slideShow.js" defer></script> --%>
    
<%--     <script type="module" src="${pageContext.request.contextPath }/js/login.js" defer></script> --%>
    <%-- <script type="module" src="${pageContext.request.contextPath }/js/signup.js" defer></script> --%>
     <%--<script type="module" src="${pageContext.request.contextPath }/js/myPage.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/main.js" defer></script> --%>
</head>
<body>
<%@ include file = "/WEB-INF/views/headerNav.jsp" %>

     <!-- Main -->
     <section id="mainIntro" class="section">
       <div class="max-container">
             <div class="mainIntro">
                 <div id="slideShow" class="mainIntro__intro">
                    <ul class="slides">
                        <li><img class="introImg" src="images/main1.gif" alt=""></li>
                        <li><img class="introImg" src="images/main2.png" alt=""></li>
                        <li><img class="introImg" src="images/main3.png" alt=""></li>
                    </ul>  
                    <div class="controller">
                        <span class="prev">&lang;</span>  
                        <span class="next">&rang;</span>
                    </div>
                </div>

                 <div class="mainIntro__loginAll">
                     <div class="mainIntro__login">
                         <div class="userImgDiv">
                             <img class="userImg" src="${buyer.buyerImg}" alt="">
                         </div>



                         	<div class="mainIntro__buyer">
                                <p class="mainIntro__loginId">${buyer.nickname }<span class="mainIntro__loginIdText">님</span><span class="mainIntro__loginIdText"> 환영합니다.</span></p>
                             	<p class="mainIntro__loginPoint"><span class="mainIntro__loginPointText"> 현재 잔액 : </span><fmt:formatNumber pattern="#,###" value="${buyer.point}"/> <span class="mainIntro__loginPointText"> point</span></p>
                             	<div class="mainIntro__button">
                                	<form method="Get" action="loginAfter">
                                        <button class="mainIntro__AfterButton" type="submit" name="action" value="buyerModify">정보수정 <i class="fa-solid fa-gear"></i></button>
                                  		<button class="mainIntro__AfterButton" type="submit" name="action" value="logout">로그아웃 <i class="fa-solid fa-arrow-right-from-bracket"></i></button>

                                   	</form>
                             	</div>
                         	</div>
                     </div>
                 </div>
             </div>
         </div>
     </section>
    <!-- Category -->
    <%@ include file = "/WEB-INF/views/category.jsp" %>
    <!-- BeanBest -->

    <section id="mainBeanBest" class="section">
         <div class="max-container">
        <h1 class="mainBeanBest__title">Best</h1>
            <div class="mainBeanBest">
  				<c:forEach items="${bestBean}" var="beansDO" >
                    <div class="mainBeanBest__product">
                    	<img src="" alt="" class="beanBest__number">

        				<img src="${beansDO.beanImg}"  alt="" class="mainBeanBest__productImg" id="${ beansDO.beansNum}" >
                    	<form method="get" action="goListDetail" class="bestBeanForm">
                			<input type="hidden" id="beansNum" name="beansNum" value="${beansDO.beansNum}" />
                			<button>
                			</button>
                   		</form>
        				<p class="productList__productTitle"><span class="bestBean__span">상품명</span> ${beansDO.beanName }</p>
        				<p class="bestBean__productPrice"><span class="bestBean__span">가격</span> ${beansDO.beanPrice}원</p>
        				<div class="likeButton">
                        	<button class="myPageLike__button"><i class="fa-solid fa-heart"></i></button>
                        	<p class="mainBeanBest__productLikeCount">${beansDO.likeCount}</p>
                    	</div>
                    </div>

    			</c:forEach>
            </div>
 	         <div class="mainBeanBest__button">
 	         	<h2 class="mainBeanBest__buttonTitle">더 많은 원두를 보려면?</h2>
 	         	<form method="get" action="goProductList">
 	         	    <button id="popupButton"  class="mainBeanBest__plusButton"><i class="fa-solid fa-angles-right"></i></button>	
 	 			</form>

            </div>
        </div>
    </section>
    <div class="sources">
        출처 <a href="https://kr.freepik.com/free-vector/number-collection-with-golden-style_2304153.htm#query=%EC%88%9C%EC%9C%84&from_query=%EB%93%B1%EC%88%98&position=7&from_view=search&track=sph">Freepik</a>
    </div>


<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>