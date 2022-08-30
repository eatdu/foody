<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="adminMenu">
	<div class="header">
	Foody<br>
	<h1>관리자페이지</h1>
	<h3>${adminInfo.name}님, 환영합니다!</h3>
	<button type="button" onclick="logoutAdmin();">로그아웃</button>	
	</div>
	<ul>
		<a href="main.do"><li>메인페이지</li></a>
		<a href="recipe.do?mode=0"><li>레시피 목록 조회</li></a>
		<a href="comment.do?period=all&align=recent"><li>댓글 목록 조회</li></a>
		<a href="qna.do"><li>QnA 게시판</li></a>
		<a href="userList.do"><li>회원 목록 조회</li></a>
		<a href="ingre.do"><li>식재료 정보 관리</li></a>
	</ul>
</div>
<script>
function logoutAdmin(){
	location.href = "logout.do";
}
</script>