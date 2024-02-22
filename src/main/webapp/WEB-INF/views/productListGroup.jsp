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
    <script type="module" src="${pageContext.request.contextPath }/js/category.js" defer></script>
<%--     <script type="module" src="${pageContext.request.contextPath }/js/slideShow.js" defer></script> --%>
    
<%--     <script type="module" src="${pageContext.request.contextPath }/js/login.js" defer></script> --%>
    <%-- <script type="module" src="${pageContext.request.contextPath }/js/signup.js" defer></script> --%>
     <%--<script type="module" src="${pageContext.request.contextPath }/js/myPage.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/main.js" defer></script> --%>
</head>
<body>
<%@ include file = "/WEB-INF/views/headerNav.jsp" %>

<!-- TimeOut -->
<section id="TimeOut" class="section">
    <div class="max-container">
        <div class="timeout">
            <img src="images/mainTest1.gif" alt="" class="timeOut__img">
        </div>
    </div>
</section>
<!-- Category -->
    <%@ include file = "/WEB-INF/views/category.jsp" %>

<!--productList  -->
<section id="productList" class="section">
    <div class="max-container">
        <div class="productList">
            <div class="productList__sortSerch">
                <div class="productList__sortDiv">
                    <span class="productList__sortText">정렬</span>
                    <form action="/coffee/goProductList" method="GET" id="sorting">
                        <label for="category">카테고리:</label>
                        <select id="category" name="category">
                            <option value="0" ${param.category == '0' ? 'selected' : '' }>전체</option>
                            <option value="1" ${param.category == '1' ? 'selected' : '' }>브라질</option>
                            <option value="2" ${param.category == '2' ? 'selected' : '' }>콜롬비아</option>
                            <option value="3" ${param.category == '3' ? 'selected' : '' }>에티오피아</option>
                            <option value="4" ${param.category == '4' ? 'selected' : '' }>온두라스</option>
                            <option value="5" ${param.category == '5' ? 'selected' : '' }>인도</option>
                        </select>
                        <button class="productList__sort" name="sort" value="recent" type="submit">최신순</button>
                        <button class="productList__sort" name="sort" value="mostLiked" type="submit">인기순</button>
                        <button class="productList__sort" name="sort" value="bestSelling" type="submit">판매량순</button>
                    </form>
                </div>
                <form class="productList__search">
                    <input type="text" class="productList__searchInput" id="searchInput" />
                    <button class="productList__searchButton" type="submit" name="action" value="search">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </form>
            </div>
            <div id="beansTable" class="productList__productDiv">
                <c:forEach items="${groupBeansList}" var="groupBean">
                    <div class="productList__product">
                        <img class="productList__productImg" src="images/test2.jpg" alt="">
                        <div class="productList__productText">
                            <p class="productList__productTitle">${groupBean.beanName}</p>
                            <p class="productList__productPrice">${groupBean.beanPrice}</p>
                            <p class="productList__productCategory">케냐</p>
                            <div class="productList__likeButton">
                                <button class="myPageLike__button"><i class="fa-solid fa-heart"></i></button>
                                <p class="mainBeanBest__productLikeCount">${groupBean.likeCount}</p>
                            </div>
                        </div>
                        <button class="productList__button" id="${groupBean.beansNum}">상세보기</button>
                    </div>
                </c:forEach>
            </div>
            <div class="productList__buttonDiv">
                <%--<button class="productList__button"><i class="fa-solid fa-angles-left"></i></button>--%>
                <c:if test="${currentPage > 1}">
                    <c:url var="prevUrl" value="/goProductListGroup">
                        <c:param name="page" value="${currentPage - 1}" />
                        <c:if test="${not empty search}">
                            <c:param name="search" value="${search}" />
                        </c:if>
                        <c:param name="sort" value="${sortOption}" />
                        <c:param name="category" value="${categoryNum}" />
                    </c:url>
                    <a class="productList__button" href="${prevUrl}"><i class="fa-solid fa-angles-left"></i></a>
                </c:if>

                <%-- <button class="productList__button"><i class="fa-solid fa-angles-right"></i></button> --%>
                <c:if test="${currentPage < totalPages}">
                    <c:url var="nextUrl" value="/goProductListGroup">
                        <c:param name="page" value="${currentPage + 1}" />
                        <c:if test="${not empty search}">
                            <c:param name="search" value="${search}" />
                        </c:if>
                        <c:param name="sort" value="${sortOption}" />
                        <c:param name="category" value="${categoryNum}" />
                    </c:url>
                    <a class="productList__button" href="${nextUrl}"><i class="fa-solid fa-angles-right"></i></a>
                </c:if>
            </div>
        </div>
    </div>
</section>
<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>