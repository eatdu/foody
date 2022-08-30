<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>password input modal</title>
<style>
#modal{
	display : none;
	z-index : 1;
	background-color: rgba(0,0,0,.3);
	position:fixed;
	left:0;
	top: 0;
	width:100%;
	height:100%;
	
}
#modal>#content{
	width:300px;
	margin:100px auto;
	padding:20px;
	position: relative;
	background-color:#fff;
}

#modal .close{
	position:absolute;
	top:4px;
	right:4px;	
	font-size:20px;
	border:0;
	background-color: #fff;
}

#modal .close:hover,
#modal .close:focus {
  color : #000;
  text-decoration: none;
  cursor :pointer;
}
</style>
</head>
<body>
<label>암호를 입력하려면 버튼을 클릭해 주세요.</label>
<input type='button' value='open' id='btnOpen'>

<div id='modal'>
	<div id='content'>
		<input type='button' value='X' class="close" id='btnClose'/>
		<label>암호를 입력하세요</label><br/>
		<input type='password' id='pwd' value='1234' />
		<input type='button' value='check' id='btnCheck' />
	</div>
</div>
<script>
var btnOpen  = document.getElementById('btnOpen');
var btnCheck = document.getElementById('btnCheck');
var btnClose = document.getElementById('btnClose');

// modal 창을 감춤
var closeRtn = function(){
	var modal = document.getElementById('modal');
	modal.style.display = 'none';
	
}

// modal 창을 보여줌
btnOpen.onclick = function(){
	var modal = document.getElementById('modal');
	modal.style.display = 'block';
	
}

btnCheck.onclick = closeRtn;
btnClose.onclick = closeRtn;


</script>
</body>
</html>