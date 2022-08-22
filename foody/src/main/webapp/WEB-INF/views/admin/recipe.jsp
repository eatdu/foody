<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../common/config.jsp" %>

<script>

</script>

<style>

</style>
<link rel="stylesheet" type="text/css" href="/foody/resources/css/leftMenu.css">
<title>레시피 목록</title>
</head>
<body>
<%@ include file="../admin/leftMenu.jsp" %>
<div class="adminContainer">
레시피 목록 조회
	<form>
	<table>
		<tr>
			<td>기간별</td>
			<td><input type="radio" name="date">1일</option></td>
			<td><input type="radio" name="date">1주</option></td>
			<td><input type="radio" name="date">1개월</option></td>
			<td><input type="radio" name="date">3개월</option></td>
			<td><input type="radio" name="date">6개월</option></td>
			<td><input type="radio" name="date">1년</option></td>
			<td><input type="radio" name="date" checked>전체기간</option></td>
		</tr>
		<tr>
			<td>확인여부</td>
			<td><input type="radio" name="adminChk">확인</option></td>
			<td><input type="radio" name="adminChk">미확인</option></td>
			<td><input type="radio" name="adminChk" checked>모두</option></td>
			<td>삭제여부</td>
			<td><input type="radio" name="print">삭제된 건만</option></td>
			<td><input type="radio" name="print">출력되는 건만</option></td>
			<td><input type="radio" name="print" checked>모두</option></td>
		</tr>
		<tr>
			<td>옵션별 검색</td>
			<td>
			<select>
				<option value="">제목</option>
				<option value="">닉네임</option>
			</select>
			<td>
			<td>
				<input type="text">
			</td>
		</tr>
	</table>
	</form>
</div>
</body>
</html>