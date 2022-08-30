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
<script>
	function goSave(){
		$("#frm").submit();
	}
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
		    reader.onload = function(e) {
				document.getElementById('preview').src = e.target.result;
		};
			reader.readAsDataURL(input.files[0]);
		} else {
			document.getElementById('preview').src = "";
		}
	}
</script>
<%@ include file="../common/config.jsp" %>
<style type="text/css">
    .img {
	    width: 150px;
	    height: 150px;
	    border-radius: 50%;
	    overflow: hidden;
    }
    .jb-wrap img {
        width: 100%;
        vertical-align: middle;
    }
    .jb-text {
        padding: 5px 10px;
        background-color: yellow;
    }
    .signUpNext_title{font-size: 60px;margin-top: -15px;}
    .signUpNext_sub_title_profile{
    	font-size: 20px;
    	margin-top:-20px;
    }
    #preview{
   		height: 150px;
	    width: 150px;
	    border-radius: 50%;
	    diplay:none;
	}
    .signUpNext_sub_title{font-size: 30px;}
    .signUpNext_th{font-size: 30px;} 
    #frm{margin-left:6px;margin-top:4px;} 
    #intro{font-size: 15px;width:350px;height:100px;border-radius:7px;text-indent:3px;}
    #height,#weight{border-radius:5px;} 
    #activity{
	    border-radius:3px;
	    height: 37px;
   		font-size: 17px;
	}
    input[type="checkbox"]{
    	zoom: 1.5;
    	font-size:35px;
    }
    .btnSet_clear{float:right;margin-right: 98px;margin-top:5px;margin-right:235px;}  
    .submitBtn button{
		width: 150px;height: 45px;
		background-color:white;
		border-color:#6A6D6F;
		border-radius:5px;
		font-size:20px;
		color:#6A6D6F;
		font-weight: bolder;
		border-width: thin;
	}
	.submitBtn button:hover{
		color:white;
		background-color:#6A6D6F;
	}
	.preferCon,.allergyCon{margin-top: -7px;}
	#weight,#height,#activity{margin-left: 5px;}
	label{font-size:18px;}
</style>
</head>
<body>
<%@ include file="../common/navBar.jsp" %>
   	<h3 class="signUpNext_title">프로필등록</h3>
	<form action="signUpNext.do" method="post" name="frm" id="frm" enctype="multipart/form-data">
 	<input type="hidden" name="no" value="${signUp.no}">
	    <div class="jb-wrap">
	    	<h5 class="signUpNext_sub_title_profile">프로필사진</h5>
		    <input type="hidden" name="selfi">
	        <input type="file" id="chooseFile" name="chooseFile" onchange="readURL(this);"> 
			<img id="preview" />
	    </div>
		<div>
			<h5 class="signUpNext_sub_title">한줄소개</h5>
			<textarea name="intro" id="intro" ></textarea>
		</div>
		<h5 class="signUpNext_sub_title">칼로리계산기</h5>
		<table class="board_write">
	    <tbody>
	        <tr>
	            <th class="signUpNext_th">키</th>
	            <td>
	               	<input type="text" name="height" id="height" style="height:35px;font-size: 18px;text-indent: 3px;"> cm
	            </td>
	        </tr>
	        <tr>
	            <th class="signUpNext_th">몸무게</th>
	            <td>
	                <input type="text" name="weight" id="weight" style="height:35px;font-size: 18px;text-indent: 3px;"> kg
	            </td>
	        </tr>
	        <tr>
	            <th class="signUpNext_th">활동지수</th>
	            <td>
		            <select name="activity" id="activity">
			        	<option value="30">앉아서 주로 생활하거나 활동량이 적은 경우</option>
			        	<option value="35">규칙적인 생활로 보통의 활동량을 가진 경우</option>
			        	<option value="40">육체노동 등 평소 신체 활동량이 많은 경우</option>
			        </select>
	            </td>
	        </tr>
        </tbody>
        </table>
        <div>
	        <h5 class="signUpNext_sub_title">선호음식</h5>
	    	<c:forEach var="rcpCate" items="${rcpCateArr}" varStatus="idx">
				<label><input type="checkbox" name="prefer_no" value="${idx.count}"/>${rcpCate}</label>
			</c:forEach>
        </div>
		<div>
			<h5 class="signUpNext_sub_title">알레르기</h5>
			<c:forEach var="list" items="${allergy}" varStatus="idx">
				<label><input type="checkbox" name="allergy_no" value="${idx.count}"/>${list.allergy}</label>
			</c:forEach>
		</div>
	</form>
	<div class="btnSet_clear">  
		<div class="submitBtn">
			<button type="button" id="goBackBtn" name="goBackBtn" onclick="history.back();">프로필등록취소</button>
			<button type="button" id="goNextBtn" name="goNextBtn" onclick="goSave();">프로필등록완료</button>
		</div>
	</div>
</body>
</html>