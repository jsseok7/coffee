<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.product.BeansDO"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
	<h1>Group Beans List</h1>

	<form action="/coffee/goProductListGroup" method="GET">
		<select id="category" name="category">
		           	<option value="0" ${param.category == '0' ? 'selected' : '' }>전체</option>      	
		           	<option value="1" ${param.category == '1' ? 'selected' : '' }>코스타리카</option>      	
		           	<option value="2" ${param.category == '2' ? 'selected' : '' }>케냐</option>
		    </select>
		<button type="submit" name="sort" value="bestSelling">판매량 높은 순</button>
		<button type="submit" name="sort" value="mostLiked">좋아요 높은 순</button>
		<input type="text" name="search" placeholder="검색어 입력">
	</form>

	<p>현재 정렬 옵션: ${sortOption}</p>
	<table border="1">
		<tr>
			<th>상품번호</th>
			<th>상품명</th>
			<th>가격</th>
			<th>이미지</th>
			<th>찜수</th>
			<th>마감 기한</th>
			<th>목표 kg</th>
			<th>할인 된 가격</th>
			<th>판매량</th>
		</tr>
		<c:forEach items="${groupBeansList}" var="bean">
			<tr>
				<td>${bean.beansNum}</td>
				<td>${bean.beanName}</td>
				<td>${bean.beanPrice}</td>
				<td>${bean.beanImg}</td>
				<td>${bean.likeCount}</td>
				<td>${bean.deadline}</td>
				<td>${bean.goalQty}</td>
				<td>${bean.goalPrice}</td>
				<td>${bean.beanTotalSellCount}</td>
			</tr>
		</c:forEach>
	</table>
	<c:if test="${currentPage > 1}">
		<c:url var="prevUrl" value="/goProductListGroup">
			<c:param name="page" value="${currentPage - 1}" />
			<c:if test="${not empty search}">
				<c:param name="search" value="${search}" />
			</c:if>
			<c:param name="sort" value="${sortOption}" />
        	<c:param name="category" value="${categoryNum}" />
		</c:url>
		<a href="<c:out value='${prevUrl}'/>">Prev</a>
	</c:if>
	<c:if test="${currentPage < totalPages}">
		<c:url var="nextUrl" value="/goProductListGroup">
			<c:param name="page" value="${currentPage + 1}" />
			<c:if test="${not empty search}">
				<c:param name="search" value="${search}" />
			</c:if>
			<c:param name="sort" value="${sortOption}" />
        	<c:param name="category" value="${categoryNum}" />
		</c:url>
		<a href="<c:out value='${nextUrl}'/>">Next</a>
	</c:if>

<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>