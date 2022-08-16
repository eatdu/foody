<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="header">
	<div class="header_inner">
		<h1>Foody</h1>
		<p class="login_name"></p>
		<!-- util : s -->
		<div class="util">
			<ul>
				<li>
				<div class='navInfo'>
					<c:if test="${!empty loginInfo}">
						<div class="navUserImg" id="navUserImg" style='background:url(/foody/resources/img/emoji-smile.svg)'></div>
						<div class="navUserName">
							<span>${loginInfo.nik_name}</span>
						</div>
						<div class="navUserInfo" id="navUserInfo">
							<img src='/foody/resources/img/emoji-smile.svg' style='width:50px; height:50px'><br>
							<span>${loginInfo.nik_name} 님</span><br>
							<span>email: ${loginInfo.email}</span><br>
							<a href="/foody/mypage/mypage.do"><button type="button" id="mypage">마이페이지</button></a>
							<button type="button" id="logout">로그아웃</button>
						</div>
					</c:if>
					<c:if test="${empty loginInfo}">
						<div class="navUserImg" id="navUserImg" style='background:url(/foody/resources/img/emoji-smile.svg)'></div>
						<div class="navUserName">
							<span>Guest</span>
						</div>
						<div class="navUserInfo" id="navUserInfo">
							<img src='/foody/resources/img/emoji-smile.svg' style='width:50px; height:50px'><br>
							<span>손님</span><br>
							<a href="/foody/user/signUp.do"><button type="button">회원가입</button></a>
							<a href="/foody/user/login.do"><button type="button">로그인</button></a>
						</div>
					</c:if>
				</div>
				</li>
			</ul>
		</div>
		<!-- util : e --> 
		
		<div id="menu">
  			<ul class="menu">
  				<li><a href="/foody/recipe/main.do" class="parent"><span>메인</span></a></li>
				<li><a href="/foody/recipe/search.do" class="parent"><span>상세검색</span></a></li>
				<li><a href="" class="parent"><span>게시판</span></a>
					<div class="standard_left">
					<ul>
						<li><a href=""><span>자유</span></a></li>
						<li><a href=""><span>Q&A</span></a></li>
					</ul>
					</div>
				</li>
				<li><a href="" class="parent"><span>마이페이지</span></a></li>
			</ul>
		</div>
		<!--//gnb-->
	</div>
	<!-- //header_inner -->
</div>
<script>
	$(function(){
		$("#navUserImg").on("click", function(){
			dis($("#navUserInfo"));
		});
	});
    function dis(obj){
        if($(obj).css('display') == 'none'){
	        $(obj).show();
	    }else{
	        $(obj).hide();
	    }
    }
</script>