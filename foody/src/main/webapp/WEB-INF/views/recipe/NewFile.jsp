<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/config.jsp" %>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo:wght@700&display=swap" rel="stylesheet">
<title>Insert title here</title>
<style>
	body{
		width:100%;
		height:500px;
		font-size:3.5em;
		text-align :center;
		font-family: 'Nanum Myeongjo', serif;
		background-color:#FFFFFF;
	}
	
	.header{
		width:100%;
		height:20%;
		background-color:#F9EBC8;
	}
	
	.body{
		display:flex;
		height:80%;
	}
	.content{
		width:90%;
		margin-top:100px;
	}
	.content-header{
		width:100%;
		height:10%;
		margin-bottom: 30px;
		text-align:left;
		font-size:25px;
		
	}
	
	.content-body{
		width:100%;
		height:80%;
		display: flex;
		border-radius:40px;
		margin-top:50px;
		background-color: #F1F1F2;
	}
	
	.leftSideBar, .rightSideBar{
		width: 10%;
		background-color:#FFFFFF;
	}
	.footer{
		width: 100%;
		height: 20%;
		background-color: #F8CBAD;
	}
	
	.contents{
		width:94%;
		height:68%;
		border-radius:40px;
		background-color: #FFFFFF;
		font-size:30px;
		margin: auto;
		padding: 20px;
	}
	
	.content-blank{
		width:100%;
		height:30%;
		border-radius:40px;
		background-color: #F1F1F2;
	}
	
	input[type=text] {
		width:60%;
		height: 40px;
		float:left;
		outline:5px;
		margin-left:20px;
		border-color:#E1E1E3; 
		border-radius:10px;
		background-color:#FFFFFF;
		font-size:20px;
	}
	
	.contents-ele{
		margin:20px;
	}
	
</style>
</head>
<body>
<%@ include file="../common/navBar.jsp"  %>
	<div class="body">
		<div class="leftSideBar"></div>
		<div class="content">
			<div class="content-header">새 레시피 등록</div>
			<hr class="content-separated" size="3px" color="#A0BCC2">
			<div class="content-body">
				<div class="contents">
					<div class="contents-ele">
					<label for="name" style="width:10%; float:left;">요리명</label>
					<input type="text" id=name name="name" ><br>
					</div>
					
					<div class="contents-ele">
					<label for="name" style="width:10%; float:left;">요리 소개</label>
					<input type="text" size="30" id=intro name="intro" ><br>
					</div>
					
				</div>
			</div>
		</div>
		<div class="rightSideBar"></div>
	</div>
<!-- 	<div class="footer">Footer영역</div> -->
</body>
</html>