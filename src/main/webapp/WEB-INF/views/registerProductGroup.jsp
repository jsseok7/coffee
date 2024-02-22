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
    <script type="module" src="${pageContext.request.contextPath }/js/imgUpload.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/servicePopup.js" defer></script>
<%--     <script type="module" src="${pageContext.request.contextPath }/js/slideShow.js" defer></script> --%>
    
<%--     <script type="module" src="${pageContext.request.contextPath }/js/login.js" defer></script> --%>
    <%-- <script type="module" src="${pageContext.request.contextPath }/js/signup.js" defer></script> --%>
     <%--<script type="module" src="${pageContext.request.contextPath }/js/myPage.js" defer></script>
    <script type="module" src="${pageContext.request.contextPath }/js/main.js" defer></script> --%>
</head>
<body>
<%@ include file = "/WEB-INF/views/headerNav.jsp" %>

 <!-- registerProductGroup -->
   <section id="registerProductGroup" class="section">
        <div class="max-container">
            <div class="signup__buyerModify">
                <div class="signup__form-div">
                    <h2 class="signup__title">Bean2B 공동구매 상품 등록을 진행합니다.</h2> 
                    <h4 class="signup__description">맛있는 원두를 등록해주세요!</h4> 
                    <form id="product__form" action="Controller">
                        <label for="new-beanName" class="signup__label">
                            <img src="${pageContext.request.contextPath}/images/bean.png" alt="" class="bean__img signup__icon">
                            <input
                                class="signup__input"
                                type="text"
                                id="new-beanName"
                                name="beanName"
                                placeholder="상품 이름 입력"
                            />
                        </label> 
                        <label for="new-beanPrice" class="signup__label">
                            <i class="fa-solid fa-tags signup__icon"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-beanPrice"
                                name="beanPrice"
                                placeholder="원가 입력"
                            />
                        </label>
                        <label for="new-goalPrice" class="signup__label">
                            <img src="${pageContext.request.contextPath}/images/sale.png" alt="" class="bean__img signup__icon">
                            <input
                                class="signup__input"
                                type="text"
                                id="new-goalPrice"
                                name="goalPrice"
                                placeholder="공동구매 가격 입력"
                            />
                        </label>
                       
                        <label for="new-cName" class="signup__label">
                            <i class="fa-solid fa-flag-checkered signup__icon"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-cName"
                                name="cName"
                                placeholder="원산지 입력"
                            />
                        </label>

                        <label for="new-goalQty" class="signup__label">
                            <i class="fa-solid fa-medal signup__icon"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-goalQty"
                                name="goalQty"
                                placeholder="목표 수량"
                            />
                        </label>

                        <label for="new-deadline" class="signup__label">
                            <i class="fa-regular fa-clock signup__icon"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-deadline"
                                name="deadline"
                                placeholder="공동구매 기간"
                            />
                        </label>

                        <label for="new-deliveryCharge" class="signup__label">
                            <i class="fa-solid fa-truck-fast signup__icon"></i>
                            <input
                                class="signup__input"
                                type="text"
                                id="new-deliveryCharge"
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
                            <button class="signup__button" id="signup-button" name="action" value="signUppage" type="submit">취소</button>
                            <button class="signup__button" id="signup-button" name="action" value="signUppage" type="submit">등록</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
    <div class="sources">
        <a href="https://www.flaticon.com/kr/free-icons/" title="커피 아이콘">커피 아이콘  제작자: Freepik - Flaticon</a>
        <a href="https://www.flaticon.com/kr/free-icons/" title="판매용 아이콘">판매용 아이콘  제작자: th studio - Flaticon</a>
    </div>
<%@ include file = "/WEB-INF/views/footer.jsp" %>
</body>
</html>