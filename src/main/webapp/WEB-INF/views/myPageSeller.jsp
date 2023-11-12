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
    <section id="myPageNav" class="section">
        <div class="max-container">
            <div class="myPageNav">
                <button id="myPageNav__likeButton" class="myPageNav__button" >판매 중 게시물</button>
                <button id="myPageNav__purchaseButton" class="myPageNav__button">일반상품판매내역</button>
                <button id="myPageNav__purchaseGroupButton" class="myPageNav__button">공동구매판매내역</button>
            </div>
        </div>
    </section>
        <!-- myPageLike -->
    <section id="myPageLike" class="section">
        <div class="max-container">
        	<div>
        		<h2 class="myPageLike__title">판매 중인 게시물을 확인해보세요!</h2> 
            	<div id="sellList" class="myPageLike">
            		<c:forEach items="${sellList}" var="beansDO">
                		<div id="${beansDO.beansNum}" class="myPageLike__product" onclick="let that = this; sellListHandler(that)">
                    		<img class="myPageLike__productImg" src="${beansDO.beanImg}" alt="buyerImg" />
                    		<div class="myPageLike__productInfo">
                        		<p class="myPageLike__productName">${beansDO.beanName}</p>
                        		<p class="myPageLike__productPrice">${beansDO.beanPrice}원</p>
                    		</div>
                            <form method="get" action="productModify">
                            <input type="hidden" name="beansNum" value="${beansDO.beansNum }" />
                             <button type="submit" class="myPageLike__hate">
                             <i class="fa-solid fa-heart"></i></button>
                            </form>
                		</div>
                	</c:forEach>
            	</div>
        	</div>
        </div>
    </section>
    <section id="myPagePurchase" class="section">
        <div class="max-container">	
        		<h2 class="myPagePurchase__title">일반상품 판매내역을 확인해보세요!</h2> 
            	<div class="myPagePurchase">
            		<c:forEach items="${orderList}" var="OrderProductDO">
                		<div class="myPagePurchase__product">
                    		
                    		<div class="myPagePurchase__productInfo">
                        		<p class="myPagePurchase__productName">${OrderProductDO.orderDatetime}</p>
                        		<p class="myPagePurchase__productPrice">${OrderProductDO.orderTotalPrice}</p>
                    		</div>
                    		<button class="myPagePurchase__detail"><i class="fa-solid fa-heart"></i></button>
                		</div>
                	</c:forEach>
            	</div>
        	</div>
   		</div>
    </section>
    <section id="myPagePurchaseGroup" class="section">
        <div class="max-container">
        	<div>
        		<h2 class="myPagePurchaseGroup__title">공동구매 판매내역을 확인해보세요!</h2> 
            	<div class="myPagePurchaseGroup">
            		<c:forEach items="${likeList}" var="beansDO">
                		<div class="myPagePurchaseGroup__product">
                    		<img class="myPagePurchaseGroup__productImg" src="${beansDO.beanImg}" alt="buyerImg" />
                    		<div class="myPagePurchaseGroup__productInfo">
                        		<p class="myPagePurchaseGroup__productName">${beansDO.beanName}</p>
                        		<p class="myPagePurchaseGroup__productPrice">${beansDO.beanPrice}</p>
                    		</div>
                    		<button class="myPagePurchaseGroup__detail"><i class="fa-solid fa-heart"></i></button>
                		</div>
                	</c:forEach>
            	</div>
        	</div>
        </div>
    </section>
    <div class="myPageSources">
        출처 <a href="https://kr.freepik.com/free-vector/flat-design-profile-icon-set_29332702.htm#query=%EC%82%AC%EC%9A%A9%EC%9E%90&position=4&from_view=search&track=sph">Freepik</a>
    </div>
<script>

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