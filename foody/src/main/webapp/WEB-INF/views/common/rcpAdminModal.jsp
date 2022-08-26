<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="summaryArea">
${recipe.no} / ${recipe.name} / ${recipeType} / ${recipe.time} <br>
작성자: ${user.nik_name} / 인트로: ${recipe.intro} <br>
조회수: / 별점: / 찜: / 댓글수:
</div>
<div class="ingreArea">
영양정보(${recipe.serving}인분 기준)<br>
열량: ${sumKcal}kcal  탄수화물: ${sumCarbo}g  단백질: ${sumProtein}g  지방: ${sumFat}g<br> 
재료<br>
	<c:forEach var="dataMap" items="${Ingredientlist}" varStatus="status">
		<div id ="ingredientListView">
			<c:if test="${dataMap.weight eq 0}">
				<c:out value="${dataMap.name} (${dataMap.quantity})"/>
			</c:if>
			<c:if test="${dataMap.weight ne 0}">
			<c:out value="${dataMap.name} ${dataMap.weight}g (${dataMap.quantity})"/>
			</c:if>
			<c:if test="${not empty dataMap.detail}">
					<c:out value="(참고:${dataMap.detail})"/>
			</c:if>
		</div>
	</c:forEach>
</div>
<div class="processArea">
조리과정<br>
	<c:forEach var="dataMap" items="${processlist}" varStatus="status">
		<p><c:out value="Step${dataMap.order_no}"/>
		<c:out value="${dataMap.content}"/></p>
	</c:forEach>
</div>  
<div class="endArea">
<button type="button">이 레시피 삭제하기</button>
</div>  
