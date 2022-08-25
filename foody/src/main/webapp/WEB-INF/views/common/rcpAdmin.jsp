<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="bbs">
<div id="blist">
${count}
<table>
	<thead>
		<th>작성글 제목</th>
		<th>작성자</th>
		<th>대분류</th>
		<th>작성일</th>
		<th>확인여부</th>
		<th>삭제여부</th>
	</thead>
	<tbody>
		<c:forEach var="res" items="${result}">
		<tr id="${res.no}" onclick="javascript:rcpDetailAdmin(${res.no});" style="cursor:pointer">
			<td>${res.title}</td>
			<td>${res.nikname}</td>
			<td>${res.type}</td>
			<td>${res.regdate}</td>
			<td id="adminChk">
			<c:if test="${res.adminchk == 0}"><strong class="colR01">미확인</strong></c:if>
			<c:if test="${res.adminchk == 1}"><strong class="colG01">확인</strong></c:if>
			</td>
			<td>
			<c:if test="${res.print == 0}"><strong class="colBl001">X</strong></c:if>
			<c:if test="${res.print == 1}"><strong class="colR01">O</strong></c:if>
			</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</div>
</div>
<div class='page'>
	<c:forEach items="${paging}" var='pageNo' varStatus='idx'>
	<c:if test="${prev eq true && idx.first}">
		<a href="javascript:searchRcp(${pageNo - 1});">앞으로</a>
	</c:if>
	<c:if test="${pageNo eq curNo}">
		<strong>${pageNo}</strong>
	</c:if>
	<c:if test="${pageNo != curNo}">
		<a href="javascript:searchRcp(${pageNo});">${pageNo}</a>
	</c:if>
	<c:if test="${next eq true && idx.last}">
		<a href="javascript:searchRcp(${pageNo + 1});">다음으로</a>
	</c:if>
	</c:forEach>
</div>

