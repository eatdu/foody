<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	.kcalBtn{ position:absolute; top: 20%; left:50%;
	  width:120px; height:30px; margin-top:-15px; margin-left:-60px;
	  line-height:15px; cursor:pointer;
	}
	
	.modal{ 
	  position:absolute; width:100%; height:100%; background: rgba(0,0,0,0.8); top:0; left:0; display:none;
	}
	
	.modal_content{
	  width:400px; height:200px;
	  background:#fff; border-radius:10px;
	  position:relative; top:35%; left:50%;
	  margin-top:-150px; margin-left:-200px;
	  text-align:center;
	  box-sizing:border-box; padding:30px 0;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
function goSave(){
	if($("#height").val().trim() == ''){ // 키공란 체크
		alert('키를 입력해 주세요.');
		$("#height").focus();
		return;
	}
}


$(function(){ 
	$("button").click(function(){
		$(".modal").fadeIn();
	});
	$("#goBackBtn").click(function(){
		$(".modal").fadeOut();
  	});
	$("#goSign").click(function(){
		    if(confirm("정말 등록하시겠습니까 ?") == true){
			        alert("등록되었습니다");
			}
			return;    
		});
});
</script>
<title>Insert title here</title>
</head>
<body>
<button id="kcalBtn" name="kcalBtn">칼로리계산기</button>
<form action="signUpNext.do" method="post" name="frm" id="frm">
	<div class="modal">
	<div class="modal_content">
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
	                <input type="text" id="weight" name="weight"> kg
	            </td>
	        </tr>
	        <tr>
	            <th>활동지수</th>
	            <td>
	            
	            <select name="activity" style="height:22px;">
		        	<option value="1">앉아서 주로 생활하거나 활동량이 적은 경우,25</option>
		        	<option value="2">규칙적인 생활로 보통의 활동량을 가진 경우,35</option>
		        	<option value="3">육체노동 등 평소 신체 활동량이 많은 경우,45</option>
		        </select>
	            </td>
	        </tr>
        </tbody>
        </table>
        <input type="button" id="goBackBtn" name="goBackBtn" value="취소"></input>
        <input type="button" id="goSave" name="goSave" value="저장"></input>
	</div>
	</div>
	</form>
	<button type="button" id="goSign" name="goSign" onclick="goSign();">가입하기</button>
	
</body>
</html>