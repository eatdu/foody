<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	function findEmail(){
		if($("#name").val() == ''){
			alert('이름을 입력해주세요.')
			$("#name").focus();
			return false; // 리턴값이 false여야 전송이 안됨
		}		
		if($("#tel").val() == ''){
			alert('전화번호를 입력해주세요.')
			$("#tel").focus();
			return false; // 리턴값이 false여야 전송이 안됨
		}		
		// ajax 조회
		$.ajax({
			url : 'findEmail.do',
			method : 'post',
			data : {
				name : $("#name").val(),
				tel : $("#tel").val()
			},
			success : function(res){
				if(res.trim() == '${userVO.email}'){
					$("#msg").html('입력하신 정보는 존재하지 않습니다.');
				} else {
					$("#msg").html('이메일은 "'+res.trim()+'" 입니다.');
				}
			}
		})
		return false; 
	}    
</script>
<style type="text/css">
   .findEmail_sub {
	 	display: flex;
	  	justify-content: center;
	  	align-items:center;
	  	min-height: 60vh;
	}
	.findEmail_box {
		text_align:relative; left: 200px;
	}
	.findEmail_sub_title {
		font-size: 60px;
	    margin-top: 240px;
	    margin-bottom: -25px;
	    text-align: center;
	    margin-right: 4px; 
	}
	.email_ul {
		padding-left: 0px; width:400px;
	}
	.email_form{
		width: 360px;border:none;
	}
	.ul_li {
		list-style:none; margin: 20px;
	}
	.email_ul_li_input {
		position: relative;
		padding-left: 14px;
		line-height: 1.6;
		color: #666;
		text-indent: -3px;
		font-size: 32px;
		width: 330px;
		height: 50px;
		margin-right:45px;
	}
	.emailBtn {
		background-color: #121533; 
		color: white;
		font-size: 30px;
		width: 353px; height:50px;
		position: center;
		border: 0;
		margin-left:18px;
	}
	.btn{
		text-decoration-line: none;
		text-decoration: none;
		color : black;
	}
	.btnSet_clear{
		margin-top: -5px;
		margin-left: 123px;
	}
</style>
</head>
<body>
	<form action="login.do" method="post" id="loginFrm1" name="loginFrm1" onsubmit="return findEmail();"><!-- header에서 id="board"이미 사용중이라서 board2로 함 -->
	    <div class="findEmail_sub">
	        <div class="size">
	            <h3 class="findEmail_sub_title">이메일 찾기</h3>
	            <div class="member">
	                <div class="findEmail_box">
	                    <fieldset class="email_form">
	                        <ul class="email_ul">
	                            <li class="ul_li"><input class="email_ul_li_input" type="text" id="name" name="name" placeholder="이름"></li>
	                            <li class="ul_li"><input class="email_ul_li_input" type="text" id="tel" name="tel" placeholder="전화번호"></li>
	                            <li class="ul_li"  id="msg"></li>
	                        </ul>
	                        <div class="login_btn"><input class="emailBtn" type="submit" value="이메일 찾기" alt="이메일 찾기" /></div>
	                    </fieldset>
	                    <div class="btnSet_clear">
	                        <div>
	                            <a href="signUp.do" class="btn">회원가입</a> 
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