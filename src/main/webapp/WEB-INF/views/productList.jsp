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
    <script type="module" src="${pageContext.request.contextPath }/js/category.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/popupSeller2.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/like.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/loginNon2.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/servicePopup.js" defer></script>
<%--     <script type="module" src="${pageContext.request.contextPath }/js/slideShow.js" defer></script> --%>
<%--     <script type="module" src="${pageContext.request.contextPath }/js/login.js" defer></script> --%>
    <%-- <script type="module" src="${pageContext.request.contextPath }/js/signup.js" defer></script> --%>
     <%--<script type="module" src="${pageContext.request.contextPath }/js/myPage.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/main.js" defer></script> --%>
    <script>
    function updateSortClass(sortValue) {
        console.log(sortValue);

        let productList__sortRecentButton = document.querySelector('.productList__sortRecentButton');
        let productList__sortMostLikedButton = document.querySelector('.productList__sortMostLikedButton');
        let productList__sortBestSellingButton = document.querySelector('.productList__sortBestSellingButton');

        let clickedElement = document.querySelector('.clicked');
        if (clickedElement) {
            clickedElement.classList.remove('clicked');
        }

        if (sortValue === 'recent') {
            productList__sortRecentButton.classList.add('clicked');
        } else if (sortValue === 'mostLiked') {
            productList__sortMostLikedButton.classList.add('clicked');
        } else if (sortValue === 'bestSelling') {
            productList__sortBestSellingButton.classList.add('clicked');
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        let productList__sortRecentButton = document.querySelector('.productList__sortRecentButton');
        let productList__sortMostLikedButton = document.querySelector('.productList__sortMostLikedButton');
        let productList__sortBestSellingButton = document.querySelector('.productList__sortBestSellingButton');

 
        productList__sortRecentButton.addEventListener('click', function() {
            updateSortClass('recent');
        });

        productList__sortMostLikedButton.addEventListener('click', function() {
            updateSortClass('mostLiked');
        });

        productList__sortBestSellingButton.addEventListener('click', function() {
            updateSortClass('bestSelling');
        });


        updateSortClass('${sort}'); 
    });

</script>


</head>
<body>
<%@ include file = "/WEB-INF/views/headerNav.jsp" %>
	
   <!-- Category -->
    <section id="mainCategory" class="section mainCategorySection">
       <div class="max-container" >
       		<div class="controller" >
                        <button id="categoryPrevBtn"><span id="categoryPrev" >&lang;</span></button>
                        <button id="categoryNextBtn"><span id="categoryNext" >&rang;</span></button>
            </div>
        <h1 class="mainCategory__title">Category</h1>
            	<ul id="categoryList" class="mainCategory" >
					
                    <c:forEach items="${categoryList}" var="categoryDO" >
        			<li class="mainCategory__detail" id="${categoryDO.categoryNum}">
        				<img alt="" class="mainCategory__detailImg" src="${categoryDO.categoryImg}" />
        				<p class="mainCategory__detailTitle">${categoryDO.categoryName}</p>
        			</li>
        			</c:forEach>			
               </ul>
              		
              </div>   	
    </section>
    <!--productList  -->
    <section id="productList" class="section">
        <div class="max-container">
            <div class="productList">
                <div class="productList__sortSerch">
                    <div class="productList__sortDiv">
                        <form action="goProductList" method="GET" id="sorting" class="goProductList">
	                        <div class="productList__sortSerchButtonDiv">
		                        <button class="productList__sort productList__sortRecentButton clicked" name="sort" value="recent" type="submit">최신순</button>
		                        <button class="productList__sort productList__sortMostLikedButton" name="sort" value="mostLiked" type="submit">인기순</button>
		                        <button class="productList__sort productList__sortBestSellingButton" name="sort" value="bestSelling" type="submit">판매량순</button>
	                    	</div>
	                       	<div class="productList__search">
	                       		<input type="text" class="productList__searchInput" id="searchInput" name="search" placeholder="검색어를 입력해주세요." /><i class="fa-solid fa-magnifying-glass"></i>
	                       	</div>
	                        
                        </form>
                    </div>
                    <%--
                    <form class="productList__search">
                        <input type="text" class="productList__searchInput" id="searchInput" />
                        <button class="productList__searchButton" type="submit" name="search" value="search">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </form>
                    --%>
                </div>
                <div id="beansTable" class="productList__productDiv">
                <c:forEach items="${beansList}" var="bean">
                <c:choose>
                <c:when test="${ bean.beansDO.statusNumber == 0 }">
                    <div id=${bean.beansDO.beansNum} class="productList__product" onclick="let that = this; prodDetail2Handler(that)">
                    	<div class="productList__productImgDiv">
                    		<img class="productList__productImg" src="${bean.beansDO.beanImg}" alt="">
                    	</div>
                    	
                        <div class="productList__productText">
                            <table class="productList__table">
                                <tr>
                                    <th class="productList__productTitle">상품명 </th>
                                    <td class="productList__productTitle">${bean.beansDO.beanName}</td>
                                </tr>
                                <tr>
                                    <th class="productList__productPrice">가격 </th>
                                    <td class="productList__productPrice"><fmt:formatNumber pattern="#,###" value="${bean.beansDO.beanPrice}"/>원</td>
                                </tr>
                                <tr>
                                    <th class="productList__productDelivery">배송비</th>
                                    <td class="productList__productDelivery">Free </td>
                                </tr>
                                <tr>
                                    <th class="productList__productCategory">원산지</th>
                                    <td class="productList__productCategory">${bean.categoryName}</td>
                                </tr>
                            </table>
                            
                        </div>
                           <c:choose>
                               <c:when test="${not empty buyerEmail}">
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
                                                <button  name="beansNum" value="${bean.beansDO.beansNum}" class="myPageLike__button likeButton"><i class="fa-solid fa-heart"></i></button>
                                            </form>
                                        </c:when>
                                    </c:choose>
                                        <p class="mainBeanBest__productLikeCount">${bean.beansDO.likeCount}</p>
                                    </div>
                               </c:when>
	                           <c:when test="${not empty sellerEmail}">
		                           	<div class="productList__likeButton">
			                            <button name="beansNum" value="${bean.beansDO.beansNum}" class="myPageLike__button sellerLikeButton"><i class="fa-regular fa-heart"></i></button>
			                            <p class="product__productLikeCount">${bean.beansDO.likeCount}</p>
			                        </div>
		                        </c:when>
		                        <c:when test="${empty buyerEmail and empty sellerEmail}">
		                           	<div class="productList__likeButton">
			                            <button name="beansNum" value="${bean.beansDO.beansNum}" class="myPageLike__button NonLikeButton"><i class="fa-regular fa-heart"></i></button>
			                            <p class="product__productLikeCount">${bean.beansDO.likeCount}</p>
			                        </div>
		                        </c:when>
		                    </c:choose>
                       
                    </div>
                </c:when>
                </c:choose>
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
					    
					</c:if>
                    <c:if test="${currentPage < totalPages}">
					    <c:url var="nextUrl" value="/goProductList">
					        <c:param name="page" value="${currentPage + 1}" />
					        <c:if test="${not empty search}">
					            <c:param name="search" value="${search}" />
					        </c:if>
					        <c:param name="sort" value="${sortOption}" />
					        <c:param name="category" value="${categoryNum}" />
					    </c:url>
					    
					</c:if>
					<div class="productList__nextPrev">
						<a class="productList__button" href="${prevUrl}"><i class="fa-solid fa-angles-left"></i></a>
						<a class="productList__button" href="${nextUrl}"><i class="fa-solid fa-angles-right"></i></a>
					</div>
                </div>
            </div>
        </div>
    </section>

<script>

    function prodDetail2Handler(that) {
        //alert('div가 눌려졌음');
        let beans = that.getAttribute('id');
        // alert(beans);
        let url = '/coffee/goListDetail?beansNum=' + beans;
        location.href = url;
    }
    
</script>
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>