<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    

<p><span><strong>총 ${comment.totalCount}개</strong>  |  ${commentVO.page}/${comment.totalPage}페이지</span></p>
	<table class="list">
	    <colgroup>
	        <col width="80px" />
	        <col width="*" />
	        <col width="100px" />
	        <col width="100px" />
	    </colgroup>
	    <tbody>
		<c:if test="${empty comment.list}"> <!-- 당연히 객체가 null일 수 없고 size가 없는 경우니까 -->
            <tr>
                <td class="first" colspan="5">등록된 댓글이 없습니다.</td>
            </tr>
        </c:if>
        <c:if test="${!empty comment.list}">
		<c:forEach items="${comment.list}" var="list" varStatus="status">
            <tr>
                <!-- 총개수-인덱스-(현재페이지번호-1)*페이지당개수 -->
                <td>${list.totalCount - status.index - (commentVO.page - 1) * commentVO.pageRow}</td>
                <td class="txt_l">
                	${list.content}</td>
                <td class="writer">
                    ${list.user_name}
                </td>
                <td class="date">
                	<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${list.regdate }" />
                </td>
            </tr>
		</c:forEach>
        </c:if>
        </tbody>
 	</table>
 	
        <!-- 페이지 처리 -->
        <div class="pagenate clear">
            <ul class='paging'>
            <!-- prev 버튼 있는 경우 -->
            <c:if test="${comment.prev == true}">
           		<!-- prev 버튼 클릭시 -->
           		<li><a href="javascript:getComment(${comment.startPage-1})">prev</a>
           	</c:if>
            <c:forEach var="num" begin="${comment.startPage}" end="${comment.endPage}">
                <li><a href='index.do?page=${num}'
                <c:if test="${commentVO.page == num}">class='current'</c:if>>${num}</a></li>
            </c:forEach>
            <c:if test="${data.next == true}">
           		<li><a href="index.do?page=${comment.endPage+1}">next</a>
           	</c:if>
        	</ul>
        </div>