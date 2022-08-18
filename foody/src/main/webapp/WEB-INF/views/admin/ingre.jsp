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
	data.selected = $("#ingreCateDrop").val();
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
<title>재료DB 조작 페이지</title>
</head>
<body>
재료 조작 페이지
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
	<div id="ingreInfoArea">
	</div>
	<div id="ingreAddArea">
	</div>
</body>
</html>