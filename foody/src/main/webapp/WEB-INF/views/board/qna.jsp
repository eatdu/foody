<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>게시판 상세</title>
    <link rel="stylesheet" href="/foody/css/reset.css"/>
    <link rel="stylesheet" href="/foody/css/contents.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    
<script>

	function showContent(no) {
		$(".a_part"+no).slideToggle(1000);
		
	}
	
</script>

</head>
<body>
<div class="sub">
            <div class="size">
                <h3 class="sub_title">QnA 게시판</h3>
                <h3 class="sub_">로그인 한 사람: ${loginInfo.name}</h3>
                <div class="bbs">
                    <table class="list">
                    <p><span><strong>총 ${data.totalCount}개</strong>  |  ${qnaVO.page }/${data.totalPage }페이지</span></p>
                    <!-- boardVO.page 대신 param.page도 가능하지만 1페이지일 때 안 나옴 -->
                        <caption><strong>FAQ</strong></caption>
                        <colgroup>
                            <col width="100px" />
                            <col width="*" />
                            <col width="200px" />
                        </colgroup>
                        <thead>
                            <tr>
                            	<th></th>
                                <th>제목</th>
                                <th>작성일</th>
                            </tr>
                            
                        </thead>
                        <tbody>
						<c:if test="${empty data.list }"> <!-- 당연히 객체가 null일 수 없고 size가 없는 경우니까 -->
                            <tr>
                                <td class="first" colspan="5">등록된 글이 없습니다.</td>
                            </tr>
                        </c:if>
						<c:forEach items="${data.list }" var="list" varStatus="status">
                            <tr class="q_part" onclick="javascript:showContent(${list.no});">
                                <!-- 총개수-인덱스-(현재페이지번호-1)*페이지당개수 -->
                                <td style="text-align: center;">Q.</td>
                                <td class="txt_l" style="text-align: left;">
	                                	<!-- 답변 들여쓰기 -->
	                                	<c:forEach begin="1" end="${list.depth }">&nbsp;&nbsp;&nbsp;</c:forEach>
	                                	<c:if test="${list.depth > 0 }"><img src="/foody/img/answer_icon.gif"></c:if>
	                                    ${list.title}</a>
                                </td>
                                <td class="date" style="text-align: center;">
                                	<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${list.regdate}" />
                                </td>
                            </tr>
                            <tr class="a_part${list.no}" style="display:none; width:100%;">
				                <td style="text-align: center;">A.</td>
                                <td class="txt_l" style="text-align: left;">
	                                	<c:forEach begin="1" end="${list.depth }">&nbsp;&nbsp;&nbsp;</c:forEach>
	                                	<c:if test="${list.depth > 0 }"><img src="/foody/img/answer_icon.gif"></c:if>
	                                    ${list.content}</a>
                                </td>
                                <td class="date" style="text-align: center;">
                                	<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${list.regdate}" />
                                </td>
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
               	
               	<!-- 내가 한 질문들 -->
                <div class="myQna">
                    <table class="list">
                    <p><span><strong>총 ${data.totalCount}개</strong>  |  ${qnaVO.page }/${data.totalPage }페이지</span></p>
                    <!-- boardVO.page 대신 param.page도 가능하지만 1페이지일 때 안 나옴 -->
                        <caption><strong>내가 한 질문들</strong></caption>
                        <colgroup>
                            <col width="100px" />
                            <col width="*" />
                            <col width="200px" />
                        </colgroup>
                        <thead>
                            <tr>
                            	<th></th>
                                <th>제목</th>
                                <th>작성일</th>
                            </tr>
                            
                        </thead>
                        <tbody>
						<c:if test="${empty data.list }"> <!-- 당연히 객체가 null일 수 없고 size가 없는 경우니까 -->
                            <tr>
                                <td class="first" colspan="5">등록된 글이 없습니다.</td>
                            </tr>
                        </c:if>
						<c:forEach items="${data.list }" var="board" varStatus="status">
                            <tr>
                                <!-- 총개수-인덱스-(현재페이지번호-1)*페이지당개수 -->
                                <td style="text-align: center;">Q.</td>
                                <td class="txt_l" style="text-align: left;">
	                                	<!-- 답변 들여쓰기 -->
	                                	<c:forEach begin="1" end="${board.depth }">&nbsp;&nbsp;&nbsp;</c:forEach>
	                                	<c:if test="${board.depth > 0 }"><img src="/foody/img/answer_icon.gif"></c:if>
	                                    <a href="view.do?no=${board.no}">${board.title}</a>
                                </td>
                                <td class="date" style="text-align: center;">
                                	<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.regdate}" />
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
                   
</body>
</html>