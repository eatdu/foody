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
<script>
/* function del(no){
	if (confirm("삭제하시겠습니까?")){
		$.ajax({
			url : '/foody/mypage/delete.do?no=',
			success : function(res){
				if(res.trim() == '1'){
					alert("삭제완료")
				}	    					
			}
		})
	}
} */
</script>
<title>나의 레시피</title>
</head>
<body>
<h2>나의 레시피</h2>
<div id="container">
	<div id="myRecipe">
		<div id="reicpeView">
			<div><a href="/foody/write.do" class="btn">새로운 레시피</a></div>
			<ul class="myRecipeList_ul">
				<c:forEach var="recipe" items="${myRecipe.myList}">
					<li class="myRecipeList_li" style="width:300px;height:400px;">
						<div class="myRecipeName" style="text-align:center;">${recipe.name}</div>
						<div class="myRecipeThumb">
							<a href="/foody/recipe/view.do?no=${recipe.no}" class="recipeLink">
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
							<span class="recipeDelete" style="font-size:20px;"><a href="/foody/mypage/delete.do?no=${recipe.no}">삭제</a></span>
						</div>
					</li>
				</c:forEach>
			</ul>
			
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