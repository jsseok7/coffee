<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Category -->
    <section id="mainCategory" class="section">
       <div class="max-container" >
       		<div class="controller" >
                        <button id="categoryPrevBtn"><span id="categoryPrev" >&lang;</span></button>
                        <button id="categoryNextBtn"><span id="categoryNext" >&rang;</span></button>
            </div>
        <h1 class="mainCategory__title">Category</h1>
            	<ul id="categoryList" class="mainCategory" >
					
                    <c:forEach items="${categoryList}" var="categoryDO" >
        			<li class="mainCategory__detail" id="${categoryDO.categoryNum}">
        				<img alt="" class="mainCategory__detailImg" src="${categoryDO.categoryImg}" />
        				<p class="mainCategory__detailTitle">${categoryDO.categoryName}</p>
        			</li>
        			</c:forEach>			
               </ul>
              		
              </div>   	
    </section>