<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${!empty result.list1Name}">
	--- ${result.list1Name} ---<br>
	<c:forEach var="l1" items="${result.list1}" varStatus="idx">
	no: ${l1.no}<br>
	name: ${l1.name}<br>
	intro: ${l1.intro}<br>
	type: ${l1.type}<br>
	time: ${l1.time}<br>
	</c:forEach>
</c:if>
<c:if test="${!empty result.list2Name}">
	--- ${result.list2Name} ---<br>
	<c:forEach var="l2" items="${result.list2}" varStatus="idx">
	no: ${l2.no}<br>
	name: ${l2.name}<br>
	intro: ${l2.intro}<br>
	type: ${l2.type}<br>
	time: ${l2.time}<br>
	</c:forEach>
</c:if>
<c:if test="${!empty result.list3Name}">
	--- ${result.list3Name} ---<br>
	<c:forEach var="l3" items="${result.list3}" varStatus="idx">
	no: ${l3.no}<br>
	name: ${l3.name}<br>
	intro: ${l3.intro}<br>
	type: ${l3.type}<br>
	time: ${l3.time}<br>
	</c:forEach>
</c:if>
<c:if test="${!empty result.list4Name}">
	--- ${result.list4Name} ---<br>
	<c:forEach var="l4" items="${result.list4}" varStatus="idx">
	no: ${l4.no}<br>
	name: ${l4.name}<br>
	intro: ${l4.intro}<br>
	type: ${l4.type}<br>
	time: ${l4.time}<br>
	</c:forEach>
</c:if>