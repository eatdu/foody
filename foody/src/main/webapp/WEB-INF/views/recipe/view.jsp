<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>레시피 뷰</title>
	</head>
		
	<body>
	레시피 번호: ${recipeDatas.no}<br><br><br>
	${recipeDatas.name}<br>
	${recipeDatas.intro}<br>
	소요시간 ${recipeDatas.time}분 이내<br>
	분류: ${typeName}<br><br><br>
	
	
	작성자: ${recipeDatas.user_no}<br>
	하하하하
	</body>
</html>




