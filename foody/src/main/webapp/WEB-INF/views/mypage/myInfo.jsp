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
<h2>회원 정보관리</h2>
	<div class="loginInfo">
		<div class="userInfo">
			<div class="profile">
				<table border="1">
					<tr>
						<td>
							${loginInfo.nik_name}
						</td>
					</tr>
					<tr>
						<td>
							<img src="/foody/upload/${loginInfo.selfi}" style="width:100px; height:100px; border-radius:50%;">
						</td>
					</tr>
				</table>
				<table border="1">
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
							<c:forEach var="prefer" items="${myInfo.preferList}" varStatus="status">
								${prefer}<c:if test="${status.last eq false}">,</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<td>
							이메일
						</td>
						<td>
							${loginInfo.email}
						</td>
						<td>
							알레르기
						</td>
						<td>
							<c:forEach var="allergyList" items="${myInfo.allergyList}" varStatus="status">
								${allergyList.allergy}<c:if test="${status.last eq false}">,</c:if>
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
							${loginInfo.name}님의 하루권장섭취 칼로리
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
				<span class="userInfoModify" style="font-size:20px;"><a href="/foody/user/modify.do">회원정보수정</a></span>
				<span class="userQuit" style="font-size:20px;"><a href="/foody/user/exit.do" class="btn">회원탈퇴</a></span>
			</div>
		</div>
	</div>