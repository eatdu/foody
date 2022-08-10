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
var rcpArr, ingreArr;
$(function(){
	$("input[type='checkbox']").change(function(){
		var name = $(this).attr("name");
		if (name === 'rcpCate') rcpArr = makeArr(name);
		else if (name === 'ingreCate') ingreArr = makeArr(name);
		console.log('rcpArr: ' + rcpArr);
		console.log('ingreArr: ' + ingreArr);
	});
});

</script>
</head>
<body>
<span>검색조건</span><br>
	<form method="post" action="">
	<span>음식분류</span><br>
	<c:forEach var="rcpCate" items="${rcpCateArr}" varStatus="idx">
		<input type="checkbox" name="rcpCate" value=${idx.count}> ${rcpCate}
		<c:if test="${idx.count % 5 eq 0 }"><br></c:if>
	</c:forEach><br>
	<span>재료분류</span><br>
	<c:forEach var="ingreCate" items="${ingreCateArr}" varStatus="idx">
		<input type="checkbox" name="ingreCate" value=${idx.count}> ${ingreCate}
		<c:if test="${idx.count % 5 eq 0 }"><br></c:if>
	</c:forEach>
	</form>
</body>
</html>