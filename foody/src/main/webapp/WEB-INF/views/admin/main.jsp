<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../common/config.jsp" %>
<script type="text/javascript" src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
<script>
$(function(){
	//Better to construct options first and then pass it as a parameter
	var options = {
		title: {
			text: "월별 가입자 통계"              
		},
		data: [              
		{
			// Change type to "doughnut", "line", "splineArea", etc.
			type: "line",
			dataPoints: [
				{ label: '${cntUser.withM[4].month}',  y: ${cntUser.withM[4].cnt}  },
				{ label: '${cntUser.withM[3].month}', y: ${cntUser.withM[3].cnt}  },
				{ label: '${cntUser.withM[2].month}', y: ${cntUser.withM[2].cnt}  },
				{ label: '${cntUser.withM[1].month}',  y: ${cntUser.withM[1].cnt}  },
				{ label: '${cntUser.withM[0].month}',  y: ${cntUser.withM[0].cnt}  }
			]
		}
		]
	};

	$("#chartContainer").CanvasJSChart(options);
});

</script>
<style>
html{height: 100%;}
body{
	height: 100%;
	max-height: 100%;
	min-height: 100%;
	overflow: hidden;
}

#dashBoard {
    min-width: 1200px;
    margin: auto;
    min-height: 640px;
    height: 90%;
    width: 94%;
    justify-content: center;
}
#dashBoard .container {
    min-height: 300px;
    height: 42%;
    min-width: 500px;
    width: 44%;
    background-color: #FAF4C0;
    margin: 2%;
    float: left;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}
#dashBoard .container h2{
	font-size: 26px;
}
#dashBoard .container a{
    font-size: 20px;
}
#chartContainer {
	height: 60%;
	width: 60%;
}
</style>
<link rel="stylesheet" type="text/css" href="/foody/resources/css/leftMenu.css">
<title>메인 페이지</title>
</head>
<body>
<%@ include file="../admin/leftMenu.jsp" %>
<div class="adminContainer">
	<div class="title"><h1>메인 페이지</h1></div>
	<div id="dashBoard">
		<div class="container" id='userReport'>
			<h2>가입자현황</h2>
			<br><a>총 가입자 수: ${cntUser.all} 명</a><br>
			<div id="chartContainer"></div>
		</div>
		<div class="container" id='rcpReport'>
			<h2>레시피현황</h2>
			<br><a href="recipe.do?mode=0">총 레시피 수: ${cntRcp.all}</a><br>
			<br><a href="recipe.do?mode=1">최근 7일간 등록된 레시피: ${cntRcp.weekAll}</a><br>
			<br><a href="recipe.do?mode=2">기확인된 레시피 건수: ${cntRcp.checked}</a><br>
			<br><a href="recipe.do?mode=3">미확인 레시피 건수: ${cntRcp.notChecked}</a>
		</div>
		<div class="container" id='replyReport'>
			<h2>댓글현황</h2>
			<br><a href="comment.do?period=all&align=recent">총 댓글 수: ${cntCom.all}</a><br>
			<br><a href="comment.do?period=1+month&align=recent&stype=content">최근 1개월간 등록된 댓글 수: ${cntCom.month}</a><br>
			<br><a href="comment.do?period=1+week&align=recent&stype=content">최근 7일간 등록된 댓글 수: ${cntCom.week}</a><br>
			<br><a href="comment.do?period=1+day&align=recent&stype=content">오늘 새로 등록된 댓글 수: ${cntCom.day}</a>
		</div>
		<div class="container" id='qnaReport'>
	
		</div>
	</div>
</div>
</body>
</html>