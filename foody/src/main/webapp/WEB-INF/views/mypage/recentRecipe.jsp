<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	#container{text-align: center;}
	#myRecipe{display: inline-block;}
	a.btn{
	    display:block;
	    width:80px;
	    line-height:30px;
	    text-align:center;
	    background-color:#f7f7f7;
	    color:#000000;
	}
	li{
		display:inline-block;
	}
	.abc{
	 	display: inline-block;
	}
	.paging{
		margin-left:750px;
		padding: 0 0 50px 0;
	}
	.recipeContaniner{
	    width: 300px;
  		height: 250px;
  		background-color: #faf4c0;
	}
	.myRecipeList_li{
		width:300px;height:380px;
		background-color:#faf4c0;
		margin-bottom:30px;
		border-radius:10px;
		position: relative;
	}
	.myRecipeName{
		text-align:center;
	}
	.myRecipeThumb_img{
		width:260px;height:250px;
		border-radius:10px;
	}
	.feedback{float:right;}.recipeBookmark{margin-top:5px;}
	.recipeIntro{margin-left:20px;}
	.modify{
		position: absolute;
	    bottom: 0px;
	    margin-left: 110px;
	}
</style>
<title>최근 본 레시피</title>
</head>
<body>
<div id="container">
	<div id="myRecipe">
		<div id="reicpeView">
			<div class="abc">
				<ul class="myRecipeList_ul">
					<c:forEach var="recipe" items="${recentRecipe.recentList}">
						<li class="myRecipeList_li">
							<div class="myRecipeName">${recipe.name}</div>
							<div class="myRecipeThumb">
								<a href="/foody/recipe/view.do?no=${recipe.no}" class="recipeLink">
									<img class="myRecipeThumb_img" src="${recipe.thumbnail}">
								</a>
							</div>
							<div class="feedback">
									<span class="recipeBookmark"><img src="/foody/img/heart.png" style="width:25px;height:25px;">${recipe.bookmark}</span>
									<span class="recipeComment"><img src="/foody/img/comment.png" style="width:15px;height:15px;margin:5px;">${recipe.comment_count}</span>
							</div>
							<div class="recipeInfo">
								<div class="recipeIntro">${recipe.intro}</div>
								<div class="recipeTime">${recipe.time}분<span style="float:right;"><fmt:formatDate value="${recipe.regdate}" pattern="yyyy-MM-dd hh:mm"/></span></div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
			<!-- 페이지 처리 -->
	        <div class="pagenate clear">
	            <ul class='paging'>
	            <!-- prev 버튼 있는 경우 -->
	            <c:if test="${mypageVO.prev == true}">
	           		<!-- prev 버튼 클릭시 -->
	           		<li><a href="javascript:getRecentRecipe(${mypageVO.startPage-1})">prev</a>
	           	</c:if>
	            <c:forEach var="num" begin="${mypageVO.startPage}" end="${mypageVO.endPage}">
	                <li><a href='javascript:getRecentRecipe(${num})'>
	                <c:if test='javascript:getRecentRecipe(${empty mypageVO.page})'>class='current'</c:if>
	                <c:if test='javascript:getRecentRecipe(${mypageVO.page == num})'>class='current'</c:if>${num}</a></li>
	            </c:forEach>
	            <c:if test="${mypageVO.next == true}">
	           		<li><a href="javascript:getRecentRecipe(${mypageVO.endPage+1})">next</a>
	           	</c:if>
	        	</ul>
	        </div>
		</div>
	</div>
</div>
</body>
</html>