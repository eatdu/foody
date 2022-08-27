<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title></title>
<%@ include file="../common/config.jsp" %>
<style type="text/css">
    .img {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    overflow: hidden;
    }
    .jb-wrap {
        width: left;
        margin: 10px auto;
    }
    .jb-wrap img {
        width: 100%;
        vertical-align: middle;
    }
    .jb-text {
        padding: 5px 10px;
        background-color: yellow;
        text-align: center;
    }
</style>
<script>
	function goSave(){
		$("#frm").submit();
	}

</script>
</head>
<body>
<%@ include file="../common/navBar.jsp" %>
 	${signUp.no}
   	<h3>회원가입</h3>
	<form action="signUpNext.do" method="post" name="frm" id="frm" enctype="multipart/form-data">
 	<input type="hidden" name="no" value="${signUp.no}">
	    <div class="jb-wrap">
	    	<h5>프로필사진</h5>
		    <input type="hidden" name="selfi">
	        <div class="jb-image"><input type="file" id="chooseFile" name="chooseFile" class="img-input" style="diplay:none;"></div>
	        <div class="img" >
	    </div>
		</div>
		<div>
			<h5>한줄소개</h5>
			<input type="text" id="intro" name="intro" style="width:200px;height:100px;font-size:20px;">
		</div>
		<h5>칼로리계산기</h5>
		<table class="board_write">
	    <tbody>
	        <tr>
	            <th>키</th>
	            <td>
	               	<input type="text" name="height" id="height"> cm
	            </td>
	        </tr>
	        <tr>
	            <th>몸무게</th>
	            <td>
	                <input type="text" name="weight" id="weight"> kg
	            </td>
	        </tr>
	        <tr>
	            <th>활동지수</th>
	            <td>
	            
	            <select name="activity" style="height:22px;">
		        	<option value="30">앉아서 주로 생활하거나 활동량이 적은 경우</option>
		        	<option value="35">규칙적인 생활로 보통의 활동량을 가진 경우</option>
		        	<option value="40">육체노동 등 평소 신체 활동량이 많은 경우</option>
		        </select>
	            </td>
	        </tr>
        </tbody>
        </table>
        <div>
	        <h5>선호음식</h5>
	        <input type="hidden" name="prefer">
	    	<c:forEach var="rcpCate" items="${rcpCateArr}" varStatus="idx">
				<label><input type="checkbox" name="prefer_no" value="${idx.count}"/>${rcpCate}</label>
			</c:forEach>
        </div>
		<div>
			<h5>알레르기</h5>
			<input type="hidden" name="allergy">
			<c:forEach var="list" items="${allergy}" varStatus="idx">
				<label><input type="checkbox" name="allergy_no" value="${idx.count}"/>${list.allergy}</label>
			</c:forEach>
		</div>
	</form>
	<button type="button" id="goBackBtn" name="goBackBtn" onclick="history.back();">돌아가기</button>
	<button type="button" id="goNextBtn" name="goNextBtn" onclick="goSave();">가입하기</button>
<%@ include file="../common/profile.jsp" %>
</body>
</html>