<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../common/config.jsp" %>

<script>
var rcpArr = new Array();
var ingreArr = new Array();
var ingreNameArr = new Array();
var ingreIdx = 1;
$(function(){
	searchBtn(1);
	$("input[type='checkbox']").change(function(){
		var name = $(this).attr("name");
		if (name === 'rcpCate') rcpArr = makeArr(name);
		else if (name === 'ingreCate') ingreArr = makeArr(name);
	});
});

function addIngre(){
	if (checkName()){
		var name = $('select[name="ingreNameList"]').val();
		var html = '';
		html += "<span id='" + ingreIdx + "'>" + name
			+ '<button class="btn btn-danger" style="--bs-btn-line-height: .3rem;'
			+ ' --bs-btn-padding-x: .10rem; --bs-btn-font-size: .30rem;" type="button"'
			+ ' name="removeBtn" onclick="javascript:removeIngre(' + ingreIdx 
			+ ');">X</button><input type="checkbox" class="hide" name="ingreName" value="'
			+ name + '" checked="checked"></span>';
		$("#ingreArea").append(html);
		ingreIdx++;
		ingreNameArr = makeArr('ingreName');
	}
}

function removeIngre(idx){
	$("#"+idx).remove();
	ingreNameArr = makeArr('ingreName');
}


function checkName() {
	var value = $("select[name='ingreNameList']").val();
	if(value === '' || value === null){
		alert("재료를 선택해주세요.");	
		return false;
	}
	for(var i=0; i<ingreNameArr.length; i++){
		if (ingreNameArr[i] === value){
			alert("해당 재료는 이미 추가되었습니다.");	
			return false;
		}
	}
	return true;
}
</script>

<style>
.hide {
	display: none
}

.fixedCol {
    width: 113px;
    max-width: 113px;
    min-width: 113px;
    height: 30px;
}
.htd {
    width: 60px;
    max-width: 60px;
    min-width: 60px;
    height: 30px;
}
.search{
	margin-left:auto; 
    margin-right:auto;
}
.rcpCard {
	float: left;
	margin: 10px;
	width: 270px;
	height: 310px;
	border-radius: 30px;
	background-color: #FAF4C0;
}

.rcpTable {
	margin: auto;
	margin-top: 20px;
	width: 250px;
	height: 270px;
}
.rcpTable .imgCell {
	height: 150px;
}
.rcpTable .introCell{
	height: 40px;
}
.rcpTable .nameCell{
	width: 125px;
	height: 40px;
}
.rcpTable .timeCell{
	width: 125px;
	height: 40px;
}
.rcpArea {
	display: inline-block;
	width: 1160px;
}
.row {
	display: inline-block;
	width: 1160px;
}
.container{
	text-align: center;
}
.searchBox{
	width: 1600px;
	margin: auto;
    margin-top: 50px;
	height: 250px;
	border-radius: 70px;
	background-color: #FAF4C0;
}



</style>

<title>상세 검색</title>
</head>
<body>
 
<%@ include file="../common/navBar.jsp"  %>
<div class="container">
<form method="post" action="">
	<div class="searchBox">
	<table class="search">
		<tr>
		<td class='htd' rowspan='2'><h3>음식분류</h3></td>
		<c:forEach var="rcpCate" items="${rcpCateArr}" varStatus="idx">
			<td class='fixedCol'>
				<input style='zoom:0.8;' type="checkbox" name="rcpCate" value=${idx.count}>
				<label><span class=''>${rcpCate}</span></label>
			</td>
			<c:if test='${idx.count == 13}'>
			</tr><tr>
			</c:if>
		</c:forEach>
		</tr>
		<tr>
			<td class='htd' rowspan='2'><h3>재료분류</h3></td>
			<c:forEach var="ingreCate" items="${ingreCateArr}" varStatus="idx">
				<td class='fixedCol'>
					<input class="" style='zoom:0.8;' type="checkbox" name="ingreCate" value=${idx.count}>
					<label class=""><span class=''>${ingreCate}</span></label>
				</td>
				<c:if test='${idx.count == 13}'>
				</tr><tr>
				</c:if>
			</c:forEach>
		</tr>
		<tr>
			<td><h3>재료추가</h3></td>
			<td>분류로 검색</td>
			<td colspan='2'>
				<select id="ingreCateDrop" class='' name="ingreCateDrop" onchange="javascript:makeComboBox('ingreCateDrop', 'ingreNameList');">
				    <option value="0" selected>==분류==</option>
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
			<td class='htd' colspan='2'>
				<select class='' name="ingreNameList">
			    	<option value="" selected>==재료명==</option>
				</select>
			</td>
			<td>
				<button class="" type="button" onclick="javascript:addIngre();">추가</button>
			</td>
		<td>레시피 검색</td>
		<td>
			<button class="" type="button" onclick="javascript:searchBtn(1);">검색</button>
		</td>
		<c:if test="${!empty loginInfo}">
		<td>
			알러지 필터<input type="checkbox" id='allergyChk' checked>
		</td>
		</c:if>
		</tr>
		<td colspan='14' id="ingreArea">
		<td>
	</table>
	</div>
</form>
<div class="rcpArea" id="rcpArea1">
</div>
<div class="rcpArea" id="rcpArea2">
</div>
<div class="rcpArea" id="rcpArea3">
</div>
<div class="rcpArea" id="rcpArea4">
</div>
</div>
</body>
</html>