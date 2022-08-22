<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../common/config.jsp" %>

<head>
<link rel="stylesheet" href="/foody/css/reset.css"/>
<link rel="stylesheet" href="/foody/css/contents.css"/>
<link rel="stylesheet" type="text/css" href="/foody/resources/css/leftMenu.css">
<title>관리자 QnA 페이지</title>
</head>

<body>
<%@ include file="../admin/leftMenu.jsp" %>
<div class="adminContainer">
	<div class="qna_list">
            <div class="size">
                <div class="bbs">
                    <table class="list">
                    <p><span><strong>총 ${data.totalCount}개</strong>  |  ${qnaVO.page}/${data.totalPage}페이지</span></p>
                    <!-- boardVO.page 대신 param.page도 가능하지만 1페이지일 때 안 나옴 -->
                        <caption><strong></strong></caption>
                        <colgroup>
                            <col width="80px" />
                            <col width="200px" />
                            <col width="*px" />
                            <col width="100px" />
                            <col width="100px" />
                        </colgroup>
                        <thead>
                            <tr>
                            	<th>번호</th>
                                <th>작성일</th>
                                <th>질문내용</th>
                                <th>작성자</th>
                                <th>답변여부</th>
                            </tr>
                            
                        </thead>
                        <tbody>
						<c:if test="${empty data.list}"> <!-- 당연히 객체가 null일 수 없고 size가 없는 경우니까 -->
                            <tr>
                                <td class="first" colspan="5">등록된 글이 없습니다.</td>
                            </tr>
                        </c:if>
						<c:forEach items="${data.list}" var="list" varStatus="status">
                            <tr class="faq_q" onclick="javascript:showAnswer(${list.no});">
                                <!-- 총개수-인덱스-(현재페이지번호-1)*페이지당개수 -->
                                <td style="text-align: center;">${data.totalCount - status.index - (qnaVO.page - 1) * qnaVO.pageRow}</td>
                                <td class="date" style="text-align: center;">
                                	<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${list.regdate}" />
                                </td>
                                <td class="txt_l" style="text-align: left;">
	                                	<!-- 답변 들여쓰기 -->
	                                	<c:forEach begin="1" end="${list.depth}">&nbsp;&nbsp;&nbsp;</c:forEach>
	                                	<c:if test="${list.depth > 0}"><img src="/foody/img/answer_icon.gif"></c:if>
	                                    ${list.title}</a>
                                </td>
                                <td class="writer">
                                    ${list.user_name}
                                </td>
                                <td>
	                                <c:if test="${list.response > 0}">완료
	                                </c:if>
	                                <c:if test="${list.response == 0}">미완료
	                                </c:if>
                                </td>
                            </tr>
                            
                        </c:forEach>
                        </tbody>
                    </table>
                    <!-- 페이지 처리 -->
                    <div class="pagenate clear">
                        <ul class='paging'>
                        <!-- prev 버튼 있는 경우 -->
                        <c:if test="${data.prev == true}">
                        		<!-- prev 버튼 클릭시 stype, sword 값을 그대로 가지고 이전 페이지로 이동 -->
                        		<li><a href="index.do?page=${data.startPage-1}&stype=${param.stype}&sword=${param.sword}"><-</a>
                        	</c:if>
                        	<c:forEach var="num" begin="${data.startPage}" end="${data.endPage}">
	                            <li><a href='index.do?page=${num}&stype=${param.stype}&sword=${param.sword}'
	                            <c:if test="${qnaVO.page == num}">class='current'</c:if>>${num}</a></li>
	                        </c:forEach>
	                        <c:if test="${data.next == true}">
                        		<li><a href="index.do?page=${data.endPage+1}&stype=${param.stype}&sword=${param.sword}">-></a>
                        	</c:if>
                        </ul>
                    	</div>
               	</div>
               	
               	
          	</div>
</div>


</div>
</body>
</html>