<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
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
<style type="text/css">
   .findPwd_sub {
	 	display: flex;
	  	justify-content: center;
	  	align-items:center;
	  	min-height: 60vh;
	}
	.findPwd_box {
		text_align:relative; left: 200px;
	}
	.findPwd_sub_title {
		font-size: 60px; margin-top:240px; 
		margin-bottom: -20px; text-align: center; 
		margin-right: -2px;
	}
	.pwd_ul {
		padding-left: 0px; width:400px;
	}
	.pwd_form{
		width: 360px;border:none;
	}
	.ul_li {
		list-style:none; margin: 20px;
	}
	.pwd_ul_li_input {
		position: relative;
		padding-left: 5px;
		line-height: 1.6;
		color: #666;
		text-indent: -3px;
		font-size: 32px;
		width: 330px;
		height: 50px;
		margin-right:45px;
	}
	.pwdBtn {
		background-color: #121533;
	    color: white;
	    font-size: 30px;
	    width: 342px;
	    height: 50px;
	    position: center;
	    border: 0;
	    margin-left: 59px;
	}
	.btn{
		text-decoration-line: none;
		text-decoration: none;
		color : black;
	}
	.btnSet_clear{
		margin-top: -5px;
		margin-left: 170px;
	}
</style>
</head>
<body>
<form action="login.do" method="post" id="loginFrm1" name="loginFrm1" onsubmit="return findPwd();">
    <div class="findPwd_sub">
        <div class="size">
            <h3 class="findPwd_sub_title">비밀번호 찾기</h3>
            <div class="member">
                <div class="findPwd_box">
                    <fieldset class="pwd_form">
                        <ul>
                            <li class="ul_li"><input class="pwd_ul_li_input" type="text" id="email" name="email" placeholder="이메일"></li>
                            <li class="ul_li"><input class="pwd_ul_li_input" type="text" id="name" name="name" placeholder="이름"></li>
                            <li class="ul_li"><input class="pwd_ul_li_input" type="text" id="tel" name="tel" placeholder="전화번호"></li>
                            <li class="ul_li"  id="msg"></li>
                        </ul>
                        <div class="login_btn"><input class="pwdBtn" type="submit" value="비밀번호 찾기" alt="비밀번호 찾기" /></div>
                    </fieldset>
                    <div class="btnSet_clear">
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