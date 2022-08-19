<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class='container'>
	<h1 class='titlesm tc'>--- ${result.title} ---</h4>
	<div class='row' width=1000px>	
	<c:forEach var="l1" items="${result.list}" varStatus="idx">
		<table class="rcpTable" style='table-layout:fixed'>
			<tr>
				<td class="imgCell" colspan='2'>
				<div height=150px style='max-height:150px; align-items:center; overflow:hidden; display: flex; justify-content:center;'>
				<img class="" width='100%' src="${l1.thumbnail}">
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
		<a href="javascript:searchBtn(${pageNo - 1});">앞으로</a>
	</c:if>
	<c:if test="${pageNo eq result.curNo}">
		<strong href="javascript:searchBtn(${pageNo});">${pageNo}</strong>
	</c:if>
	<c:if test="${pageNo != result.curNo}">
		<a href="javascript:searchBtn(${pageNo});">${pageNo}</a>
	</c:if>
	<c:if test="${result.next eq true && idx.last}">
		<a href="javascript:searchBtn(${pageNo + 1});">다음으로</a>
	</c:if>
	</c:forEach>
</div>
</div>
