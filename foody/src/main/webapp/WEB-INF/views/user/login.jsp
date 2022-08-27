<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<%@ include file="../common/config.jsp" %>
<style>
	.login_sub {
  	  	display: flex;
	  	justify-content: center;
	  	align-items:center;
	  	min-height: 60vh;
	}
	.login_box{
		text_align:relative; left: 200px;
	}
	.foody_h1 {
		font-size: 120px; margin-top: -85px; 
		margin-bottom: 10px; text-align: center; 
		margin:auto;
	}
	.login_ul {
		padding-left: 0px; width:400px;
	}
	.login_form{
		width: 360px;border:none;
	}
	.ul_li {
		list-style:none; margin: 20px;
	}
	.login_ul_li_input {
		position: relative;
		padding-left: 5px;
		line-height: 1.6;
		color: #666;
		text-indent: -3px;
		font-size: 32px;
		width: 330px;
		height: 50px;
	}
	.loginBtn {
		background-color: #121533; 
		color: white;
		font-size: 30px;
		width: 350px; height:50px;
		position: center;
	}
	.btn{
		text-decoration-line: none;
		text-decoration: none;
		color : black;
	}
	.btnSet .clear{
		margin: 0 auto;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
function loginCheck(){
	if($("#email").val() == ''){ // 이메일 입력체크란
		alert('이메일을 입력해주세요.')
		$("#email").focus();
		return false; 
	}		
	if($("#pwd").val() == ''){ // 비밀번호 입력체크란
		alert('비밀번호를 입력해주세요.')
		$("#pwd").focus();
		return false; 
	}		
}  
</script>
<body>
<%@ include file="../common/navBar.jsp" %>
	<form action="login.do" method="post" id="loginFrm1" name="loginFrm1" onsubmit="return loginCheck();">
	    <div class="login_sub">
	        <div class="size">
	            <div class="member">
	        	<h1 class="foody_h1" style="margin-bottom: 10px;">Foody</h1>
	                <div class="login_box">
	                    <fieldset class="login_form">
	                        <ul class="login_ul">
	                            <li class="ul_li"><input class="login_ul_li_input" type="text" id="email" name="email" placeholder="이메일"
	                            	style="height:50px;padding-left: 5px;text-indent: 3px;font-size: 25px;"></li>
	                            <li class="ul_li"><input class="login_ul_li_input" type="password" id="pwd" name="pwd" placeholder="비밀번호"
	                            	style="height:50px;padding-left: 5px;text-indent: 3px;font-size: 25px;"></li>
	                        </ul>
	                        <div class="login_btn"><input class="loginBtn" type="submit" value="로그인" alt="로그인" /></div>
	                    </fieldset>
	                    <div class="btnSet clear">
	                        <div>
	                            <a href="signUp.do" class="btn">회원가입</a> 
	                            <a href="findEmail.do" class="btn">이메일 찾기</a>
	                            <a href="findPwd.do" class="btn">비밀번호 찾기</a>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</form>
</body>
</html>