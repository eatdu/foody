<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
<meta name="format-detection" content="telephone=no, address=no, email=no">
<meta name="keywords" content="">
<meta name="description" content="">
<title>비밀번호 찾기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>
	function findPwd(){
		if($("#email").val() == ''){
			alert('이메일 입력해주세요.')
			$("#email").focus();
			return false; 
		}		
		if($("#name").val() == ''){
			alert('이름을 입력해주세요.')
			$("#name").focus();
			return false; 
		}		
		if($("#hp").val() == ''){
			alert('전화번호를 입력해주세요.')
			$("#tel").focus();
			return false; 
		}		
		$.ajax({
			url : 'findPwd.do',
			method : 'post',
			data : {
				email : $("#email").val(),
				name : $("#name").val(),
				tel : $("#tel").val()
			},
			success : function(res){
				if(res.trim() == ''){
					alert('해당 회원이 존재하지 않습니다.');
				} else {
					alert('임시비밀번호가 이메일로 발송되었습니다.');
					$("#name, #tel, #email").val('');
				}
			}
		})
		return false; 
	}    
</script>
</head>
<body>
	<form action="login.do" method="post" id="loginFrm1" name="loginFrm1" onsubmit="return findPwd();">
	    <div class="sub">
	        <div class="size">
	            <h3 class="sub_title">비밀번호 찾기</h3>
	            <div class="member">
	                <div class="box">
	                    <fieldset class="login_form">
	                        <ul>
	                            <li><input type="text" id="email" name="email" placeholder="이메일"></li>
	                            <li><input type="text" id="name" name="name" placeholder="이름"></li>
	                            <li><input type="text" id="tel" name="tel" placeholder="전화번호"></li>
	                            <li id="msg"></li>
	                        </ul>
	                        <div class="login_btn"><input type="submit" value="비밀번호 찾기" alt="비밀번호 찾기" /></div>
	                    </fieldset>
	                    <div class="btnSet clear">
	                        <div>
	                            <a href="signUp.do" class="btn">회원가입</a> 
	                            <a href="findEmail.do" class="btn">이메일 찾기</a>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</form>
</body>
</html>