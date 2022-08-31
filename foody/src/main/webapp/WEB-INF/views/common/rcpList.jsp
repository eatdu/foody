<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class='title' style='text-align: left;float: left;'>
	<h1 style="font-size:20px;">
		<a id="arrow${result.areaNo}" href="javascript:" onclick="rcpClose(${result.areaNo}, this);">▼</a>${result.title2} 레시피는 총 ${result.count} 개가 있습니다.
	</h1>
</div>
<div id="list${result.areaNo}">
	<div class="orderBy" style='float: right;'>
		<select id='orderBy' onchange="movePage('${result.title}', ${result.curNo}, ${result.areaNo}, '${sType}', '${keyword}');">
			<option value="regdate"<c:if test="${result.orderBy eq 'regdate'}"> selected</c:if>>최신순</option>
			<option value="avgstar"<c:if test="${result.orderBy eq 'avgstar'}"> selected</c:if>>별점순</option>
			<option value="viewcount"<c:if test="${result.orderBy eq 'viewcount'}"> selected</c:if>>조회순</option>
			<option value="reply"<c:if test="${result.orderBy eq 'reply'}"> selected</c:if>>댓글순</option>
		</select>
	</div>
	</h4>
	<input type='hidden' id='title' value='${result.title}'>
	<div class='row'>	
	<c:forEach var="l1" items="${result.list}" varStatus="idx">
		<a href="view.do?no=${l1.no}">
		<div class='rcpCard'>
		<table class="rcpTable" style='table-layout:fixed'>
			<tr>
				<td class="imgCell" colspan='2'>
				<div height=150px style='border-radius: 15px; position: relative; max-height:150px; align-items:center; overflow:hidden; display: flex; justify-content:center;'>
					<div class="rcpImg">
					<img class="thumbnail" width='100%' src="/foody/upload/${l1.thumbnail}" />
					</div>
					<div class="intro">${l1.intro}</div>
				</div>
				</td>
			</tr>
			<tr>
				<td colspan='2'>
				<div class="icons">
					<img class="" width='20px' src="/foody/resources/img/viewcnt.png">
					${l1.viewcount}
					<img class="" width='20px' src="/foody/resources/img/reply.png">
					${l1.reply}
					<img class="" width='20px' src="/foody/img/heart.png">
					${l1.bookmark} 
					<img class="" width='20px' src="/foody/img/star.png">
					${l1.avgStar}
				</div>
				</td>
			</tr>
			<tr>
				<td><div class="timename">${l1.name}</span></td>
				<td><div class="timename">${l1.time}분</span></td>
			</tr>
		</table>
		</div>
		</a>
		<c:if test="${idx.count % 4 == 0 && !idx.last}">
	</div>
	<div class='row'>
		</c:if>
	</c:forEach>
	</div>
	<div id='bbs'>
	<div class='page'>
		<c:forEach items="${result.paging}" var='pageNo' varStatus='idx'>
		<c:if test="${result.prev eq true && idx.first}">
			<a href="javascript:movePage('${result.title}', ${pageNo - 1}, ${result.areaNo}, '${sType}', '${keyword}');">앞으로</a>
		</c:if>
		<c:if test="${pageNo eq result.curNo}">
			<strong href="javascript:movePage('${result.title}', ${pageNo}, ${result.areaNo}, '${sType}', '${keyword}');">${pageNo}</strong>
		</c:if>
		<c:if test="${pageNo != result.curNo}">
			<a href="javascript:movePage('${result.title}', ${pageNo}, ${result.areaNo}, '${sType}', '${keyword}');">${pageNo}</a>
		</c:if>
		<c:if test="${result.next eq true && idx.last}">
			<a href="javascript:movePage('${result.title}', ${pageNo + 1}, ${result.areaNo}, '${sType}', '${keyword}');">다음으로</a>
		</c:if>
		</c:forEach>
	</div>
	</div>
</div>
<script>
$(".rcpCard").hover(function(){
	$(this).find(".intro").show();
	$(this).find(".thumbnail").css("opacity", 0.7);
})
$(".rcpCard").mouseleave(function(){
	$(this).find(".intro").hide();
	$(this).find(".thumbnail").css("opacity", 1.0);
})
$(function(){
    $('.thumbnail').each(function(idx, item){
    	var url = "/foody/resources/img/processImg.png";
    	console.log(item.complete);
    	console.log(item.src);
    	console.log(item);
    	if(item.complete == true) return; 
    	//item.src = url;
    });
});
</script>

