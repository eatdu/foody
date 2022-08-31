<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="summaryArea" style="display: flex; align-items: center; justify-content: center;">
	<div class="thumbnail" style="background: url(/foody/upload/${recipe.thumbnail}); background-size: cover; "></div>
	<table class="rcpDetail" style="width: 75%; margin: 5px;">
		<tr>
			<th style="width: 6%;">요리명</th>
			<td style="width: 14%;">${recipe.name}</td>
			<th style="width: 6%;">인트로</th>
			<td colspan="7">${recipe.intro}</td>
			<th style="width: 6%;">작성자</th>
			<td style="width: 10%;">${user.nik_name}</td>
		</tr>
		<tr>
			<th>분류</th>
			<td>${recipeType}</td>
			<th>조리시간</th>
			<td style="width: 10%;">${recipe.time}</td>
			<th style="width: 6%;">조회수</th>
			<td style="width: 10%;"></td>
			<th style="width: 6%;">별점</th>
			<td style="width: 10%;"></td>
			<th style="width: 6%;">찜</th>
			<td style="width: 10%;"></td>
			<th>댓글수</th>
			<td></td>
		</tr>
	</table>
</div>
<div class="ingreArea">
<table class="rcpDetail">
	<tr>
		<th class="head" colspan="4">영양정보(${recipe.serving}인분 기준)</th>
	</tr>
	<tr>
		<th style="width: 25%;">열량</th>
		<th style="width: 25%;">탄수화물</th>
		<th style="width: 25%;">단백질</th>
		<th style="width: 25%;">지방</th>
	</tr>
	<tr>
		<td>${sumKcal} kcal</td>
		<td>${sumCarbo}g</td>
		<td>${sumProtein}g</td>
		<td>${sumFat}g</td>
	</tr>
</table>
<table class="rcpDetail">
	<tr>
		<th class="head" colspan="4">재료 상세</th>
	</tr>
	<tr>
		<th style="width: 35%;">재료</td>
		<th style="width: 15%;">중량</td>
		<th style="width: 35%;">재료</td>
		<th style="width: 15%;">중량</td>
	</tr>
	<tr>
		<c:forEach var="dataMap" items="${Ingredientlist}" varStatus="status">
		<td>
			${dataMap.name} <c:if test="${not empty dataMap.detail}">(${dataMap.detail})</c:if>
		</td>
		<td>
			<c:if test="${dataMap.weight eq 0}">
				${dataMap.quantity}
			</c:if>
			<c:if test="${dataMap.weight ne 0}">
				${dataMap.weight}g (${dataMap.quantity})
			</c:if>
		</td>
	<c:if test="${status.count % 2 eq 0}">
	</tr>
	<tr>
	</c:if>
		</c:forEach>
	</tr>
</table>
</div>
<div class="processArea">
<table class="rcpDetail">
	<tr>
		<th class="head" colspan="2">조리과정</th>
	</tr>
	<tr>
		<th style="width: 20%;">조리순서</th>
		<th>설명</th>
	</tr>
	<c:forEach var="dataMap" items="${processlist}" varStatus="status">
	<tr>
		<td>Step${dataMap.order_no}</td>
		<td>${dataMap.content}</td>
	</tr>
	</c:forEach>
</table>
</div>  
