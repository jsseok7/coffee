<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>서비스 준비 중입니다.</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/mainStyle.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/signupStyle.css"> 
</head>
<body>
    <div class="popup">
    	<img class="servicePopupImg" src="${pageContext.request.contextPath }/images/service.jpg" alt="">
        <p>서비스 준비 중입니다.</p>
        <button id="closePopupButton">닫기</button>
    </div>
    <div class="sources">
		<a href="https://kr.freepik.com/free-vector/teamwork-of-tiny-people-with-gears-and-cogwheels-team-of-partners-working-on-upgrade-repair-improving-skills-and-client-service-flat-vector-illustration-business-organization-cooperation-concept_21683340.htm#query=%EC%A4%80%EB%B9%84%EC%A4%91&position=3&from_view=search&track=sph">작가 pch.vector</a> 출처 Freepik
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
