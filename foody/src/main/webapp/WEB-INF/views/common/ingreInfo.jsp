<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table>
	<tr class="row1">
		<td style="width: 7%;">고유번호</td>
		<td style="width: 18%;">이름</td>
		<td style="width: 18%;">상세</td>
		<td style="width: 18%;">분류</td>
		<td style="width: 8%;">탄수화물</td>
		<td style="width: 8%;">단백질</td>
		<td style="width: 8%;">지방</td>
		<td style="width: 8%;">알러지</td>
		<td style="width: 7%;">출력여부</td>
	</tr>
	<tr class="row2">
		<td>
			${result.no}
			<input type="hidden" name="no" value=${result.no}>
		</td>
		<td><input class='ingreInfoForm' type="text" name="name" disabled value='${result.name}'></td>
		<td><input class='ingreInfoForm' type="text" name="detail" disabled value='${result.detail}'></td>
		<td id="cateName">
			<select id="ingreCateDrop2" class='ingreInfoForm' name="large_cate" disabled>
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
		<td><input class='ingreInfoForm' type="number" name="carbo" step="0.01" max='100' min='0' disabled value='${result.carbo}'></td>
		<td><input class='ingreInfoForm' type="number" name="protein" step="0.01" max='100' min='0' disabled value='${result.protein}'></td>
		<td><input class='ingreInfoForm' type="number" name="fat" step="0.01" max='100' min='0' disabled value='${result.fat}'></td>
		<td id="allergyName">
			<select id="allergyDrop" class='ingreInfoForm' name="allergy_no" disabled>
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
			<input class='ingreInfoForm' type="checkbox" name="print" disabled 
			<c:if test="${result.print eq 0}">checked</c:if>
			>
		</td>
	</tr>
</table>
<button class="btn1" id="editBtn" type="button">수정하기</button>

<script>
	$(function(){
		$("#editBtn").on("click", function(){
			$(this).html("전송하기");
			$(this).attr("id", "submitBtn");
			$(this).attr("onclick", "javascript:updateIngre();");
			$(".ingreInfoForm").attr("disabled", false);
		});
	});
	
	
	
</script>