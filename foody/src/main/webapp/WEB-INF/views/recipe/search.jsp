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
	var name = $('select[name="ingreNameList"]').val();
	$("#ingreArea").append("<div id='" + ingreIdx + "'>" + name + '<button type="button" name="removeBtn" onclick="javascript:removeIngre(' + ingreIdx + ');">X</button><input type="checkbox" class="hide" name="ingreName" value="' + name + '" checked="checked"></div>');
	ingreIdx++;
	ingreNameArr = makeArr('ingreName');
	console.log(ingreNameArr);
}

function removeIngre(idx){
	$("#"+idx).remove();
	ingreNameArr = makeArr('ingreName');
	console.log(ingreNameArr);
}

function search(){
	$.ajax({
		url: "/foody/search.do",
		method: "post",
		contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({
        	keywordArr: ingreNameArr,
        	ingreCateArr: ingreArr,
        	rcpCateArr: rcpArr
        	}),
		success: function(result){
			$("#rcpArea").empty().append(result);
		},
		error: function(e){
			console.log(e);
		}
	});
}
</script>

<style>
.hide {
	display: none
}
</style>

</head>
<body>
<form method="post" action="">
	<h1>검색조건</h1>
	<h3>음식분류</h3>
	<c:forEach var="rcpCate" items="${rcpCateArr}" varStatus="idx">
		<input type="checkbox" name="rcpCate" value=${idx.count}> ${rcpCate}
		<c:if test="${idx.count % 5 eq 0 }"><br></c:if>
	</c:forEach>
	<h3>재료분류</h3>
	<c:forEach var="ingreCate" items="${ingreCateArr}" varStatus="idx">
		<input type="checkbox" name="ingreCate" value=${idx.count}> ${ingreCate}
		<c:if test="${idx.count % 5 eq 0 }"><br></c:if>
	</c:forEach>
	<h3>재료추가</h3>
	<select name="ingreCateDrop" onchange="javascript:makeComboBox('ingreCateDrop', 'ingreNameList');">
	    <option value="0" selected>==분류==</option>
   		<c:forEach var="ingreCate" items="${ingreCateArr}" varStatus="idx">
		<option value=${idx.count}>${ingreCate}</option>
		</c:forEach>
	</select>
	<select name="ingreNameList">
	    <option value="" selected>==재료명==</option>
	</select>
	<button type="button" onclick="javascript:addIngre();">추가하기</button>
	<div id="ingreArea">
	</div>
	<h3>재료검색</h3>
	<button type="button" onclick="javascript:search();">검색</button>
</form>
<div id="rcpArea">
</div>
</body>
</html>