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
	width: 80%;
	height: 80%;
	background-color: white;
	display: none;
}
#bbs {
	width: 90%;
	margin: auto;
	overflow: hidden;
}
#bbs table tbody tr:hover {
	background-color: #FFA7A7;
}
#recipeArea {
	height: 83%;
	max-height: 83%;
	max-height: 83%;
	overflow: scroll;
	overflow-x: hidden;
}
#form{
	height: 15%;
	margin-left: 5%;
}
td.head{
	background-color: white;
}
html{height: 100%;}
body{
	height: 100%;
	max-height: 100%;
	min-height: 100%;
}
</style>
<link rel="stylesheet" type="text/css" href="/foody/resources/css/leftMenu.css">
<title>레시피 목록</title>
</head>
<body>
<%@ include file="../admin/leftMenu.jsp" %>
<div class="adminContainer">
<h1 class="title">레시피 목록 조회</h1></h1>
	<form id="form" method="post" action="recipe.do">
	<table>
		<colgroup>
			<col width="12.5%"/>
			<col width="12.5%"/>
			<col width="12.5%"/>
			<col width="12.5%"/>
			<col width="12.5%"/>
			<col width="12.5%"/>
			<col width="12.5%"/>
			<col width="12.5%"/>
		</colgroup>
		<tr>
			<td class="head">기간별</td>
			<td><input type="radio" name="date" value='1 day'>1일</option></td>
			<td><input type="radio" name="date" value='1 week'>1주</option></td>
			<td><input type="radio" name="date" value='1 month'>1개월</option></td>
			<td><input type="radio" name="date" value='3 month'>3개월</option></td>
			<td><input type="radio" name="date" value='6 month'>6개월</option></td>
			<td><input type="radio" name="date" value='1 year'>1년</option></td>
			<td><input type="radio" name="date" value='all' checked>전체기간</option></td>
		</tr>
		<tr>
			<td class="head">확인여부</td>
			<td><input type="radio" name="adminChk" value='1'>확인</option></td>
			<td><input type="radio" name="adminChk" value='0'>미확인</option></td>
			<td><input type="radio" name="adminChk" value='0 or 1' checked>모두</option></td>
			<td class="head">삭제여부</td>
			<td><input type="radio" name="print" value='1'>삭제된 건만</option></td>
			<td><input type="radio" name="print" value='0'>출력되는 건만</option></td>
			<td><input type="radio" name="print" value='0 or 1' checked>모두</option></td>
		</tr>
		<tr>
			<td class="head">옵션별 검색</td>
			<td>
			<select name="type">
				<option value="title">제목</option>
				<option value="nikname">닉네임</option>
			</select>
			<td colspan="2">
				<input type="text" name="keyword">
			</td>
			<td>
				<input type="button" value="검색하기" onclick="searchRcp();">
			</td>
			<td></td>
			<td class="head">정렬조건</td>
			<td>
				<select name="orderBy">
					<option value="regdate desc">최신순</option>
					<option value="regdate">오래된순</option>
					<option value="nikname">작성자</option>
				</select>
			</td>
		</tr>
	</table>
	</form>
	<div id="recipeArea">
	</div>
</div>
<div id="modal">모달</div>
</body>
</html>