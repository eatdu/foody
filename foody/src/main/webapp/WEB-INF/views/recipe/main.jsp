	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../common/config.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
<script>
var rcpArr = new Array();
var ingreNameArr = new Array();
var ingreArr = new Array();
var allergyArr = new Array();

$(function(){
	searchBest();
	searchPrefer();
})

function goSearch(){
	if ($("#keyword").val().trim() == "") {
		alert("검색어를 입력해주세요.");
		return;
	}
	var url = "/foody/recipe/search.do?sType=" + $("#sType").val() + "&keyword=" + $("#keyword").val(); 
	location.href = url;
}
</script>
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"
/>
<!-- Demo styles -->
<style>
	.swiper {
		width: 1400px;
		height: 300px;
	}
	
	.swiper-slide {
		margin: auto;
		text-align: center;
		background: #fff;
		
		/* Center slide text vertically */
		display: -webkit-box;
		display: -ms-flexbox;
		display: -webkit-flex;
		display: flex;
		-webkit-box-pack: center;
		-ms-flex-pack: center;
		-webkit-justify-content: center;
		justify-content: center;
		-webkit-box-align: center;
		-ms-flex-align: center;
		-webkit-align-items: center;
		align-items: center;
	}
	
	.title {
		font-size: 100px;
	}
	.titlesm {
		font-size: 30px;
	}
	body {
		text-align: center;
	}
	#keyword {
		font-size: 16px;
	    width: 300px;
	    border-radius: 30px;
	    padding-left: 10px;
	}
</style>
<title>메인 화면</title>
</head>
<body>
<%@ include file="../common/navBar.jsp" %>
<h1 class='title tc'>Foody</h1>
<select id="sType" name="sType">
<option value="recipe">요리명</option>
<option value="ingre">재료명</option>
</select>
<input type="text" id="keyword" placeholder="검색어 입력">
<button type="button" onclick="javascript:goSearch();">검색</button>
<!-- 인기 레시피 / 스와이퍼 -->
<div class="container" id="bestRcpArea">
</div>
<!-- 추천 레시피 / 스와이퍼 -->
<div class="container" id="preferRcpArea">
</div>
</body>
</html>