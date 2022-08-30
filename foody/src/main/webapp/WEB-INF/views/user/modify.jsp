<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
<meta name="format-detection" content="telephone=no, address=no, email=no">
<meta name="keywords" content="">
<meta name="description" content="">
<title>회원수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
		    reader.onload = function(e) {
				document.getElementById('imgmodify').src = e.target.result;
		};
			reader.readAsDataURL(input.files[0]);
		} else {
			document.getElementById('imgmodify').src = "";
		}
	}
   	function goSave(){
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
   		var f = document.frm;
		f.tel.value = f.tel1.value + f.tel2.value + f.tel3.value;
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
   	})
</script>
<style type="text/css">
    .jb-wrap img {
        width: 100%;
        vertical-align: middle;
    }
    .jb-text {
        padding: 5px 10px;
        background-color: yellow;
    }
    .signUpNext_title{font-size: 60px;}.signUpNext_sub_title{font-size: 20px;} .signUpNext_th{font-size: 20px;} 
    #frm{margin-left:6px;margin-top:4px;} #intro{font-size: 15px;width:350px;height:130px;border-radius:7px;}
    #height,#weight{border-radius:5px;} #activity{height:30px;border-radius:3px;}
    input[type="checkbox"]{
    	zoom: 1.3;
    	font-size:15px;
    }
    .btnSet_clear{float:right;margin-top:5px;}  
    .submitBtn button{
		width: 150px;height: 45px;
		background-color:white;
		border-color:#6A6D6F;
		border-radius:5px;
		font-size:20px;
		color:#6A6D6F;
		font-weight: bolder;
		border-width: thin;
	}
	.submitBtn button:hover{
		color:white;
		background-color:#6A6D6F;
	}
	.sub_title{
		font-size: 50px;
	    color: #6A6D6F;
	    margin-bottom: -2px;
	    margin-top: -15px;
	}
	th{
		width:100px;
		font-size: 24px;
    	color: #6A6D6F;
    }
	tr{width:70px;}
	td{
		height:28px;font-size: 20px;border-radius:7px;margin-left:5px;
	}
	.submitBtn{
		width: 150px;height: 45px;
		background-color:white;
		border-color:#6A6D6F;
		border-radius:5px;
		font-size:20px;
		color:#6A6D6F;
		font-weight: bolder;
		border-width: thin;
	}
	.submitBtn:hover{
		color:white;
		background-color:#6A6D6F;
	}
	#nik_name,#email,#name,#zipcode,#addr1,#addr2,#height,#weight{
		width: 125px;
	    height: 30px;
	    float: left;
	    font-size: 21px;
	}
	#addr1,#addr2{width: 515px;}
	#intro{font-size: 21px;}
	.dupCheckBtnNik,#zipCode{
		text-decoration: none;
		color: black;
		margin-top:5px;
		vertical-align : middle;
		margin-left:4px;
	}
	#zipCode:hover{color:red;}
	.dupCheckBtnNik:hover{color:red;}
	#tel2,#tel3{
		height: 30px;
	    width: 45px;
	    font-size: 18px;
	}
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
	    -webkit-appearance: none;
	    margin: 0;
	}
	#nik_name,#height,#weight{border-radius: 5px;width:110px;float:left;border:1px solid #6A6D6F}
	#preview{
   		height: 150px;
	    width: 150px;
	    border-radius: 50%;
	    diplay:none;
	}
</style>
<%@ include file="../common/addrAPI.jsp" %>
</head>
<body>
	<div class="sub">
	    <div class="size">
	        <h3 class="sub_title">회원수정</h3>
	        <form name="frm" id="frm" action="modify.do" method="post" enctype="multipart/form-data">
	        <input type="hidden" name="no" value="${modify.uvl.no}">
	        <input type="hidden" name="selfi">
	        <div >
		        <c:if test="${!empty modify.uvl.selfi}">
					<img id="imgmodify" src="/foody/upload/${modify.uvl.selfi}" style="width: 175px;height: 175px;border-radius:50%;">
				</c:if>
				<c:if test="${empty modify.uvl.selfi}">
					<img id="imgmodify" src="/foody/img/basic_profile.png" style="width: 175px;height: 175px;border-radius:50%;">
				</c:if>
			</div>
			<input type="file" id="chooseFile" name="chooseFile" onchange="readURL(this);">
	        <table class="board_modify">
	            <tbody>
	                <tr>
	                    <th>닉네임</th>
	                    <td>
	                        <input type="text" name="nik_name" id="nik_name" maxlength="10" value="${modify.userInfo.nik_name}">
	                        <span class="nik_name_check"><a href="javascript:;" class="dupCheckBtnNik" id="dupCheckBtnNik">중복확인</a></span>
	         			</td>
	                </tr>
	                <tr>
	                    <th>이메일</th>
	                    <td>
	                        <input name="email" id="email" class="" style="width:200px;float:left;border:none;" value="${modify.userInfo.email}" readonly="readonly">
	                    </td>
	                </tr>
	                <tr>
	                    <th>이름</th>
	                    <td>
	                        <input name="name" id="name" class="" style="width:90px;float:left;border:none;" maxlength="5" value="${modify.userInfo.name}" readonly="readonly">
	          			</td>
	                </tr>
	                <tr>
	                    <th>한줄소개</th>
	                    <td>
		                    <textarea name="intro" id="intro" >${modify.userInfo.intro}</textarea>
	          			</td>
	                </tr>
	                <tr>
	                    <th>전화번호</th>
	                    <td>
 	                    	<c:set var="tel" value="${fn:substring(modify.userInfo.tel,0,3)}"/>
	                  		<input type="hidden" name="tel">
	                    	<select class="tel1" name="tel1" style="height:37px;font-size:18px;">
							    <option value="010" <c:if test ="${fn:substring(modify.userInfo.tel,0,3) eq 010}">selected="selected"</c:if>>010</option>
							    <option value="011" <c:if test ="${fn:substring(modify.userInfo.tel,0,3) eq 011}">selected="selected"</c:if>>011</option>
							    <option value="012" <c:if test ="${fn:substring(modify.userInfo.tel,0,3) eq 012}">selected="selected"</c:if>>012</option>
							</select> -
	                    	<input type="number" name="tel2" id="tel2" value="${fn:substring(modify.userInfo.tel,3,7)}" maxlength="4"  pattern="|d*"> -
	                    	<input type="number" name="tel3" id="tel3" value="${fn:substring(modify.userInfo.tel,7,12)}" maxlength="4"  pattern="|d*">
	           			</td>
	                </tr>
	                <tr>
	                    <th rowspan="3">주소</th>
	                    <td>
	                        <input type="text" name="zipcode" id="zipcode" class="inNextBtn" style="float:left;" value="${modify.userInfo.zipcode}" readonly>
	                        <span class="zip_code"><a href="javascript:zipcode();" id="zipCode"  class="btn bgGray">우편번호</a></span>
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                    	<input type="text" name="addr1" id="addr1" value="${modify.userInfo.addr1}" readonly>
	                    </td>
	               	</tr>
	                <tr>
	                    <td>
	                    	<input type="text" name="addr2" id="addr2" value="${modify.userInfo.addr2}">
	                    </td>
	                </tr>
	                <tr>
			            <th>키</th>
			            <td>
			               	<input type="text" name="height" id="height" value="${modify.userInfo.height}"> cm
			            </td>
			        </tr>
			        <tr>
			            <th>몸무게</th>
			            <td>
			                <input type="text" name="weight" id="weight" value="${modify.userInfo.weight}"> kg
			            </td>
			        </tr>
			        <tr>
			            <th>활동지수</th>
			            <td>
				            <select name="activity" style="height:37px;font-size:17px;">
					        	<option value="30" <c:if test ="${modify.userInfo.activity eq 30}">selected="selected"</c:if>>앉아서 주로 생활하거나 활동량이 적은 경우</option>
					        	<option value="35" <c:if test ="${modify.userInfo.activity eq 35}">selected="selected"</c:if>>규칙적인 생활로 보통의 활동량을 가진 경우</option>
					        	<option value="40" <c:if test ="${modify.userInfo.activity eq 40}">selected="selected"</c:if>>육체노동 등 평소 신체 활동량이 많은 경우</option>
					        </select>
			            </td>
			        </tr>
	                <tr>
	                	<th>선호음식</th>
	                    <td>
	                    	${modify.prefer}
	                    </td>
	                </tr>
	                <tr>
	                	<th>알레르기</th>
	                    <td>
	                    	${modify.allergy}
	                    </td>
	                </tr>
	            </tbody>
	        </table>
	        </form>
	        <!-- //write--->
	        <div class="btnSet_clear" style="margin-right: 13px;">
	            <div class="modifyCon">
					<button type="button" class="submitBtn" id="userInfoModify" onclick="location.href='/foody/mypage/mypage.do'">마이페이지</button>
					<button type="button" class="submitBtn" id="userExit" onclick="goSave();">저장하기</button>
				</div>
	        </div>
	    </div>
	</div>
</body>
</html>