<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<title>즐겨찾기 레시피</title>
</head>
<body>
<h2>즐겨찾기 레시피</h2>
<div id="container">
	<div id="myRecipe">
		<div id="reicpeView">
			<ul class="myRecipeList_ul">
				<c:forEach var="recipe" items="${likeRecipe.likeList}">
					<li class="myRecipeList_li" style="width:300px;height:400px;">
						<div class="myRecipeName" style="text-align:center;">${recipe.name}</div>
						<div class="myRecipeThumb">
							<a href="/foody/recipe/view.do?no=${recipe.no}" class="recipeLink">
								<img class="myRecipeThumb_img" style="width:300px;height:250px;" src="${recipe.thumbnail}">
							</a>
						</div>
						<div class="feedback" style="float:right;">
								<span class="recipeBookmark" style="margin-top:5px;"><img src="/foody/img/heart.png" style="width:25px;height:25px;">${recipe.bookmark}</span>
								<span class="recipeComment"><img src="/foody/img/comment.png" style="width:15px;height:15px;margin:5px;">${recipe.comment_count}</span>
						</div>
						<div class="recipeInfo">
							<div class="recipeIntro" style="width:290px;">${recipe.intro}</div>
							<div class="recipeTime">${recipe.time}분</div>
							
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>
</div>
</body>
</html>