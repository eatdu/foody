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
    <title>회원가입</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script>
    	function goSave(){
    		if($("#email").val().trim() == ''){ // 이메일공란 체크
    			alert('이메일을 입력해 주세요.');
    			$("#email").focus();
    			return;
    		}
    		// 이메일 입력형식 체크
    		/* var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
    		if(!reg_email.test($("#email").val())){
    			alert('이메일 형식이 올바르지 않습니다.');
    			return;
    		} */
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
    		/* var reg_nik_name = /^[가-힣]{2,4}|[a-zA-Z]{2,10}[a-zA-Z]{2,10}$/;
    		if(!reg_nik_name.test($("#nik_name").val())){
    			alert('한글 또는 영문으로만 입력해주세요.')
    			return;
    		} */
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
    		//var reg_tel = /^d{4}-\d{4}$/;
   			/* if(!reg_tel.test($("#tel2").val())){ // 전화번호2 숫자만 입력
    			alert('숫자만 입력해주세요.');
    			$("#tel2").focus();
    			return;
    		} */
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
    		/* if(!reg_tel.test($("#tel3").val())){ // 전화번호3 숫자만 입력
    			alert('숫자만 입력해주세요.');
    			$("#tel3").focus();
    			return;
    		} */
    		if($('#tel3').val().length != 4){ // 전화번호3 칸수제한
	  			alert('전화번호 4자리를 입력해 주세요.');
   		    	$('#tel3').focus()
     		    return;
     		}
    		// 이름 입력형식(한글만 입력 최대5자) 체크
    		/* var reg_name = /^[가-힣]{2,5}$/;
    		if(!reg_name.test($("#name").val())){
    			alert('한글로 입력해주세요.')
    			return;
    		} */
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
    		/* var reg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
    		if(!reg.test($("#pwd").val())){
    			alert('비밀번호는 영문,숫자,특수문자 조합으로 8자 이상 입력하세요.')
    			return;
    		} */
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
    				success : function(result){
    					if(result == 0){
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
<script>
    function zipcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                	addr += extraAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("addr1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addr2").focus();
            }
        }).open();
    }
</script>
</head>
<body>
    
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">회원가입</h3>
                <form name="frm" id="frm" action="signUp.do" method="post"><!-- enctype="multipart/form-data" -->
                <table class="board_write">
                    <caption>회원가입</caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="*" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>*이메일</th>
                            <td>
                                <input type="text" name="email" id="email" class="" style="float:left;" maxlength="30" required>
                                <span class="email_check"><a href="javascript:;"  class="" style="float:left; width:auto; clear:none;" id="dupCheckBtnEmail">중복확인</a></span>
                            </td>
                        </tr>
                        <tr>
                            <th>*닉네임</th>
                            <td>
                                <input type="text" name="nik_name" id="nik_name" class="" style="width:90px;float:left;" maxlength="10" required>
                                <span class="nik_name_check"><a href="javascript:;" class="" style="float:left; width:auto; clear:none;" id="dupCheckBtnNik">중복확인</a></span>
			                </td>
                        </tr>
                        <tr>
                            <th>*이름</th>
                            <td>
                                <input type="text" name="name" id="name" class="" style="width:90px;float:left;" maxlength="5" required>
			                </td>
                        </tr>
                        <tr>
                            <th>*전화번호</th>
                            <td>
                          		<input type="hidden" name="tel">
                            	<select name="tel1" style="height:22px;">
                            		<option value="010">010</option>
                            		<option value="011">011</option>
                            		<option value="012">012</option>
                            	</select> - 
                            	<input type="text" name="tel2" id="tel2" class="" style="width:35px;" maxlength="4" required> -
                            	<input type="text" name="tel3" id="tel3" class="" style="width:35px;" maxlength="4" required>
			                </td>
                        </tr>
                        <tr>
                            <th>*주민번호</th>
                            <td>
                                <input type="hidden" name="birth">
                                <input type="text" name="birth1" id="birth1" class="" style="width:70px;" maxlength="6" required>-
                                <input type="password" name="birth2" id="birth2" class="" style="width:7px;"maxlength="1" required><span>******</span>
			                </td>
                        </tr>
                        <tr>
                            <th>*비밀번호</th>
                            <td><input type="password" name="pwd" id="pwd" style="float:left;" required>&nbsp;
                            <span class="">비밀번호는 숫자, 영문 조합으로 8자 이상으로 입력해주세요.</span></td>
                        </tr>
                        <tr>
                            <th>*비밀번호<span>확인</span></th>
                            <td><input type="password" name="pwd_check" id="pwd_check" style="float:left;" required></td>
                        </tr>
                        <tr>
                            <th rowspan="3">주소</th>
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
                        <input type="hidden" name="checkEmail" id="checkEmail" value="0"/>
                </form>
                <!-- //write--->
                <div class="btnSet clear">
                    <div>
	                    <button type="button" id="goBackBtn" name="goBackBtn" onclick="history.back();">돌아가기</button>
	                    <button type="button" id="goNextBtn" name="goNextBtn" onclick="goSave();">가입하기</button>
                    </div>
                </div>
            </div>
        </div>
        
</body>
</html>