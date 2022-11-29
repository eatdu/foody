<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="header">
	<div class="header_inner">
		<a href="/foody/recipe/main.do"><h1 style="font-size: 50px;">Foody</h1></a>
		<!-- util : s -->
		<div class="util">
			<ul>
				<li>
				<div class='navInfo'>
					<c:if test="${!empty loginInfo and !empty loginInfo.selfi}">
						<div class="navUserImg" id="navUserImg" style='background:url(/foody/upload/${loginInfo.selfi});background-size: cover;'></div>
						<div class="navUserName">
							<span>${loginInfo.nik_name}</span>
						</div>
						<div class="navUserInfo" id="navUserInfo">
							<div class="navUserImgBig" style="background:url(/foody/upload/${loginInfo.selfi});background-size: cover;"></div>
							<div class="userDetail">
								<a style="font-size: 17px;">${loginInfo.nik_name}</a>
								<br><a style="font-size: 17px;">${loginInfo.email}</a>
							</div>
							<a href="/foody/mypage/mypage.do"><button class="btn1" type="button" id="mypage">마이페이지</button></a>
							<a href="/foody/user/logout.do"><button class="btn1" type="button" id="logout">로그아웃</button></a>
							<a href="#pop_info_1" id="userInfoModify"><button class="btn1" type="button" id="userModify">회원정보수정</button></a>
						</div>
					</c:if>
					<c:if test="${!empty loginInfo and empty loginInfo.selfi}">
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
							<a href="/foody/mypage/mypage.do"><button class="btn1" type="button" id="mypage">마이페이지</button></a>
							<a href="/foody/user/logout.do"><button class="btn1" type="button" id="logout">로그아웃</button></a>
							<a href="#pop_info_1" id="userInfoModify"><button class="btn1" type="button" id="userModify">회원정보수정</button></a>
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
							<a href="/foody/user/login.do"><button class="btn1" type="button">로그인</button></a>
							<a href="/foody/user/signUp.do"><button class="btn1" type="button">회원가입</button></a>
						</div>
					</c:if>
				</div>
				</li>
			</ul>
		</div>
		<!-- util : e --> 
		<!-- 모달 비밀번호체크 -->
		<div class="modifyCon">
			<div class="wrap">
				<div id="pop_info_1" class="pop_wrap" style="display:none;">
					<div class="pop_inner">
						<form method="post" id="modifyPwdCheck" name="pwdCheck" action="/foody/user/modifyPwdCheck.do">
						<input type="hidden" name="email" value="${loginInfo.email}">
							<input type="password" id="pwdCheck" name="pwd" placeholder="비밀번호">
						</form>
						<button type="button" class="submitBtn" onclick="$('#modifyPwdCheck').submit();">회원정보수정</button>
						<button type="button" class="btn_close">닫기</button>
					</div>
				</div>
			</div>
		</div>
		
		<div id="menu">
  			<ul class="menu">
  				<li><a href="/foody/recipe/main.do" class="parent"><span>메인</span></a></li>
  				<li><a href="/foody/recipe/introduce.do" class="parent"><span>Foody 소개</span></a></li>
				<li><a href="/foody/recipe/search.do" class="parent"><span>상세검색</span></a></li>
				<li><a href="/foody/es.do" class="parent"><span>상세검색-ES</span></a></li>
				<li><a href="/foody/board/index.do" class="parent"><span>게시판</span></a>
					<div class="standard_left">
					<ul>
						<li><a href="/foody/board/index.do"><span>자유</span></a></li>
						<li><a href="/foody/board/qna.do"><span>Q&A</span></a></li>
					</ul>
					</div>
				</li>
				<li><a href="/foody/mypage/mypage.do" class="parent"><span>마이페이지</span></a></li>
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
<script>
	var target = document.querySelectorAll('#userInfoModify');
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
	*{margin:0; padding:0;}
	.pop_wrap{position:fixed; top:0; left:0; right:0; bottom:0; background:rgba(0,0,0,.5); font-size:0; text-align:center;}
	.pop_wrap:after{display:inline-block; height:100%; vertical-align:middle; content:'';}
	.pop_wrap .pop_inner{display:inline-block; padding:20px 30px; background:#fff; width:200px; vertical-align:middle; font-size:15px;}
	.recipeModify{
		width: 150px;height: 45px;
		border-color:#6A6D6F;
		border-radius:5px;
		font-size:20px;
		color:#6A6D6F;
		font-weight: bolder;
		border-width: thin;
	}
</style>