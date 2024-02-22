<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>잔액이 부족합니다.</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/mainStyle.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/signupStyle.css"> 
</head>
<body>
    <div class="popup">
    	<img class="popupImg" src="${pageContext.request.contextPath }/images/moneyPopup.png" alt="">
        <p>잔액이 부족합니다.</p>
        <button id="closePopupButton">닫기</button>
    </div>
    <div class="sources">
   		 출처 <a href="https://kr.freepik.com/free-vector/character-losing-money_9990002.htm#query=%EA%B8%88%EC%95%A1%20%EB%B6%80%EC%A1%B1&position=1&from_view=search&track=ais">Freepik</a>
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
