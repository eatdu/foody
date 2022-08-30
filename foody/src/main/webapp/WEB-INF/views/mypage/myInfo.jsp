<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
var target = document.querySelectorAll('.userInfoModifyBtn');
var btnPopClose = document.querySelectorAll('.pop_wrap .btn_close');
var targetID;

// 팝업 열기
for(var i = 0; i < target.length; i++){
  target[i].addEventListener('click', function(){
    targetID = this.getAttribute('href');
    document.querySelector(targetID).style.display = 'block';
  });
}

// 팝업 닫기
for(var j = 0; j < target.length; j++){
  btnPopClose[j].addEventListener('click', function(){
    this.parentNode.parentNode.style.display = 'none';
  });
}
</script>
<style>
	.profile{
		position: relative;
	}
	.profileT{
		margin:auto;
		margin-bottom:10px;
	}
	.userInfoT{
		margin:auto;
		font-size: 30px;
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
	.btn_close{
		width: 150px;height: 45px;
		background-color:white;
		border-color:#6A6D6F;
		border-radius:5px;
		font-size:20px;
		color:#6A6D6F;
		font-weight: bolder;
		border-width: thin;
	}
	.btn_close:hover{
		color:white;
		background-color:#6A6D6F;
	}	
	.modifyCon{
		margin-left:1300px;
		margin-top:14px;
	}
	*{margin:0; padding:0;}
	.pop_wrap{position:fixed; top:0; left:0; right:0; bottom:0; background:rgba(0,0,0,.5); font-size:0; text-align:center;}
	.pop_wrap:after{display:inline-block; height:100%; vertical-align:middle; content:'';}
	.pop_wrap .pop_inner{display:inline-block; padding:20px 30px; background:#fff; width:200px; vertical-align:middle; font-size:15px;}
	.wrap{padding:10px;}
	.userInfoModifyBtn{
		width: 150px;height: 45px;
		background-color:white;
		border-color:#6A6D6F;
		border-radius:5px;
		font-size:20px;
		color:#6A6D6F;
		font-weight: bolder;
		border-width: thin;
	}
</style>
<div class="loginInfo">
	<div class="userInfo">
		<div class="profile">
			<table class="profileT">
				<tr>
					<td>
						${loginInfo.nik_name}
					</td>
				</tr>
				<tr>
					<td>
						<c:if test="${!empty loginInfo.selfi}">
							<img src="/foody/upload/${loginInfo.selfi}" style="width: 175px;height: 175px;border-radius:50%;">
						</c:if>
						<c:if test="${empty loginInfo.selfi}">
							<img src="/foody/img/basic_profile.png" style="width: 175px;height: 175px;border-radius:50%;">
						</c:if>
					</td>
				</tr>
			</table>
			<table class="userInfoT">
				<tr>
					<td>
						이름
					</td>
					<td>
						${loginInfo.name}
					</td>
					<td>
						선호음식
					</td>
					<td>
						<c:forEach var="prefer" items="${myInfo.prefer}" varStatus="status">
							${prefer}<c:if test="${status.last eq false}">,</c:if>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td>
						이메일
					</td>
					<td>
						${myInfo.uv.email}
					</td>
					<td>
						알레르기
					</td>
					<td>
						<c:forEach var="allergy" items="${myInfo.allergy}" varStatus="status">
							${allergy.allergy}<c:if test="${status.last eq false}">,</c:if>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<td>
						소개
					</td>
					<td>
						${loginInfo.intro}
					</td>
					<td>
						하루권장섭취 칼로리
					</td>
					<td>
						${myInfo.cal}kcal
					</td>
				</tr>
				<tr>
					<td>
						주소
					</td>
					<td>
						(${loginInfo.zipcode})${loginInfo.addr1},${loginInfo.addr2}
					</td>
				</tr>
				<tr>
					<td>
						비밀번호
					</td>
					<td>
						${loginInfo.pwd}
					</td>
				</tr>
			</table>
			<div class="modifyCon">
				<div class="wrap">
					<a href="#pop_info_1" class="userInfoModifyBtn">회원정보수정</a>
					<a href="#pop_info_2" class="userInfoModifyBtn">탈퇴하기</a>
					<div id="pop_info_1" class="pop_wrap" style="display:none;">
						<div class="pop_inner">
							<form method="post" id="modifyPwdCheck" name="pwdCheck" action="/foody/user/modifyPwdCheck.do">
							<input type="hidden" name="email" value="${loginInfo.email}">
								<input type="password" id="pwdCheck" name="pwd" placeholder="비밀번호">
							</form>
							<button type="button" class="submitBtn" id="userInfoModify" onclick="$('#modifyPwdCheck').submit();">회원정보수정</button>
							<button type="button" class="btn_close">닫기</button>
						</div>
					</div>
					<div id="pop_info_2" class="pop_wrap" style="display:none;">
						<div class="pop_inner">
							<form method="post" id="exitPwdCheck" name="pwd" action="/foody/user/exitPwdCheck.do">
							<input type="hidden" name="email" value="${loginInfo.email}">
								<input type="password" id="pwdCheck" name="pwd" placeholder="비밀번호">
							</form>
							<button type="button" class="submitBtn" id="userExit" onclick="$('#exitPwdCheck').submit();">탈퇴하기</button>
							<button type="button" class="btn_close">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>