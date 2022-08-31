<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	*{margin:0; padding:0;}
	.pop_wrap1{position:fixed; top:0; left:0; right:0; bottom:0; background:rgba(0,0,0,.5); font-size:0; text-align:center;}
	.pop_wrap1:after{display:inline-block; height:100%; vertical-align:middle; content:'';}
	.pop_wrap2{position:fixed; top:0; left:0; right:0; bottom:0; background:rgba(0,0,0,.5); font-size:0; text-align:center;}
	.pop_wrap2:after{display:inline-block; height:100%; vertical-align:middle; content:'';}
	.pop_wrap1 .pop_inner{display:inline-block; padding:20px 30px; background:#fff; width:200px; vertical-align:middle; font-size:15px;}
	.pop_wrap2 .pop_inner{display:inline-block; padding:20px 30px; background:#fff; width:200px; vertical-align:middle; font-size:15px;}
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
<script>
	function del(no) {
		if (confirm('레시피를 삭제하시겠습니까?')) {
			location.href='/foody/mypage/delete.do?no='+no;
		}
	}
</script>
<title>나의 레시피</title>
</head>
<body>
<div id="container">
	<div id="myRecipe">
		<div id="reicpeView">
			<div class="abc">
			<div><a href="/foody/recipe/write.do" class="btn">새로운 레시피</a></div>
				<ul class="myRecipeList_ul">
					<c:forEach var="recipe" items="${myRecipe.myList}">
						<li class="myRecipeList_li">
							<div class="myRecipeName">${recipe.name}</div>
							<div class="myRecipeThumb">
								<a href="/foody/recipe/view.do?no=${recipe.no}" class="recipeLink">
									<img class="myRecipeThumb_img" src="/foody/upload/${recipe.thumbnail}">
								</a>
							</div>
							<div class="feedback">
									<span class="recipeBookmark"><img src="/foody/img/heart.png" style="width:25px;height:25px;">${recipe.bookmark}</span>
									<span class="recipeComment"><img src="/foody/img/comment.png" style="width:15px;height:15px;margin:5px;">${recipe.comment_count}</span>
							</div>
							<div></div>
							<div class="recipeInfo">
								<div class="recipeIntro" style="width:290px;">${recipe.intro}</div>
								<div class="recipeTime">${recipe.time}분</div>
							</div>
							<div class="modifyCon">
								<div class="wrap">
									<a href="/foody/recipe/modify.do?no=${recipe.no}" class="recipeModify" id="recipeModifyId">레시피수정</a>
									<a href="javascript:del(${recipe.no});" class="recipeModify" id="recipeDeleteId">레시피삭제</a>
								</div>
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
	           		<li><a href="javascript:getMyRecipe(${mypageVO.startPage-1})">prev</a>
	           	</c:if>
	            <c:forEach var="num" begin="${mypageVO.startPage}" end="${mypageVO.endPage}">
	                <li><a href='javascript:getMyRecipe(${num})'>
	                <c:if test='javascript:getMyRecipe(${mypageVO.page == num})'>class='current'</c:if>${num}</a></li>
	            </c:forEach>
	            <c:if test="${mypageVO.next == true}">
	           		<li><a href="javascript:getMyRecipe(${mypageVO.endPage+1})">next</a>
	           	</c:if>
	        	</ul>
	        </div>
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
	        
		            <!-- 검색조건/키워드 -->
	                <%-- <div class="bbsSearch">
	                    <form method="get" name="searchForm" id="searchForm" action="">
	                        <span class="srchSelect">
	                            <select id="stype" name="stype" class="dSelect" title="검색분류 선택">
	                                <option value="all">이메일+이름</option>
	                                <option value="email">이메일</option>
	                                <option value="name">이름</option>
	                                <option value="nik_name">닉네임</option>
	                            </select>
	                        </span>
	                        <span class="searchWord">
	                            <input type="text" id="sword" name="sword" value="${param.sword}" title="검색어 입력">
	                            <input type="button" id="" value="검색" title="검색">
	                        </span>
	                    </form>
	                </div> --%>
		</div>
	</div>
</div>
</body>
</html>