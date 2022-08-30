<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/config.jsp" %>

<script>
function getMyRecipe(page) {
	$.ajax({
		url: "/foody/mypage/myRecipe",
		type: "get",
		dataType: "html",
		data: {
			page: page
		},
		success: function(res) {
			$("#contents").html(res);
		}
	});
}
function getRecentRecipe(page) {
	$.ajax({
		url: "/foody/mypage/recentRecipe",
		type: "get",
		dataType: "html",
		data: {
			page: page
		},
		success: function(res) {
			$("#contents").html(res);
		}
	});
}
function getLikeRecipe(page) {
	$.ajax({
		url: "/foody/mypage/likeRecipe",
		type: "get",
		dataType: "html",
		data: {
			page: page
		},
		success: function(res) {
			$("#contents").html(res);
		}
	});
}
$(function(){
	$.ajax({
		url: "/foody/mypage/myRecipe",
		type: "get",
		dataType: "html",
		success: function(res){
			$("#contents").html(res);
		}
	})
	
	$(".category_item").on("click", function(){
		var id = $(this).attr("id");
		console.log(id);
		 
		$.ajax({
			url: "/foody/mypage/" + id,
			type: "get",
			dataType: "html",
			success: function(res){
				$("#contents").html(res);
			}
		}) 
	});
});
</script>
<style type="text/css">
	.mainContaner{text-align: center;}
	.userMainInfo{display: inline-block;}
	#userInfo,#userMain{
		display: inline-block;
	}
	.userMain {
		width: 1600px;
		height: 200px;
		border: 5px solid #f2f2f2;
		border-radius:30px;
		background-color: #f2f2f2;
	}
	ul {
		list-style:none;
		padding-left:0px;
	 	}
	li {
		float: left;
		margin-right: 20px;
	}
	a { text-decoration:none !important }
	a:visited {
 		color : black;
	}
	a:hover {
		color : red;
		cursor: pointer;
	}
	a.category_item {
		color: black;
		font-size:20px;
	}
	a.category_item:hover {
		color: red;
		text-decoration: underline;
	}
	a:hover{ text-decoration:underline; color:#FF0000 }
	.container:hover {
	    background: silver;
	    border-radius: 50%;
	    border-bottom: 20px solid slateblue;
	    cursor: pointer;
	}
	.abc{
	 	display: inline-block;
	 	margin-left: 165px;
	}
	td{font-size:18px;} table{border:none;}
	  
	.userComment{
  		float:right;
	}
	.mypage{
		font-size:30px;
		margin-left:-1460px;
	}
	.list_category{
		margin-left:-825px;
	}
	
</style>
<title>마이페이지</title>
</head>
<body>
<%@ include file="../common/navBar.jsp"%>
<div class="mainContaner">
	<div class="userMainInfo">
	<h1 class="mypage">마이페이지</h1>
		<div id="userInfo">
			<div id="userMain" class="userMain">
				<table>
					<tr>
						<td>
							${mypage.uv.nik_name}
						</td>
						<td>
							<span>소개</span>
						</td>
						<td></td>
					</tr>
					<tr>
						<td rowspan="4">
							<c:if test="${!empty mypage.uv.selfi}">
								<img src="/foody/upload/${mypage.uv.selfi}" style="width: 175px;height: 175px;border-radius:50%;">
							</c:if>
							<c:if test="${empty mypage.uv.selfi}">
								<img src="/foody/img/basic_profile.png" style="width: 175px;height: 175px;border-radius:50%;">
							</c:if>
						</td>
						<td rowspan="2">
							${mypage.uv.intro}
						</td>
						<td class="userComment">
							등록한 레시피 : ${mypage.userRecipeCount}
						</td>
					</tr>
					<tr>
						<td class="userComment">
							즐겨찾기된 나의 레시피 : ${mypage.userBookmarkCount}
						</td>
					</tr>
					<tr>
						<td rowspan="2">
							email : ${mypage.uv.email}
						</td>
						<td class="userComment">
							받은 조회수 : <c:if test="${empty mypage.userTotalViewCount}">0</c:if>${mypage.userTotalViewCount}
						</td>
					</tr>
					<tr>
						<td class="userComment">
							받은 댓글수 : <c:if test="${empty mypage.userCommentCount}">0</c:if>${mypage.userCommentCount}
						</td>
					</tr>
				</table>
			</div>
			<div id="container">
				<div id="category_wrap">
					<div id="mypage_category">
						<div class="abc">
							<ul id="mypage_category_list" class="list_category">
								<li><a id="myRecipe" class="category_item">나의 레시피</a></li>
								<li><a id="recentRecipe" class="category_item">최근 본 레시피</a></li>
								<li><a id="likeRecipe" class="category_item">즐겨찾기 레시피</a></li>
								<li><a id="myInfo" class="category_item">회원정보 관리</a></li>
							</ul>
						</div>
						<div id="contents"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>