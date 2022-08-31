<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/config.jsp" %>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo:wght@700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" /></head>
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" /></head>

<style>

  .header {
	width: 100%;
	height: 157px;
	background: rgba(249,235,200,1);
	opacity: 1;
	position: relative;
	top: 0px;
	left: 0px;
	overflow: hidden;
  }
  
  .bodycontainer{
  	width:100%;
  	height:2000px;
  	float:left;
  }
  
   .content{
  	width:80%;
  	height:100%;
  	float:left;
  	
  }
  
  .bin-left{
  	width:10%;
  	height:100%;
    float:left;
  }
  
 .bin-right{
  	width:10%;
  	height:100%;
  	float:right;
  }
  
  .content_header{
  	width:100%;
  	height:7%;
  	font-size:35px;
  	color: #8C9D7C;
  }
  .bin-top{
  	width:80%;
  	height:50%;
  }
  .contents{
  	width:100%;
  	height:93%;
  	background-color: #DAE5D0;
  	border-radius :50px;
  }
  .headerImg{
  	width:50px;
  	height:50px;
  	float:left;
  }

</style>


</head>
<body>
	<div class="header"></div>
	<div class="bodycontainer" style="float:left;">
		<div class="bin-left"></div>
		<div class="content">
			<div class="content_header">
				<div class="bin-top"></div>
				<img scr="../resources/Register.png" class="headerImg">
				새 레시피 등록
			</div>
			<div class="contents">
			</div>
		</div>
		<div class="bin-right"></div>
	</div>
</body>
</html>