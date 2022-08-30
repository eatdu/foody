<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
function del(no){
	if (confirm("탈퇴하시겠습니까?")){
		$.ajax({
			url : '/foody/user/exit.do?no='+no,
			success : function(res){
				if(res.trim() == '1'){
					alert('탈퇴완료');
				}	    					
			}
		})
	}
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
	.modifyCon{
		margin-left:1300px;
		margin-top:14px;
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
				<button type="button" class="submitBtn" id="userInfoModify" onclick="location.href='/foody/user/modify.do'">회원정보수정</button>
				<button type="button" class="submitBtn" id="userExit" onclick="location.href='/foody/user/exit.do'">탈퇴하기</button>
			</div>
		</div>
	</div>
</div>