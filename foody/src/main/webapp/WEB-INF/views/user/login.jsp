<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
	<form action="login.do" method="post" id="loginFrm1" name="loginFrm1" onsubmit="return loginCheck();">
	    <div class="sub">
	        <div class="size">
	            <h3 class="sub_title">로그인</h3>
	            <div class="member">
	                <div class="box">
	                    <fieldset class="login_form">
	                        <ul>
	                            <li><input type="text" id="email" name="email" placeholder="이메일"></li>
	                            <li><input type="password" id="pwd" name="pwd" placeholder="비밀번호"></li>
	                            <li><label><input type="checkbox" name="reg1" id="reg1"/> 아이디저장</label></li>
	                        </ul>
	                        <div class="login_btn"><input type="submit" value="로그인" alt="로그인" /></div>
	                    </fieldset>
	                    <div class="btnSet clear">
	                        <div>
	                            <a href="signUp.do" class="btn">회원가입</a> 
	                            <a href="findEmail.do" class="btn">이메일 찾기</a>
	                            <a href="findPwd.do" class="btn">비밀번호 찾기</a>
	                            ${loginInfo.email}
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</form>
</body>
</html>