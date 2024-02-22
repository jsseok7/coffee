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
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script type="module" src="${pageContext.request.contextPath }/js/userImgUpload.js" defer></script> 
	<script type="module" src="${pageContext.request.contextPath }/js/servicePopup.js" defer></script>
<%--     <script type="module" src="${pageContext.request.contextPath }/js/slideShow.js" defer></script> --%>
    
<%--     <script type="module" src="${pageContext.request.contextPath }/js/login.js" defer></script> --%>
    <%-- <script type="module" src="${pageContext.request.contextPath }/js/signup.js" defer></script> --%>
     <%--<script type="module" src="${pageContext.request.contextPath }/js/myPage.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/main.js" defer></script> --%>
</head>
<body>
<%@ include file = "/WEB-INF/views/headerNav.jsp" %>

 <!-- SellerModify -->
    <section id="signup__sellerModify" class="section">
        <div class="max-container">
            <div class="modifySeller">
                <div class="modify__form-div">
                    <h2 class="signup__title">Bean2B 비즈니스 회원 정보를 수정해주세요.</h2> 
                    <form id="modify__form" enctype="multipart/form-data" method="post" action="sellerModifyChange">
                        <label for="new-userId" class="signup__label">
                            <i class="fa-regular fa-envelope"></i>
                            <input
                                class="signup__input"
                                type="email"
                                id="new-userId"
                                name="sellerEmail"
                                value="${ seller.sellerEmail }"
                                placeholder="email@example.com"
                                disabled
                            />
                        </label> 
                        <label for="new-sellerName" class="signup__label">
                            <i class="fa-regular fa-circle-user"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-sellerName"
                                name="nickname"
                                value="${ seller.nickname }"
                                placeholder="2자리 이상 입력해주세요."
                            />
                        </label>
                        <label for="new-phoneNumber" class="signup__label">
                            <i class="fa-solid fa-phone"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-phoneNumber"
                                name="tel"
                                value="${ seller.tel }"
                                placeholder="휴대폰번호를 입력해주세요."
                            />
                        </label>
                        <h4 class="business__title">사업자 정보</h4>
                        <label for="new-businessName" class="signup__label">
                            <i class="fa-solid fa-store"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-businessName"
                                name="businessName"
                                value="${ seller.businessName }"
                                placeholder="상호명을 입력해주세요."
                                disabled
                            />
                        </label>
                        <label for="new-businessNumber" class="signup__label">
                            <i class="fa-regular fa-address-card"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-businessNumber"
                                name="businessNum"
                                value="${ seller.businessNum }"
                                placeholder="사업자번호를 입력해주세요."
                                disabled title="입력 폼이 비활성화되었습니다."
                            />
                        </label>
                        
                        <label for="new-address" class="signup__label">
                            <i class="fa-solid fa-location-dot"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-address"
                                name="address"
                                value="${ seller.address }"
                                placeholder="주소를 입력해주세요."
                            />
                        </label>
                        <div class="filebox">
						    <input class="beanImg-name" value="대표이미지를 넣어주세요." placeholder="대표이미지를 넣어주세요.">
						    <label for="beanImgFile">파일찾기</label> 
						    <input type="file" class="fileInput" name="sellerImg" id="beanImgFile"/>
						</div>
                        <div class="signup__button-div">
                            <button class="signup__button" type="submit" name="action" value="sellerModifyChange">수정</button>
                            <button class="signup__button" type="submit" name="action" value="previousPage">취소</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>

<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>