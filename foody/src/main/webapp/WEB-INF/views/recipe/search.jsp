<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 등록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="./resources/js/util.js"></script>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
<script>
var rcpArr = new Array();
var ingreArr = new Array();
var ingreNameArr = new Array();
var ingreIdx = 1;
$(function(){
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
			+ name + '" checked="checked"></span>' 
		$("#ingreArea").append(html);
		ingreIdx++;
		ingreNameArr = makeArr('ingreName');
		console.log(ingreNameArr);
	}
}

function removeIngre(idx){
	$("#"+idx).remove();
	ingreNameArr = makeArr('ingreName');
	console.log(ingreNameArr);
}

function search(pageNo){
	$.ajax({
		url: "/foody/search.do",
		method: "post",
		contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({
        	keywordArr: ingreNameArr,
        	ingreCateArr: ingreArr,
        	rcpCateArr: rcpArr,
        	startNo: (pageNo - 1) * 12 + 1,
        	endNo: pageNo * 12
        	}),
		success: function(result){
			$("#rcpArea").empty().append(result);
		},
		error: function(e){
			console.log(e);
		}
	});
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

.checklist {
	font-size: 15px
}

</style>

</head>
<body>
<%@ include file="../common/navBar.jsp" %>
<form method="post" action="">
	<h1 class="text-center">검색조건</h1>
	<div class="container">
		<div><h3>음식분류</h3></div>
		<c:forEach var="rcpCate" items="${rcpCateArr}" varStatus="idx">
		<div class="form-check form-check-inline">
			<input class="form-check-input" style='zoom:0.8;' type="checkbox" name="rcpCate" value=${idx.count}>
			<label class="form-check-label" for="flexCheckDefault"><span class='checklist'>${rcpCate}</span></label>
		</div>
		</c:forEach>
		<h3>재료분류</h3>
		<c:forEach var="ingreCate" items="${ingreCateArr}" varStatus="idx">
		<div class="form-check form-check-inline">
			<input class="form-check-input" style='zoom:0.8;' type="checkbox" name="rcpCate" value=${idx.count}>
			<label class="form-check-label" for="flexCheckDefault"><span class='checklist'>${ingreCate}</span></label>
		</div>
		</c:forEach>
		<h3>재료추가</h3>
		<div class='row justify-content-start'>
			<div class="col-1">분류로 검색</div>
			<div class="col-2">
			<select id="ingreCateDrop" class='form-select' name="ingreCateDrop" onchange="javascript:makeComboBox('ingreCateDrop', 'ingreNameList');">
			    <option value="0" selected>==분류==</option>
		   		<c:forEach var="ingreCate" items="${ingreCateArr}" varStatus="idx">
				<option value=${idx.count}>${ingreCate}</option>
				</c:forEach>
			</select>
			</div>
			<div class="col-1"> 검색어 </div>
			<div class="col-2">
				<input type="text" id="keyword" class="form-control form-control-sm input-lg rounded-pill" placeholder="검색어 입력">
			</div>
			<div class="col-1">
				<button class="btn btn-primary" type="button" onclick="javascript:makeComboBox('keyword', 'ingreNameList');">검색</button>
			</div>
			<div class="col-2">
			<select class='form-select' name="ingreNameList">
			    <option value="" selected>==재료명==</option>
			</select>
			</div>
			<div class="col-1">
			<button class="btn btn-primary" type="button" onclick="javascript:addIngre();">추가</button>
			</div>
		</div>
		<div id="ingreArea">
		</div>
		<h3>레시피 검색</h3>
		<button class="btn btn-primary" type="button" onclick="javascript:search(1);">검색</button>
	</div>
</form>
<div class="container text-center" id="rcpArea">
</div>
</body>
</html>