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
    <script type="module" src="${pageContext.request.contextPath }/js/myPage.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/active.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/servicePopup.js" defer></script>
<%--     <script type="module" src="${pageContext.request.contextPath }/js/slideShow.js" defer></script> --%>
    
<%--     <script type="module" src="${pageContext.request.contextPath }/js/login.js" defer></script> --%>
    <%-- <script type="module" src="${pageContext.request.contextPath }/js/signup.js" defer></script> --%>
     <%--<script type="module" src="${pageContext.request.contextPath }/js/myPage.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/main.js" defer></script> --%>
</head>
<body>
<%@ include file = "/WEB-INF/views/headerNav.jsp" %>

    <!-- myPageInfo -->
    <section id="myPageInfo" class="section">
        <div class="max-container">
            <div class="myPageInfo">
                <div class="myPageInfo__info">
                    <img src="${seller.sellerImg}" alt="" class="myPageInfo__img">
                    <p class="myPageInfo__id">${seller.nickname}</p>
                </div>
                <div class="myPageInfo__po-mo">
                    <div class="myPageInfo__pointDiv">
                        <p class="myPageInfo__balance">${seller.point}</p>
                        <p class="myPageInfo__point">point</p>
                    </div>
                    <div class="myPageInfo__button">
                    <form method="get" action="sellerModify">
                        <button class="myPageInfo__modify"><i class="fa-solid fa-gear"></i></button>
                    </form>
                    <form method="get" action="loginAfter">
                        <button name="action" value="logout" class="myPageInfo__logout"><i class="fa-solid fa-arrow-right-from-bracket"></i></button>
                    </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- nav -->
    <section id="myPageNav">
        <div class="max-container">
            <div class="myPageNav">
                <button id="myPageNav__likeButton" class="myPageNav__button active" >등록한 상품</button>
                <button id="myPageNav__purchaseButton" class="myPageNav__button">일반상품판매내역</button>
                <button id="myPageNav__purchaseGroupButton servicePopup" class="myPageNav__button">공동구매판매내역</button>
            </div>
        </div>
    </section>
        <!-- myPageLike -->
    <section id="myPageLike" class="section">
        <div class="max-container">
        	<div>
        		<h2 class="myPageLike__title">판매 중인 게시물을 확인해보세요!</h2> 
            	<div id="sellList" class="myPageLike"> <!-- BeansDAO의 List<likeBeans> 클래스 -->
            		
            		<c:forEach items="${sellList}" var="beans" >
            		<c:choose>
              			<c:when test="${beans.beansDO.statusNumber == 0}">
	                		<div id="${beans.beansDO.beansNum}" class="myPageLike__product" onclick="let that = this; sellListHandler(that)">
	                    		<img class="myPageLike__productImg" src="${beans.beansDO.beanImg}" alt="buyerImg" />
	                    		<div class="productList__productText">
	                    			<table class="productList__table">
			                            <tr>
			                                <th class="productList__productTitle">상품명 </th>
			                                <td class="productList__productTitle">${beans.beansDO.beanName}</td>
			                            </tr>
			                            <tr>
			                                <th class="productList__productPrice">가격 </th>
			                                <td class="productList__productPrice"><fmt:formatNumber pattern="#,###" value="${beans.beansDO.beanPrice}"/>원</td>
			                            </tr>
			                            <tr>
			                                <th class="productList__productDelivery">배송비</th>
			                                <td class="productList__productDelivery">
			                                <fmt:formatNumber pattern="#,###" value="${beans.beansDO.deliveryCharge}"/>원</td>
			                            </tr>
			                            <tr>
			                                <th class="productList__productCategory">원두 종류</th>
			                                <td class="productList__productCategory">${beans.categoryName}</td>
			                            </tr>
			                        </table>
	                    		</div>
	                            <form method="get" action="productModify" class="productList__likeButton">
	                              <button name="beansNum" value="${beans.beansDO.beansNum}" class="myPageLike__hate"><i class="fa-solid fa-gear"></i></button>
	                            </form>
	                		</div>
            			</c:when>
            			<c:when test="${beans.beansDO.statusNumber == 1}">
	                		<div id="${beans.beansDO.beansNum}" class="myPageLike__product" onclick="let that = this; sellListHandler(that)">
	                    		<img class="myPageLike__productImg" src="${beans.beansDO.beanImg}" alt="buyerImg" />
		                    		<div class="sold-out">
		                    			<p>판매 종료</p>
		                    		</div>
		                    		<div class="productList__productText">
		                    			<table class="productList__table">
				                            <tr>
				                                <th class="productList__productTitle">상품명 </th>
				                                <td class="productList__productTitle">${beans.beansDO.beanName}</td>
				                            </tr>
				                            <tr>
				                                <th class="productList__productPrice">가격 </th>
				                                <td class="productList__productPrice"><fmt:formatNumber pattern="#,###" value="${beans.beansDO.beanPrice}"/>원</td>
				                            </tr>
				                            <tr>
				                                <th class="productList__productDelivery">배송비</th>
				                                <td class="productList__productDelivery">Closed</td>
				                            </tr>
				                            <tr>
				                                <th class="productList__productCategory">원두 종류</th>
				                                <td class="productList__productCategory">${beans.categoryName}</td>
				                            </tr>
				                        </table>
		                    		</div>
		                            <form method="get" action="productModify" class="productList__likeButton">
		                              <button name="beansNum" value="${beans.beansDO.beansNum}" class="myPageLike__hate"><i class="fa-solid fa-gear"></i></button>
		                            </form>
	                		</div>
            			</c:when>
            		</c:choose>
            		
            		<form method="get" action="modifyInfo" class="myPageInfo__button">
		             	<button name="beansNum" value="${beans.beansDO.beansNum}" 
		             	class="myPageLike__hate"><i class="fa-solid fa-gear"></i></button>
		            </form>
                	</c:forEach>
            	</div>
        	</div>
        </div>
    </section>
    <section id="myPagePurchase" class="section">
        <div class="max-container">	
        		<h2 class="myPagePurchase__title">일반상품 판매내역을 확인해보세요!</h2> 
            	<div class="myPagePurchase">
            		<c:forEach items="${sellList}" var="beans">
                		<div id="${beans.beansDO.beansNum}" class="myPageLike__product" onclick="let that = this; sellListHandler(that)">
                    		<img class="myPageLike__productImg" src="${beans.beansDO.beanImg}" alt="buyerImg" />
                          	<div class="productList__productText">
                    			<table class="productList__table">
		                            <tr>
		                                <th class="productList__productTitle">상품명 </th>
		                                <td class="productList__productTitle">${beans.beansDO.beanName}</td>
		                            </tr>
		                            <tr>
		                                <th class="productList__productPrice">가격 </th>
		                                <td class="productList__productPrice"><fmt:formatNumber pattern="#,###" value="${beans.beansDO.beanPrice}"/>원</td>
		                            </tr>
		                            <tr>
		                                <th class="productList__productDelivery">판매 수량</th>
		                                <td class="productList__productDelivery">${beans.beansDO.beanTotalSellCount}</td>
		                            </tr>
		                            <tr>
		                                <th class="productList__productCategory">총 판매 금액</th>
		                                <td class="productList__productCategory"><fmt:formatNumber pattern="#,###" value="${beans.beansDO.beanTotalSellCount * beans.beansDO.beanPrice}"/>원</td>
		                            </tr>
		                        </table>
                    		</div>
                		</div>
                	</c:forEach>
            	</div>
        	</div>
   		
    </section>
    <section id="myPagePurchaseGroup" class="section">
        <div class="max-container">	
        		<h2 class="myPagePurchase__title">공동구매 판매내역을 확인해보세요!</h2> 
            	<div class="myPagePurchase">
            		<c:forEach items="${sellList}" var="beans">
                		<div id="${beans.beansDO.beansNum}" class="myPageLike__product" onclick="let that = this; sellListHandler(that)">
                    		<img class="myPageLike__productImg" src="${beans.beansDO.beanImg}" alt="buyerImg" />
                          	<div class="productList__productText">
                    			<table class="productList__table">
		                            <tr>
		                                <th class="productList__productTitle">상품명 </th>
		                                <td class="productList__productTitle">${beans.beansDO.beanName}</td>
		                            </tr>
		                            <tr>
		                                <th class="productList__productPrice">가격 </th>
		                                <td class="productList__productPrice"><fmt:formatNumber pattern="#,###" value="${beans.beansDO.beanPrice}"/>원</td>
		                            </tr>
		                            <tr>
		                                <th class="productList__productDelivery">판매 수량</th>
		                                <td class="productList__productDelivery">${beans.beansDO.beanTotalSellCount}</td>
		                            </tr>
		                            <tr>
		                                <th class="productList__productCategory">총 판매 금액</th>
		                                <td class="productList__productCategory"><fmt:formatNumber pattern="#,###" value="${beans.beansDO.beanTotalSellCount * beans.beansDO.beanPrice}"/></td>
		                            </tr>
		                        </table>
                    		</div>
                		</div>
                	</c:forEach>
            	</div>
        	</div>
    </section>
    <div class="myPageSources">
        출처 <a href="https://kr.freepik.com/free-vector/flat-design-profile-icon-set_29332702.htm#query=%EC%82%AC%EC%9A%A9%EC%9E%90&position=4&from_view=search&track=sph">Freepik</a>
    </div>
<<script>


    function sellListHandler(that) {
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
        document.querySelector('#sellList').addEventListener('click', sellListHandler);

    }
    window.addEventListener('load', init);
</script>

<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>