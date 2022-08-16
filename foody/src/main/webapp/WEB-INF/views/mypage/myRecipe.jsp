<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
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
</style>
<title>Insert title here</title>
</head>
<body>
<h2>나의 레시피</h2>
<div id="container">
	<div id="myRecipe">
		<div id="reicpeView">
			<div><a href="/mypage.do" class="btn">새로운 레시피</a></div>
			<ul class="myRecipeList_ul">
				<c:forEach var="recipe" items="${myRecipe.list}">
					<li class="myRecipeList_li" style="width:300px;height:400px;">
						<div class="myRecipeName" style="text-align:center;">${recipe.name}</div>
						<div class="myRecipeThumb">
							<a href="" class="recipeLink">
								<img class="myRecipeThumb_img" style="width:300px;height:250px;" src="${recipe.thumbnail}">
							</a>
						</div>
						<div class="feedback" style="float:right;">
								<span class="recipeBookmark" style="margin-top:5px;"><img src="/foody/img/heart.png" style="width:25px;height:25px;">${recipe.bookmark}</span>
								<span class="recipeComment"><img src="/foody/img/comment.png" style="width:15px;height:15px;margin:5px;"></span>
						</div>
						<div class="recipeInfo">
							<div class="recipeIntro" style="width:290px;">${recipe.intro}</div>
							<div class="recipeTime">${recipe.time}분</div>
						</div>
						<div class="modify" style="text-align:center;">
							<span class="recipeModify" style="font-size:20px;"><a href="">수정</a></span>
							<span class="recipeDelete" style="font-size:20px;"><a href="">삭제</a></span>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>
</body>
</html>