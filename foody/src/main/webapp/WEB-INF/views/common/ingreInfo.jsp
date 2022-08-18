<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table>
	<tr>
		<td>고유번호</td>
		<td>이름</td>
		<td>상세</td>
		<td>분류</td>
		<td>탄수화물</td>
		<td>단백질</td>
		<td>지방</td>
		<td>알러지</td>
		<td>출력여부</td>
	</tr>
	<tr>
		<td>${result.no}</td>
		<td><input type="text" disabled value='${result.name}'></td>
		<td><input type="text" disabled value='${result.detail}'></td>
		<td id="cateName">
			<select id="ingreCateDrop2" class='' name="ingreCateDrop" disabled onchange="javascript:makeComboBox('ingreCateDrop', 'ingreNameList');">
			    <option value="0">==분류==</option>
		   		<c:forEach var="ingreCate" items="${ingreCateArr}" varStatus="idx">
				<option value=${idx.count}
				<c:if test="${idx.count eq selected}">
				selected
				</c:if>
				>${ingreCate}</option>
				</c:forEach>
			</select>
		</td>
		<td><input type="number" step="0.01" max='100' min='0' disabled value='${result.carbo}'></td>
		<td><input type="number" step="0.01" max='100' min='0' disabled value='${result.protein}'></td>
		<td><input type="number" step="0.01" max='100' min='0' disabled value='${result.fat}'></td>
		<td id="allergyName">
			<select id="allergyDrop" class='' name="ingreCateDrop" disabled onchange="javascript:makeComboBox('ingreCateDrop', 'ingreNameList');">
			    <option value="0">없음</option>
		   		<c:forEach var="allergy" items="${allergyArr}" varStatus="idx">
				<option value=${idx.count}
				<c:if test="${idx.count eq allergyNo}">
				selected
				</c:if>
				>${allergy}</option>
				</c:forEach>
			</select></td>
		<td>
			<c:if test="${result.print eq 0}">O</c:if>
			<c:if test="${result.print eq 1}">X</c:if>
		</td>
	</tr>
</table>
<button id="editBtn" type="button">수정하기</button>
<button id="deleteBtn" type="button">삭제하기</button>

<script>
	$(function(){
		$("#editBtn").on("click", function(){
			$(this).html("전송하기");
			$(this).attr("id", "submitBtn");
			$(this).attr("onclick", "javascript:updateIngre();");
		});
	});
	
	
	
</script>