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
    <script type="module" src="${pageContext.request.contextPath }/js/lmgUpload.js" defer></script>
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
        <div class="max-container">"
            <div class="signup__buyerModify">
                <div class="signup__form-div">
                    <h2 class="signup__title">Bean2B 일반 상품 등록을 진행합니다.</h2>
                    <h4 class="signup__description">맛있는 원두를 등록해주세요!</h4>
                    <form id="product__form" enctype="multipart/form-data" method="post" action="registerProd">
                        <label for="beanName" class="signup__label">
                            <img src="${pageContext.request.contextPath}/images/bean.png" alt="" class="bean__img signup__icon">
                            <input
                                class="signup__input"
                                type="text"
                                id="beanName"
                                name="beanName"
                                placeholder="상품 이름 입력"
                            />
                        </label>
                        <label for="beanPrice" class="signup__label">
                            <i class="fa-solid fa-tags signup__icon"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="beanPrice"
                                name="beanPrice"
                                placeholder="상품 가격 입력"
                            />
                        </label>
                        <label for="cName" class="signup__label">
                            <i class="fa-solid fa-flag-checkered signup__icon"></i>
                            <select class="signup__input" name="categoryNum">
                            	<option value="0">원산지를 선택해주세요.</option>
                            	<option value="1">대한민국</option>
                            	<option value="2">벨기에</option>
                            	<option value="3">덴마크</option>
                            	<option value="4">프랑스</option>
                            	<option value="5">인도</option>
                            	<option value="6">인도네시아</option>
                            	<option value="7">스페인</option>
                            	<option value="8">핀란드</option>
                            	<option value="9">노르웨이</option>
                            	<option value="10">체코</option>
                            	
                            </select>
                        </label>
                        <label for="deliveryCharge" class="signup__label">
                            <i class="fa-solid fa-truck-fast signup__icon"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="deliveryCharge"
                                name="deliveryCharge"
                                placeholder="배송료 입력"
                            />
                        </label>
                        <div class="filebox">
						    <input class="beanImg-name" value="대표이미지를 넣어주세요." placeholder="대표이미지를 넣어주세요.">
						    <label for="beanImgFile">파일찾기</label> 
						    <input type="file" class="fileInput" name="beanImg" id="beanImgFile"/>
						</div>
						
						<div class="filebox">
						    <input class="descript-name" value="상세설명 이미지를 넣어주세요." placeholder="상세설명 이미지를 넣어주세요.">
						    <label for="descriptFile">파일찾기</label> 
						    <input type="file" class="fileInput" name="descript" id="descriptFile"/>
						</div>

                        <div class="signup__button-div">
                            <button class="signup__button" id="signup-button" name="action" value="cancel" type="submit">취소</button>
                            <button class="signup__button" id="signup-button" name="action" value="register" type="submit">등록</button>
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