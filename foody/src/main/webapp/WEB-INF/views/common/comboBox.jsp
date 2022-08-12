<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<option value="">==재료명==</option>
	<c:forEach var="result" items="${list}" varStatus="idx">
	<option value="${result.value}">${result.text}</option>
	</c:forEach>
