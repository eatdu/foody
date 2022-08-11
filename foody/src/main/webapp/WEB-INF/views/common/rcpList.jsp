<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${!empty result.list1Name}">
	<h4>--- ${result.list1Name} ---</h4>
	<div class='row justify-content-start'>	
	<c:forEach var="l1" items="${result.list1}" varStatus="idx">
	<div class="col-3">
	<table class="table table-success" style='table-layout:fixed'>
		<tr>
			<td colspan='2' >
			<div height=200px style="max-height:150px; align-items:center; overflow:hidden; display: flex; justify-content:center;">
			<img class="img-responsive center-block" width='100%' src="${l1.thumbnail}">
			</div>
			</td>
		</tr>
		<tr>
			<td class="table-active" colspan='2'><span class="fs-6 lh-sm">${l1.intro}</span></td>
		</tr>
		<tr class="table-active">
			<td><span class="fs-6 lh-sm">${l1.name}</span></td>
			<td><span class="fs-6 lh-sm">${l1.time}분</span></td>
		</tr>
	</table>
		--출력 필요 X--<br>
		no: ${l1.no}<br>
		type: ${l1.type}<br>
	</div>
	</c:forEach>
	</div>
	<nav id='pagingArea'>
	  <ul class="pagination justify-content-center">
	    <li class="page-item">
	      <a class="page-link" href="#" aria-label="Previous">
	        <span aria-hidden="true">&laquo;</span>
	      </a>
	    </li>
	    <li class="page-item"><a class="page-link" href="javascript:search(1);">1</a></li>
	    <li class="page-item"><a class="page-link" href="javascript:search(2);">2</a></li>
	    <li class="page-item"><a class="page-link" href="javascript:search(3);">3</a></li>
	    <li class="page-item">
	      <a class="page-link" href="#" aria-label="Next">
	        <span aria-hidden="true">&raquo;</span>
	      </a>
	    </li>
	  </ul>
	</nav>
	
</c:if>
<c:if test="${!empty result.list2Name}">
	<h4>--- ${result.list2Name} ---</h4>
	<div class='row justify-content-start'>
	<c:forEach var="l2" items="${result.list2}" varStatus="idx">
	<div class="col-3">
		no: ${l2.no}<br>
		name: ${l2.name}<br>
		intro: ${l2.intro}<br>
		type: ${l2.type}<br>
		time: ${l2.time}<br>
	</div>
	</c:forEach>
	</div>
</c:if>
<c:if test="${!empty result.list3Name}">
	<h4>--- ${result.list3Name} ---</h4>
	<div class='row justify-content-start'>
	<c:forEach var="l3" items="${result.list3}" varStatus="idx">
	<div class="col-3">
		no: ${l3.no}<br>
		name: ${l3.name}<br>
		intro: ${l3.intro}<br>
		type: ${l3.type}<br>
		time: ${l3.time}<br>
	</div>
	</c:forEach>
	</div>
</c:if>
<c:if test="${!empty result.list4Name}">
	<h4>--- ${result.list4Name} ---</h4>
	<div class='row justify-content-start'>	
	<c:forEach var="l4" items="${result.list4}" varStatus="idx">
	<div class="col-3">
		no: ${l4.no}<br>
		name: ${l4.name}<br>
		intro: ${l4.intro}<br>
		type: ${l4.type}<br>
		time: ${l4.time}<br>
	</div>
	</c:forEach>
	</div>
</c:if>