<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매자 이용 불가</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/mainStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/signupStyle.css">  
</head>
<body>
    <div class="popup">
    	<img class="popupImg" src="${pageContext.request.contextPath }/images/sellerPopup.png" alt="">
        <p>판매자는 이용할 수 없습니다.</p>
        <button id="closePopupButton">닫기</button>
    </div>
    <div class="sources">
       <a href="https://kr.freepik.com/free-vector/teacher-woman-holding-stop-sign-and-point-to-wrong-sign-stop-talking-during-class_19567922.htm#query=stop&from_query=%EB%A9%88%EC%B6%B0&position=9&from_view=search&track=sph">작가 jcomp</a> 출처 Freepik
    </div>

    <script>
        document.getElementById('closePopupButton').addEventListener('click', function () {
            var popup = document.querySelector('.popup');
            popup.classList.remove('active');
        });
        document.getElementById('closePopupButton').addEventListener('click', function () {
            window.close();
        });

    </script>
</body>
</html>
