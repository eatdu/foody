<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/config.jsp" %>
<style type="text/css">

	.userMain {
		width: 1200px;
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
	a.category_item {color: black;}
	.container:hover {
    background: silver;
    border-radius: 50%;
    border-bottom: 20px solid slateblue;
    cursor: pointer;
  }
  .abc{
  display: inline-block;
  }
</style>
<script>
$(function(){
	$(".category_item").on("click", function(){
		var id = $(this).attr("id");
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
<title>마이페이지</title>
</head>
<body>
<%@ include file="../common/navBar.jsp" %>
<h1>마이페이지</h1>
<div id="userInfo">
	<div id="userMain" class="userMain">
		<table border="1" >
			<tr>
				<td>
					${loginInfo.nik_name}
				</td>
				<td>
					<span>소개</span>
				</td>
			</tr>
			<tr>
				<td rowspan="3">
					<img src="/foody/upload/${loginInfo.selfi}" style="width:100px; height:100px; border-radius:50%;">
				</td>
				<td>
					${loginInfo.intro}
				</td>
				
			</tr>
			<tr>
				<td>
					email : ${loginInfo.email}
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
</body>
</html>