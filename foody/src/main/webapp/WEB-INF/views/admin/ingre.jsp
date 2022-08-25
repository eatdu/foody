<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../common/config.jsp" %>

<script>
//영양정보 상세 검색하는 함수
function makeIngreInfo(){
	var data = {};
	data.no = $("#ingreDetailList").val();
	if ($("#ingreDetailList").val() == '') return;
	sendAjax(
			"/foody/admin/ingreInfo.do",
			data,
			function(result){
				$("#ingreInfoArea").empty().append(result);
			}
		);
}

</script>
<style>
table, td {
	border: solid 1px black;
}
table, td {
	padding: 3px;
}
</style>
<link rel="stylesheet" type="text/css" href="/foody/resources/css/leftMenu.css">
<title>재료DB 조작 페이지</title>
</head>
<body>
<%@ include file="../admin/leftMenu.jsp" %>
<div class="adminContainer">
<div class="title"><h1>재료 조작 페이지</h1></div>
	<table>
		<tr>
			<td>분류로 검색</td>
			<td colspan='2'>
				<select id="ingreCateDrop" class='' name="ingreCateDrop" onchange="javascript:makeComboBox('ingreCateDrop', 'ingreNameList');">
				    <option value="0">==분류==</option>
		   		<c:forEach var="ingreCate" items="${ingreCateArr}" varStatus="idx">
					<option value=${idx.count}>${ingreCate}</option>
				</c:forEach>
				</select>
			</td>
			<td> 검색어 </td>
			<td colspan='2'>
				<input type="text" id="keyword" class="" placeholder="검색어 입력">
			</td>
			<td>
				<button class="" type="button" onclick="javascript:makeComboBox('keyword', 'ingreNameList');">검색</button>
			</td>
			<td>재료명</td>
			<td colspan='2'>
				<select id="ingreNameList" class='' name="ingreNameList" onchange="javascript:makeComboBox('ingreNameList', 'ingreDetailList');">
			    	<option value="">==재료명==</option>
				</select>
			</td>
			<td>재료상세</td>
			<td colspan='2'>
				<select id="ingreDetailList" class='' name="ingreDetailList">
			    	<option value="">==상세==</option>
				</select>
			</td>
			<td>
				<button class="" type="button" onclick="javascript:makeIngreInfo()">조회</button>
			</td>
	</table>
	<h1>재료 정보 조회</h1>
	<div id="ingreInfoArea">
	조회할 재료를 선택해주세요.
	</div>
	<h1>재료 정보 추가</h1>
	<div id="ingreAddArea">
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
				<td>
					자동입력
				</td>
				<td><input class='ingreInfoForm' type="text" name="name" value=''></td>
				<td><input class='ingreInfoForm' type="text" name="detail" value=''></td>
				<td id="cateName">
					<select id="ingreCateDrop2" class='ingreInfoForm' name="large_cate">
					    <option value="0">==분류==</option>
			   		<c:forEach var="ingreCate" items="${ingreCateArr}" varStatus="idx">
						<option value=${idx.count}>${ingreCate}</option>
					</c:forEach>
					</select>
				</td>
				<td><input class='ingreInfoForm' type="number" name="carbo" step="0.01" max='100' min='0' value='0'></td>
				<td><input class='ingreInfoForm' type="number" name="protein" step="0.01" max='100' min='0' value='0'></td>
				<td><input class='ingreInfoForm' type="number" name="fat" step="0.01" max='100' min='0' value='0'></td>
				<td id="allergyName">
					<select id="allergyDrop" class='ingreInfoForm' name="allergy_no">
					    <option value="0">없음</option>
   			   		<c:forEach var="allergy" items="${allergyList}" varStatus="idx">
						<option value=${idx.count}>${allergy}</option>
					</c:forEach>
					</select>
				</td>
				<td>
					<input class='ingreInfoForm' type="checkbox" name="print">
				</td>
			</tr>
		</table>
		<button id="editBtn" type="button" onclick="javascript:addIngre();">추가하기</button>
	</div>
</div>
</body>
</html>