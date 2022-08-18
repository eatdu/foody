<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<option value="">${head}</option>
	<c:forEach var="result" items="${list}" varStatus="idx">
	<option value="${result.value}"
		<c:if test="${result.selected eq result.value}">selected</c:if>
	>${result.text}</option>
	</c:forEach>
