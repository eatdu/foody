<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/config.jsp" %>
<title>로그인</title>
</head>
<style>
form {
	margin: 50px 0 20px 0;
}
html {
	height: 100%;
}
div {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 100%;
    top: -100px;
    position: relative;
}
h1 {
    font-size: 120px;
}
h2 {
    font-size: 30px;
}
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
//관리자 1차 로그인 - 아이디, 비밀번호
function loginCheckAdmin1(){
	if($("#id").val() == ''){ // 아이디 입력체크란
		alert('아이디를 입력해주세요.')
		$("#id").focus();
		return; 
	}		
	if($("#pwd").val() == ''){ // 비밀번호 입력체크란
		alert('비밀번호를 입력해주세요.')
		$("#pwd").focus();
		return; 
	}
	var data = {};
	data.id = $("#id").val();
	data.pwd = $("#pwd").val();
	$("#button").val("인증번호 발송중..").attr("onclick","loginCheckAdmin2();").attr("disabled",true);
	sendAjax(
			"/foody/admin/login1.do",
			data,
			function(result){
				if (result == true) {
					var html = "";
					html += '<input class="login_ul_li_input" type="text" id="confirm" name="confirm" placeholder="인증번호" style="height:35px;padding-left: 5px;text-indent: 3px;font-size: 23px;margin-bottom: 5px;"><br>';
					$("#form").append(html);
					$("#button").val("인증하기").attr("onclick","loginCheckAdmin2();").attr("alt","인증하기").attr("disabled",false);
					$("#id").attr("readonly",true);
					$("#pwd").attr("readonly",true);
					alert("인증번호가 이메일로 발송되었습니다.");
				}
				else alert("회원정보가 일치하지 않습니다.");
			}
	);
}

//관리자 2차 로그인 - 이메일 인증번호 입력
function loginCheckAdmin2(){
	if($("#confirm").val() == ''){ // 아이디 입력체크란
		alert('인증번호를 입력해주세요.')
		$("#confirm").focus();
		return; 
	}		
	var data = {};
	data.confirm = $("#confirm").val();
	sendAjax(
			"/foody/admin/login2.do",
			data,
			function(result){
				if (result == true) {
					alert("인증번호 일치");
					location.href = "main.do";
				}
				else alert("인증번호 불일치");
			}
	);
} 
</script>
<body>
<div>
	<h1>Foody</h1>
	<h2>관리자 페이지</h2>
	<form action="login.do" method="post" id="form">
		<input class="login_ul_li_input" type="text" id="id" name="id" placeholder="아이디" style="height:35px;padding-left: 5px;text-indent: 3px;font-size: 23px;margin-bottom: 5px;"><br>
		<input class="login_ul_li_input" type="password" id="pwd" name="pwd" placeholder="비밀번호" style="height:35px;padding-left: 5px;text-indent: 3px;font-size: 23px;margin-bottom: 5px;"><br>
	</form>
    <input class="loginBtn" id="button" type="button" value="로그인" alt="로그인" onclick="loginCheckAdmin1();"/>
</div>
</body>
</html>