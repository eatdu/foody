<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class='title' style='float: left;'><h1 style="font-size:25px;"> ${result.title2} 로 검색한 레시피는 총 ${result.count} 개가 있습니다.</div>
	<div class="orderBy" style='float: right;'>
		<select id='orderBy' onchange="movePage('${result.title}', ${result.curNo}, ${result.areaNo});">
			<option value="regdate"<c:if test="${result.orderBy eq 'regdate'}"> selected</c:if>>최신순</option>
			<option value="star"<c:if test="${result.orderBy eq 'star'}"> selected</c:if>>별점순</option>
			<option value="viewcount"<c:if test="${result.orderBy eq 'viewcount'}"> selected</c:if>>조회순</option>
			<option value="reply"<c:if test="${result.orderBy eq 'reply'}"> selected</c:if>>댓글순</option>
		</select>
	</div>
	</h4>
	<input type='hidden' id='title' value='${result.title}'>
	<div class='row'>	
	<c:forEach var="l1" items="${result.list}" varStatus="idx">
		<div class='rcpCard'>
		<table class="rcpTable" style='table-layout:fixed'>
			<tr>
				<td class="imgCell" colspan='2'>
				<div height=150px style='border-radius: 15px; position: relative; max-height:150px; align-items:center; overflow:hidden; display: flex; justify-content:center;'>
					<img class="" width='100%' src="${l1.thumbnail}">
					<div style='position: absolute; right: 5px; bottom: 5px; font-weight:bold; color: black; background-color: grey;;'>
						<img class="" width='20px' src="/foody/img/heart.png">
						${l1.bookmark} 
						<img class="" width='20px' src="/foody/img/star.png">
						${l1.star}
					</div>
				</div>
				</td>
			</tr>
			<tr>
				<td class="introCell" colspan='2'><span class="">${l1.intro}</span></td>
			</tr>
			<tr class="">
				<td><span class="nameCell">${l1.name}</span></td>
				<td><span class="timeCell">${l1.time}분</span></td>
			</tr>
			<tr><td colspan='2'>--출력 필요 X / no: ${l1.no} / type: ${l1.type}--</td></tr>
		</table>
		</div>
		<c:if test="${idx.count % 4 == 0 && !idx.last}">
	</div>
	<div class='row'>
		</c:if>
	</c:forEach>
	</div>
</div>
<div id='bbs'>
<div class='page'>
	<c:forEach items="${result.paging}" var='pageNo' varStatus='idx'>
	<c:if test="${result.prev eq true && idx.first}">
		<a href="javascript:movePage('${result.title}', ${pageNo - 1}, ${result.areaNo});">앞으로</a>
	</c:if>
	<c:if test="${pageNo eq result.curNo}">
		<strong href="javascript:movePage('${result.title}', ${pageNo}, ${result.areaNo});">${pageNo}</strong>
	</c:if>
	<c:if test="${pageNo != result.curNo}">
		<a href="javascript:movePage('${result.title}', ${pageNo}, ${result.areaNo});">${pageNo}</a>
	</c:if>
	<c:if test="${result.next eq true && idx.last}">
		<a href="javascript:movePage('${result.title}', ${pageNo + 1}, ${result.areaNo});">다음으로</a>
	</c:if>
	</c:forEach>
</div>

