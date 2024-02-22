<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<section id="mainBeanBest" class="section">
         <div class="max-container">
        <h1 class="mainBeanBest__title">Best</h1>
            <div class="mainBeanBest">
  				<c:forEach items="${bestBean}" var="beansDO" >
                    <div class="mainBeanBest__product">
                    	<img src="" alt="" class="beanBest__number">

        				<img src="${beansDO.beanImg}"  alt="" class="mainBeanBest__productImg" id="${ beansDO.beansNum}" >
                    	<form method="get" action="goListDetail">
                			<input type="hidden" id="beansNum" name="beansNum" value="${beansDO.beansNum}" />
                			<button>
                			</button>
                   		</form>
        				<div class="productList__productTitle">${beansDO.beanName }</div>
        				<div class="productList__productPrice">${beansDO.beanPrice}원</div>
        				<div class="likeButton">
                        	<button class="myPageLike__button"><i class="fa-solid fa-heart"></i></button>
                        	<p class="mainBeanBest__productLikeCount">${beansDO.likeCount}</p>
                    	</div>
                    </div>

    			</c:forEach>
            </div>
 	         <div class="mainBeanBest__button">
 	         	<h2 class="mainBeanBest__buttonTitle">더 많은 원두를 보려면?</h2>
 	         	<form method="get" action="goProductList">
 	         	    <button id="popupButton"  class="mainBeanBest__plusButton"><i class="fa-solid fa-angles-right"></i></button>	
 	         	</form>

            </div>
        </div>
    </section>