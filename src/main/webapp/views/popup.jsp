<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 해주세요.</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/mainStyle.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/signupStyle.css"> 
</head>
<body>
    <div class="popup">
    	<img class="popupImg" src="${pageContext.request.contextPath }/images/popupSignup.png" alt="">
        <p>로그인 후 이용가능합니다.</p>
        <button id="closePopupButton">닫기</button>
    </div>
    <div class="sources">
        출처 <a href="https://kr.freepik.com/free-vector/online-registration-concept-with-flat-design_3301524.htm#query=%EB%93%B1%EB%A1%9D&position=29&from_view=search&track=sph#position=29&query=%EB%93%B1%EB%A1%9D">Freepik</a>
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
