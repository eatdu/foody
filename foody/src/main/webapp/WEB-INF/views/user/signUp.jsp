<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
   	function goSave(route){
   		$("#route").val(route);
   		if($("#email").val().trim() == ''){ // 이메일공란 체크
   			alert('이메일을 입력해 주세요.');
   			$("#email").focus();
   			return;
   		}
   		// 이메일 입력형식 체크
   		var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
   		if(!reg_email.test($("#email").val())){
   			alert('이메일 형식이 올바르지 않습니다.');
   			return;
   		}
   		// 이메일 중복확인
   		var isCon = true;
   		$.ajax({
			url : 'emailDupCheck.do',
			data : {email:$('#email').val()},
			async : false,
			success:function(res){
				if(res == 'true'){
					alert('입력한 이메일이 중복되었습니다. 다른 이메일을 입력해주세요.');
					$("#email").focus();
					isCon = false;
				}
			}
		});
   		if(!isCon) return;
   		if($("#nik_name").val().trim() == ''){ // 닉네임공란 체크
   			alert('닉네임을 입력해 주세요.');
   			$("#nik_name").focus();
   			return;
   		}
   		// 닉네임 입력혁식(한글 or 영문으로만 입력) 체크 
   		var reg_nik_name = /^[가-힣]{2,4}|[a-zA-Z]{2,10}[a-zA-Z]{2,10}$/;
   		if(!reg_nik_name.test($("#nik_name").val())){
   			alert('한글 또는 영문으로만 입력해주세요.')
   			return;
   		}
   		// 닉네임 중복확인
   		var isCon = true;
   		$.ajax({
			url : 'nik_nameDupCheck.do',
			data : {nik_name:$('#nik_name').val()},
			async : false,
			success:function(res){
				if(res == 'true'){
					alert('입력한 닉네임이 중복되었습니다. 다른 닉네임을 입력해주세요.');
					$("#nik_name").focus();
					isCon = false;
				}
			}
		});
   		if(!isCon) return;
   		if($("#name").val().trim() == ''){ // 이름공란 체크
   			alert('이름을 입력해 주세요.');
   			$("#name").focus();
   			return;
   		}
   		if($("#tel2").val().trim() == ''){ // 전화번호2공란 체크
   			alert('전화번호를 입력해 주세요.');
   			$("#tel2").focus();
   			return;
   		}
   		var reg_tel = /^d{4}-\d{4}$/;
  		if(!reg_tel.test($("#tel2").val())){ // 전화번호2 숫자만 입력
   			alert('숫자만 입력해주세요.');
   			$("#tel2").focus();
   			return;
   		}
   		if($('#tel2').val().length != 4){ // 전화번호2 칸수제한
  			alert('전화번호 4자리를 입력해 주세요.');
  		    	$('#tel2').focus()
    		    return;
    		}
   		if($("#tel3").val().trim() == ''){ // 전화번호3공란 체크
   			alert('전화번호를 입력해 주세요.');
   			$("#tel3").focus();
   			return;
   		}
   		if(!reg_tel.test($("#tel3").val())){ // 전화번호3 숫자만 입력
   			alert('숫자만 입력해주세요.');
   			$("#tel3").focus();
   			return;
   		}
   		if($('#tel3').val().length != 4){ // 전화번호3 칸수제한
  			alert('전화번호 4자리를 입력해 주세요.');
  		    	$('#tel3').focus()
    		    return;
    		}
   		// 이름 입력형식(한글만 입력 최대5자) 체크
   		var reg_name = /^[가-힣]{2,5}$/;
   		if(!reg_name.test($("#name").val())){
   			alert('한글로 입력해주세요.')
   			return;
   		} 
   		if($("#birth1").val().trim() == ''){ // 주민번호공란 체크
   			alert('주민번호를 입력해 주세요.');
   			$("#birth1").focus();
   			return;
   		}
   		if($('#birth1').val().length != 6){ // 전화번호2 칸수제한
  			alert('주민번호 6자리를 입력해 주세요.');
  		    	$('#birth1').focus()
    		    return;
    		}
   		if($("#birth2").val().trim() == ''){ // 주민번호공란 체크
   			alert('주민번호(성별)를 입력해 주세요.');
   			$("#birth2").focus();
   			return;
   		}
   		if($("#pwd").val().trim() == ''){ // 비밀번호공란 체크
   			alert('비밀번호를 입력해 주세요.');
   			$("#pwd").focus();
   			return;
   		}
   		// 비밀번호 입력형식 체크
   		var reg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
   		if(!reg.test($("#pwd").val())){
   			alert('비밀번호는 영문,숫자,특수문자 조합으로 8자 이상 입력하세요.')
   			return;
   		}
   		// 비밀번호입력 및 비밀번호 확인란 중복 체크
   		if($("#pwd").val() != $("#pwd_check").val()){
   			alert('비밀번호가 일치하지 않습니다.');
   			$("#pwd_check").focus();
   			return;
   		}
   		$("#frm").submit();
   	}
   	
   	$(function(){
   		$('#tel2').on('keyup', function() { // 전화번호2번 4자리 입력시 전화번호3번칸으로 자동이동
   		    if(this.value.length == 4) {
   		       $('#tel3').focus()
   		    }
   		});
   		$('#tel3').on('keyup', function() { // 전화번호2번 4자리 입력시 주민번호칸으로 자동이동
   		    if(this.value.length == 4) {
   		       $('#birth1').focus()
   		    }
   		});
   		$('#birth1').on('keyup', function() { // 주민번호 6자리 입력시 주민번호(성별)칸으로 자동이동
   		    if(this.value.length == 6) {
   		       $('#birth2').focus()
   		    }
   		});
   		$('#birth2').on('keyup', function() { // 주민번호(성별) 입력시 비밀번호칸으로 자동이동
   		    if(this.value.length == 1) {
   		       $('#pwd').focus()
   		    }
   		});
   		$("#dupCheckBtnNik").click(function(){ // 닉네임 중복확인
   			if($("#nik_name").val().trim() == ''){
   				alert('닉네임을 입력해 주세요.');
   				$("#nik_name").focus();
   			} else {
    			$.ajax({
    				url : 'nik_nameDupCheck.do',
    				data : {nik_name:$('#nik_name').val()},
    				success:function(res){
    					if(res == 'true'){
    						alert('이미 사용중인 닉네임입니다.');
    					} else{
    						alert('사용 가능한 닉네임입니다.');
    					}
    				}
    			});
   			}
   		}); 
   		$("#dupCheckBtnEmail").click(function(){
   			if($("#email").val().trim() == ''){
   				alert('이메일을 입력해 주세요.');
   				$("#email").focus();
   			} else {
    			$.ajax({
    				url : 'emailDupCheck.do',
    				data : {email:$('#email').val()},
    				success:function(res){
    					if(res == 'true'){
    						alert('이미 사용중인 이메일입니다.');
    					} else{
    						alert('사용 가능한 이메일입니다.');
    					}
    				}
    			});
   			}
   		});
   		$('#tel').focusout(function(){
   			let userId = $('#tel').val(); 
   			
   			$.ajax({
   				url : "telDupCheck.do",
   				type : "get",
   				data : {tel: tel},
   				success : function(res){
   					if(res == 'true'){
   						$("#tel").html('이미 사용중인 전화번호입니다.');
   						$("#tel").attr('color','red');
   					} else{
   						$("#tel").html('사용할 수 있는 전화번호입니다.');
   						$("#tel").attr('color','green');
   					} 
   				},
   				error : function(){
   					alert("서버요청실패");
   				}
   			})
   			 
   		})
   		$('#frm').click(function(){
   			var f = document.frm;
   			f.tel.value = f.tel1.value + f.tel2.value + f.tel3.value;
   			f.birth.value = f.birth1.value + f.birth2.value;
   		})
   	})
</script>
<style>
	.signUp_title{font-size: 60px;}.sub_title{font-size: 40px;margin-left: 11%;} .signUp_th{font-size:30px;}
	table tr td{
		font-size: 22px;
	    color: #2e2e2e;
	    height: 39px;
	    padding: 5px 0px 0 2px;
	 	}  
	#email,#nik_name,#name,#tel2,#tel3,#birth1,#birth2,#pwd,#pwd_check,#zipcode,#addr1,#addr2{height:35px;font-size: 20px;border-radius:7px;}
	.signUpFrm{margin-left: 30px;} .signUp_board_write{width:80%;height: 200px;}
	.signUpBtn{float:right;margin-right:1%;}
	/* .nik_nameDupBtn,.emailDupBtn{margin-left:6px;margin-top:4px;} */
	.submitBtn button{
		width: 135px;height: 45px;
		background-color:white;
		border-color:#6A6D6F;
		border-radius:5px;
		font-size:20px;
		color:#6A6D6F;
		font-weight: bolder;
		border-size:0.5px;
	}
	.submitBtn button:hover{
		color:white;
		background-color:#6A6D6F;
	}
</style>
<%@ include file="../common/config.jsp" %>
<%@ include file="../common/addrAPI.jsp" %>
</head>
<body>
<%@ include file="../common/navBar.jsp" %>
	<div class="sub">
	    <h3 class="signUp_title">회원가입</h3>
	    <div class="size">
	        <h3 class="sub_title">기본정보</h3>
	        <form class="signUpFrm" name="frm" id="frm" action="signUp.do" method="post">
	        <input type="hidden" name="route" id="route" value="login">
	        <table class="signUp_board_write">
	            <caption>회원가입</caption>
	            <colgroup>
	                <col width="20%" />
	                <col width="*" />
	            </colgroup>
	            <tbody>
	                <tr>
	                    <th class="signUp_th">이메일</th>
	                    <td>
	                        <input type="text" name="email" id="email" class="" style="float:left;" maxlength="30" required>
	                        <span class="email_check"><a href="javascript:;"  class="emailDupBtn" style="float:left; width:auto; clear:none;" id="dupCheckBtnEmail">중복확인</a></span>
	                    </td>
	                </tr>
	                <tr>
	                    <th class="signUp_th">닉네임</th>
	                    <td>
	                        <input type="text" name="nik_name" id="nik_name" class="" style="width:120px;float:left;" maxlength="10" required>
	                        <span class="nik_name_check"><a href="javascript:;" class="nik_nameDupBtn" style="float:left; width:auto; clear:none;" id="dupCheckBtnNik">중복확인</a></span>
	         			</td>
	                </tr>
	                <tr>
	                    <th class="signUp_th">이름</th>
	                    <td>
	                        <input type="text" name="name" id="name" class="" style="width:120px;float:left;" maxlength="5" required>
	          			</td>
	                </tr>
	                <tr>
	                    <th class="signUp_th">전화번호</th>
	                    <td>
	                  		<input type="hidden" name="tel">
	                    	<select name="tel1" style="height:41px;border-radius: 7px;">
	                    		<option value="010">010</option>
	                    		<option value="011">011</option>
	                    		<option value="012">012</option>
	                    	</select> - 
	                    	<input type="text" name="tel2" id="tel2" class="" style="width:60px;" maxlength="4" required> -
	                    	<input type="text" name="tel3" id="tel3" class="" style="width:60px;" maxlength="4" required>
	           			</td>
	                </tr>
	                <tr>
	                    <th class="signUp_th">주민번호</th>
	                    <td>
	                        <input type="hidden" name="birth">
	                        <input type="text" name="birth1" id="birth1" class="" style="width:70px;" maxlength="6" required>-
	                        <input type="password" name="birth2" id="birth2" class="" style="width:18px;"maxlength="1" required><span>******</span>
	           			</td>
	                </tr>
	                <tr>
	                    <th class="signUp_th">비밀번호</th>
	                    <td><input type="password" name="pwd" id="pwd" style="float:left;" required>&nbsp;
	                    <span class="">비밀번호는 숫자, 영문 조합으로 8자 이상으로 입력해주세요.</span></td>
	                </tr>
	                <tr>
	                    <th class="signUp_th">비밀번호<span>확인</span></th>
	                    <td><input type="password" name="pwd_check" id="pwd_check" style="float:left;" required></td>
	                </tr>
	                <tr>
	                    <th rowspan="3" class="signUp_th">주소</th>
	                    <td>
	                        <input type="text" name="zipcode" id="zipcode" class="inNextBtn" style="float:left;" readonly>
	                        <span class="email_check"><a href="javascript:zipcode();"  class="btn bgGray" style="float:left; width:auto; clear:none;">우편번호</a></span>
	                    </td>
	                </tr>
	                <tr>	
	                    <td>
	                    	<input type="text" name="addr1" id="addr1" style="width:80%" readonly>
	                    </td>
	               	</tr>
	                <tr>
	                    <td>
	                    	<input type="text" name="addr2" id="addr2" style="width:80%">
	                    </td>
	                </tr>
	            </tbody>
	        </table>
	        </form>
	        <!-- //write--->
	        <div class="btnSet clear">
	            <div class="submitBtn">
		             <button class="signUpBtn" type="button" id="goFinish" name="goFinish" onclick="goSave('login');">가입완료</button>
		             <button class="signUpBtn" type="button" id="goProfile" name="goProfile" onclick="goSave('profile');">프로필등록하기</button>
	            </div>
	        </div>
	    </div>
	</div>
</body>
</html>