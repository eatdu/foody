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
</script>
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"
/>
<!-- Demo styles -->
<style>
	.swiper {
		width: 100%;
		height: 300px;
	}
	
	.swiper-slide {
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
	
	.swiper-slide img {
		display: block;
		width: 100%;
		height: 100%;
		object-fit: cover;
	}
	.rcpTable {
		float: left;
		width: 250px;
		height: 270px;
		border: 1px solid black;
	}
	.rcpTable .imgCell {
		height: 150px;
	}
	.rcpTable .introCell{
		height: 40px;
	}
	.rcpTable .nameCell{
		width: 125px;
		height: 40px;
	}
	.rcpTable .timeCell{
		width: 125px;
		height: 40px;
	}
	.row {
		display: inline-block;
	}
	.title {
		font-size: 100px;
	}
	.titlesm {
		font-size: 30px;
	}
</style>
<title>메인 화면</title>
</head>
<body>
<%@ include file="../common/navBar.jsp" %>
<div>
preferNo: ${preferNo}<br>
allergy: ${allergyNo}<br>
하루권장섭취 칼로리 : ${cal}kcal
</div>
<h1 class='title tc'>Foody</h1>
<select id="type" name="type">
<option value="0" selected>==검색조건==</option>
</select>
<input type="text" id="keyword" placeholder="검색어 입력">
<button type="button">검색</button>
<!-- 인기 레시피 / 스와이퍼 -->
<div class="container" id="bestRcpArea">
</div>
<!-- 추천 레시피 / 스와이퍼 -->
<div class="container" id="preferRcpArea">
</div>
</body>
</html>