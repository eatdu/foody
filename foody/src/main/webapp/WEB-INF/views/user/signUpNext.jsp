<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type='text/javascript'>
	var img_L = 10;
	var img_T = 20;
	var targetObj;
	
	function getLeft(o){
		return parseInt(o.style.left.replace('px', ''));
	}
	function getTop(o){
		return parseInt(o.style.top.replace('px', ''));
	}
	function moveDrag(e){
		var e_obj = window.event? window.event : e;
		var dmvx = parseInt(e_obj.clientX + img_L);
		var dmvy = parseInt(e_obj.clientY + img_T);
		targetObj.style.left = dmvx +"px";
		targetObj.style.top = dmvy +"px";
		return false;
	}
	function startDrag(e, obj){
		targetObj = obj;
		var e_obj = window.event? window.event : e;
		img_L = getLeft(obj) - e_obj.clientX;
		img_T = getTop(obj) - e_obj.clientY;
		
		document.onmousemove = moveDrag;
		document.onmouseup = stopDrag;
		if(e_obj.preventDefault)e_obj.preventDefault();
	}
	function stopDrag(){
		document.onmousemove = null;
		document.onmouseup = null;
	}
</script>
<img src="/recipe/img/이재훈.png" style="position:absolute; left:0px; top:50px; cursor:pointer; cursor:hand; border:0" onmousedown="startDrag(event, this)">
