<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="bbs">
<div id="blist">
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
		<tr onclick="javascript:openModal();" style="cursor:pointer">
			<td>${res.title}</td>
			<td>${res.nikname}</td>
			<td>${res.type}</td>
			<td>${res.regdate}</td>
			<td>
			<c:if test="${res.adminchk == 0}">미확인</c:if>
			<c:if test="${res.adminchk == 1}">확인</c:if>
			</td>
			<td>${res.print}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</div>
</div>

