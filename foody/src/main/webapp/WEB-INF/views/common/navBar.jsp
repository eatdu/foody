<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="header">
	<div class="header_inner">
		<h1 style="font-size: 50px;">Foody</h1>
		<!-- util : s -->
		<div class="util">
			<ul>
				<li>
				<div class='navInfo'>
					<c:if test="${!empty loginInfo}">
						<div class="navUserImg" id="navUserImg" style='background:url(/foody/resources/img/emoji-smile.svg);background-size: cover;'></div>
						<div class="navUserName">
							<span>${loginInfo.nik_name}</span>
						</div>
						<div class="navUserInfo" id="navUserInfo">
							<div class="navUserImgBig" style="background:url(/foody/resources/img/emoji-smile.svg);background-size: cover;"></div>
							<div class="userDetail">
								<a style="font-size: 17px;">${loginInfo.nik_name}</a>
								<br><a style="font-size: 17px;">${loginInfo.email}</a>
							</div>
							<a href="/foody/mypage/mypage.do"><button type="button" id="mypage">마이페이지</button></a>
							<a href="/foody/user/logout.do"><button type="button" id="logout">로그아웃</button></a>
							<a href="/foody/user/modify.do"><button type="button" id="modify">회원정보수정</button></a>
						</div>
					</c:if>
					<c:if test="${empty loginInfo}">
						<div class="navUserImg" id="navUserImg" style='background:url(/foody/resources/img/emoji-smile.svg);background-size: cover;'></div>
						<div class="navUserName">
							<span>Guest</span>
						</div>
						<div class="navUserInfo" id="navUserInfo">
							<div class="navUserImgBig" style="background:url(/foody/resources/img/emoji-smile.svg);background-size: cover;"></div>
							<div class="userDetail">
								<a style="font-size: 17px;">Guest</a>
							</div>
							<a href="/foody/user/login.do"><button type="button">로그인</button></a>
							<a href="/foody/user/signUp.do"><button type="button">회원가입</button></a>
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
						<li><a href="/foody/board/index.do"><span>자유</span></a></li>
						<li><a href="/foody/board/qna.do"><span>Q&A</span></a></li>
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
		$(".navUserName").on("click", function(){
			dis($("#navUserInfo"));
		});
	});
    function dis(obj){
        if($(obj).css('display') == 'none'){
	        $(obj).css("display", "inline-block");
	    }else{
	        $(obj).css("display", "none");
	    }
    }
</script>