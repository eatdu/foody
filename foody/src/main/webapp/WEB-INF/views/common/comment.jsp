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
               	<td>${comment.totalCount - status.index - (commentVO.page - 1) * commentVO.pageRow}</td>
               	<td class="txt_l" style="text-align:left">
               		<!-- 답변 들여쓰기 -->
	               	<c:forEach begin="1" end="${list.depth}">&nbsp;&nbsp;&nbsp;</c:forEach>
	               	<c:if test="${list.depth > 0}"><img src="/foody/img/answer_icon.gif"></c:if>
	                ${list.content}</a>
               		<td style="text-align: right; width:100px;">
               		<c:if test="${loginInfo.no == list.user_no}">
	               		<a href="javascript:commentDel(${list.no});">[삭제]</a></c:if>
	               		<a href="javascript:addBox(${list.no});">[답글달기]</a>
	               	</td>
               	</td>
               	<td class="writer" style="text-align:center;">
                   ${list.user_name}
               	</td>
               	<td class="date" style="width:150px;">
               	<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${list.regdate}" />
               	</td>
            </tr>
            <tr class="add_reCmt${list.no}" style="display:none; width:100%;">
                <td colspan="5">
	            <form id="frm${list.no}" method="post" enctype="multipart/form-data">
	            		<input type="hidden" name="gno" value="${list.gno}">
	                	<input type="hidden" name="ono" value="${list.ono}">
	                	<input type="hidden" name="depth" value="${list.depth}">
	                    <textarea name="content" id="content" placeholder="댓글을 입력해 주세요."
	                    onfocus="this.placeholder=''" onblur="this.placeholder='댓글을 입력해 주세요.'"
	                    style="height:50px; width:100%;"></textarea>
	                    <div class="btnSet" style="text-align:right;">
	                    	<a class="btn" href="javascript:insert_reCmt(${list.no});">저장 </a>
	                    </div>
	             </form>
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
                <li><a href='javascript:getComment(${num})'>
                <c:if test='javascript:getComment(${commentVO.page == num})'>class='current'</c:if>${num}</a></li>
            </c:forEach>
            <c:if test="${data.next == true}">
           		<li><a href="javascript:getComment(${comment.endPage+1})">next</a>
           	</c:if>
        	</ul>
        </div>