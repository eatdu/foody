<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../common/config.jsp" %>
<script type="text/javascript" src="/foody/resources/js/modal/jquery.plainmodal.min.js"></script>
<script>
function openModal(){
	$('#modal').plainModal('open');
}

</script>

<style>
#modal {
	width: 100px;
	height: 100px;
	background-color: blue;
	display: none;
}
</style>

<link rel="stylesheet" type="text/css" href="/foody/resources/css/leftMenu.css">
<title>레시피 목록</title>
</head>
<body>
<%@ include file="../admin/leftMenu.jsp" %>
<div class="adminContainer">
레시피 목록 조회
<div id="modal">모달</div>
<button type="button" onclick="javascript:openModal();">오픈</button>
	<form method="post" action="recipe.do">
	<table>
		<tr>
			<td>기간별</td>
			<td><input type="radio" name="date" value='1 day'>1일</option></td>
			<td><input type="radio" name="date" value='1 week'>1주</option></td>
			<td><input type="radio" name="date" value='1 month'>1개월</option></td>
			<td><input type="radio" name="date" value='3 month'>3개월</option></td>
			<td><input type="radio" name="date" value='6 month'>6개월</option></td>
			<td><input type="radio" name="date" value='1 year'>1년</option></td>
			<td><input type="radio" name="date" value='all' checked>전체기간</option></td>
		</tr>
		<tr>
			<td>확인여부</td>
			<td><input type="radio" name="adminChk" value='1'>확인</option></td>
			<td><input type="radio" name="adminChk" value='0'>미확인</option></td>
			<td><input type="radio" name="adminChk" value='0 or 1' checked>모두</option></td>
			<td>삭제여부</td>
			<td><input type="radio" name="print" value='1'>삭제된 건만</option></td>
			<td><input type="radio" name="print" value='0'>출력되는 건만</option></td>
			<td><input type="radio" name="print" value='0 or 1' checked>모두</option></td>
		</tr>
		<tr>
			<td>옵션별 검색</td>
			<td>
			<select name="type">
				<option value="title">제목</option>
				<option value="nikname">닉네임</option>
			</select>
			<td>
			<td>
				<input type="text" name="keyword">
			</td>
			<td>
				<input type="submit" value="검색하기">
			</td>
			<td>
			정렬조건: 
				<select name="orderBy">
					<option value="regdate">등록일</option>
					<option value="nikname">작성자</option>
				</select>
			</td>
		</tr>
	</table>
	</form>
	<div id="recipeArea">
		<table>
			<thead>
				<th>
			</thead>
		</table>
	${result}
	</div>
</div>
</body>
</html>