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
    <title>이메일 찾기</title>
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
</head>
<body>
    																				<!-- return이 없으면 false가 나도 전송이됨 -->
        <form action="login.do" method="post" id="loginFrm1" name="loginFrm1" onsubmit="return findEmail();"><!-- header에서 id="board"이미 사용중이라서 board2로 함 -->
            <div class="sub">
                <div class="size">
                    <h3 class="sub_title">이메일 찾기</h3>
                    
                    <div class="member">
                        <div class="box">
                            <fieldset class="login_form">
                                <ul>
                                    <li><input type="text" id="name" name="name" placeholder="이름"></li>
                                    <li><input type="text" id="tel" name="tel" placeholder="전화번호"></li>
                                    <li id="msg"></li>
                                </ul>
                                <div class="login_btn"><input type="submit" value="이메일 찾기" alt="이메일 찾기" /></div>
                            </fieldset>
                            <div class="btnSet clear">
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