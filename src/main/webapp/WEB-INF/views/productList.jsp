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
    <script type="module" src="${pageContext.request.contextPath }/js/sortActive.js" defer></script>
<%--     <script type="module" src="${pageContext.request.contextPath }/js/slideShow.js" defer></script> --%>
    
<%--     <script type="module" src="${pageContext.request.contextPath }/js/login.js" defer></script> --%>
    <%-- <script type="module" src="${pageContext.request.contextPath }/js/signup.js" defer></script> --%>
     <%--<script type="module" src="${pageContext.request.contextPath }/js/myPage.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/main.js" defer></script> --%>
</head>
<body>
<%@ include file = "/WEB-INF/views/headerNav.jsp" %>
     <!-- Category -->
    <%@ include file = "/WEB-INF/views/category.jsp" %> 

    <!--productList  -->
    <section id="productList" class="section">
        <div class="max-container">
            <div class="productList">
                <div class="productList__sortSerch">
                    <div class="productList__sortDiv">
                        <span class="productList__sortText">정렬</span>

                        <form action="goProductList" method="GET" id="sorting">
                        <label for="category">카테고리:</label>	
							<select id="category" name="category">
                                <option value="0" ${param.category == '0' ? 'selected' : '' }>전체</option>
                                <option value="1" ${param.category == '1' ? 'selected' : '' }>브라질</option>
                                <option value="2" ${param.category == '2' ? 'selected' : '' }>콜롬비아</option>
                                <option value="3" ${param.category == '3' ? 'selected' : '' }>에티오피아</option>
                                <option value="4" ${param.category == '4' ? 'selected' : '' }>온두라스</option>
                                <option value="5" ${param.category == '5' ? 'selected' : '' }>인도</option>
                                <option value="6" ${param.category == '6' ? 'selected' : '' }>인도네시아</option>
                                <option value="7" ${param.category == '7' ? 'selected' : '' }>멕시코</option>
                                <option value="8" ${param.category == '8' ? 'selected' : '' }>페루</option>
                                <option value="9" ${param.category == '9' ? 'selected' : '' }>우간다</option>
                                <option value="10" ${param.category == '10' ? 'selected' : '' }>베트남</option>
                                
						    </select>
	                        <button class="productList__sortRecent productList__sort productActive" name="sort" value="recent" type="submit">최신순</button>
	                        <button class="productList__sortLike productList__sort" name="sort" value="mostLiked" type="submit">인기순</button>
	                        <button class="productList__sortBest productList__sort" name="sort" value="bestSelling" type="submit">판매량순</button>
                        </form>
                    </div>
                    <form class="productList__search">
                        <input type="text" class="productList__searchInput" id="searchInput" />
                        <button class="productList__searchButton" type="submit" name="search" value="search">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button> 
                    </form>
                </div>
                <div id="beansTable" class="productList__productDiv">
                <c:forEach items="${beansList}" var="bean">
                    <div id=${bean.beansDO.beansNum} class="productList__product" onclick="let that = this; prodDetail2Handler(that)">
                        <img class="productList__productImg" src="${bean.beansDO.beanImg}" alt="">
                        <div class="productList__productText">

                            <p class="productList__productTitle">${bean.beansDO.beanName}</p>
                            <p class="productList__productPrice">${bean.beansDO.beanPrice}원</p>
                            <div class="productList__likeButton">

                            <c:choose>
                				<c:when test="${bean.aBoolean == false}">
                                    <form method="GET" action="like" >
                                        <input type="hidden" name="sort" value=${sortOption}>
                                        <input type="hidden" name="page" value=${currentPage}>
                                        <button name="beansNum" value="${bean.beansDO.beansNum}" class="myPageLike__button"><i class="fa-regular fa-heart"></i></button>
                                    </form>
                				</c:when>
                				<c:when test="${bean.aBoolean == true}">
                                    <form method="GET" action="like">
                                        <input type="hidden" name="sort" value=${sortOption}>
                                        <input type="hidden" name="page" value=${currentPage}>
                                        <button name="beansNum" value="${bean.beansDO.beansNum}" class="myPageLike__button"><i class="fa-solid fa-heart"></i></button>
                                    </form>
                				</c:when>
                			</c:choose>
                                <p class="mainBeanBest__productLikeCount">${bean.beansDO.likeCount}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                </div>
                <div class="productList__buttonDiv">
                    <%--<button class="productList__button"><i class="fa-solid fa-angles-left"></i></button>--%>
                    <c:if test="${currentPage > 1}">
					    <c:url var="prevUrl" value="/goProductList">
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
					    <c:url var="nextUrl" value="/goProductList">
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


<!-- <script>
    function categoryHandler () {
        document.querySelector('#sorting').submit();
    }

    function prodDetail2Handler(that) {
        //alert('div가 눌려졌음');

        let beans = that.getAttribute('id');
        // alert(beans);

        let url = '/coffee/goListDetail?beansNum=' + beans;
        location.href = url;
    }

    // function prodDetailHandler(event) {
    //     let beans = event.getAttribute('id');
    //     alert(beans);
    //
    //     let url = '/coffee/goListDetail?beansNum=' + beans;
    //     location.href = url;
    // }

    function init() {
        document.querySelector('#category').addEventListener('change', categoryHandler);
        document.querySelector('#beansTable').addEventListener('click', prodDetailHandler);

    }
    window.addEventListener('load', init);
</script> -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>

