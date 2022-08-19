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
			type: "column",
			dataPoints: [
				{ label: '${countUserWithPeriod[4].month}',  y: ${countUserWithPeriod[4].cnt}  },
				{ label: '${countUserWithPeriod[3].month}', y: ${countUserWithPeriod[3].cnt}  },
				{ label: '${countUserWithPeriod[2].month}', y: ${countUserWithPeriod[2].cnt}  },
				{ label: '${countUserWithPeriod[1].month}',  y: ${countUserWithPeriod[1].cnt}  },
				{ label: '${countUserWithPeriod[0].month}',  y: ${countUserWithPeriod[0].cnt}  }
			]
		}
		]
	};

	$("#chartContainer").CanvasJSChart(options);
})
</script>
<style>
#dashBoard {
	width: 1040px;
	display: inline-block;
}

#dashBoard .container {
	height: 300px;
	width: 500px;
	background-color: #FAF4C0;
	margin: 10px 10px 10px 10px;
	float: left;
}
#chartContainer {
	height: 250px;
	width: 400px;
}
</style>
<title>메인 페이지</title>
</head>
<body>
<h1>메인 페이지</h1>
<div id="dashBoard">
	<div class="container" id='userReport'>
		<h2>가입자현황</h2>
		총 가입자 수: ${countAllUser} 명<br>
		<div id="chartContainer"></div>
	</div>
	<div class="container" id='rcpReport'>
		<h2>레시피현황</h2>
		총 레시피 수: <br>
		최근 7일간 등록된 레시피: <br>
		기확인된 레시피 건수: <br>
		미확인 레시피 건수: 
	</div>
	<div class="container" id='replyReport'>
		<h2>댓글현황</h2>
		총 댓글 수: <br>
		최근 7일간 등록된 댓글 수: <br>
		신고된 댓글 건수: <br>
		신고 처리가 완료된 댓글 건수: <br>
		신고 처리가 필요한 댓글 건수: <br>
	</div>
	<div class="container" id='qnaReport'>
		<h2>qna현황</h2>
		등록된 질문 수: <br>
		자주 하는 질문: <br>
		답변이 필요한 질문: <br>
		답변이 완료된 질문:
	</div>
</div>
</body>
</html>