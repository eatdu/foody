<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/config.jsp" %>
    <link rel="stylesheet" href="/foody/css/reset.css"/>
    <link rel="stylesheet" href="/foody/css/contents.css"/>
    <title>게시판 상세</title>
<script>

	function showAnswer(no) {
		$(".faq_a"+no).slideToggle("slow");
		
	}
	
	function goWrite() {
		<c:if test="${empty loginInfo}">
			alert('로그인 후 작성하실 수 있습니다.');
			location.href='/foody/user/login.do';
		</c:if>
		<c:if test="${!empty loginInfo}">
			location.href='/foody/board/qna_write.do';
		</c:if>
	}
	
</script>

<style>
	li {
		list-style:none;
	}
	ul {
		margin: 0 auto;
		width: 1200px;
		display: flex;
	}
	ul > li {
		text-align: center;
		width: 25%;
		line-height: 40px;
	}
	
</style>

</head>
<body>
<%@ include file="../common/navBar.jsp" %>
<div class="sub">
	<h3 class="sub_title">QnA 게시판</h3>
	<ul>
		<li>FAQ</li>
		<li>내가 한 질문</li>
	</ul>
<div class="qna_list">
            <div class="size">
                <h5 class="sub_title">FAQ</h3>
                <div class="bbs">
                    <table class="list">
                    <p><span><strong>총 ${data.totalCount}개</strong>  |  ${qnaVO.page }/${data.totalPage }페이지</span></p>
                    <!-- boardVO.page 대신 param.page도 가능하지만 1페이지일 때 안 나옴 -->
                        <caption><strong>FAQ</strong></caption>
                        <colgroup>
                            <col width="100px" />
                            <col width="*" />
                        </colgroup>
                        <thead>
                            <tr>
                            	<th>&nbsp;</th>
                            </tr>
                            
                        </thead>
                        <tbody>
						<c:if test="${empty data.list }"> <!-- 당연히 객체가 null일 수 없고 size가 없는 경우니까 -->
                            <tr>
                                <td class="first" colspan="5">등록된 글이 없습니다.</td>
                            </tr>
                        </c:if>
						<c:forEach items="${data.list }" var="list" varStatus="status">
                            <tr class="faq_q" onclick="javascript:showAnswer(${list.no});">
                                <!-- 총개수-인덱스-(현재페이지번호-1)*페이지당개수 -->
                                <td style="text-align: center;">Q.</td>
                                <td class="txt_l" style="text-align: left;">
	                                	<!-- 답변 들여쓰기 -->
	                                	<c:forEach begin="1" end="${list.depth }">&nbsp;&nbsp;&nbsp;</c:forEach>
	                                	<c:if test="${list.depth > 0 }"><img src="/foody/img/answer_icon.gif"></c:if>
	                                    ${list.title}</a>
                                </td>
                                
                            </tr>
                            <tr class="faq_a${list.no}" style="display:none; width:100%;">
				                <td style="text-align: center;">A.</td>
                                <td class="txt_l" style="text-align: left;">
	                                	<c:forEach begin="1" end="${list.depth }">&nbsp;&nbsp;&nbsp;</c:forEach>
	                                	<c:if test="${list.depth > 0 }"><img src="/foody/img/answer_icon.gif"></c:if>
	                                    ${list.content}</a>
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
               	
               	<!-- 내가 한 질문 -->
                <h5 class="sub_title">내가 한 질문</h3>
                <h3 class="sub_">로그인 한 사람: ${loginInfo.name}</h3>
                <div class="bbs">
                    <table class="list">
                    <p><span><strong>총 ${myQna.totalCount}개</strong>  |  ${qnaVO.page}/${data.totalPage}페이지</span></p>
                    <!-- boardVO.page 대신 param.page도 가능하지만 1페이지일 때 안 나옴 -->
                        <caption><strong>내가 한 질문</strong></caption>
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
						<c:if test="${empty myQna.list}"> <!-- 당연히 객체가 null일 수 없고 size가 없는 경우니까 -->
                            <tr>
                                <td class="first" colspan="5">등록된 글이 없습니다.</td>
                            </tr>
                        </c:if>
                        <c:if test="${!empty loginInfo}">
						<c:forEach items="${myQna.list}" var="board" varStatus="status">
                            <tr>
                                <!-- 총개수-인덱스-(현재페이지번호-1)*페이지당개수 -->
                                <td style="text-align: center;">${myQna.totalCount - status.index - (qnaVO.page - 1) * qnaVO.pageRow}</td>
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
                        </c:if>
                        </tbody>
                    </table>
                    <div class="btnSet" style="text-align:right;">
      					<a class="btn" href="javascript:goWrite();">1:1 질문하기</a>
                 	</div>
                    <!-- 페이지 처리 -->
                    <div class="pagenate clear">
                        <ul class='paging'>
                        <!-- prev 버튼 있는 경우 -->
                        <c:if test="${myQna.prev == true}">
                        		<!-- prev 버튼 클릭시 stype, sword 값을 그대로 가지고 이전 페이지로 이동 -->
                        		<li><a href="index.do?page=${myQna.startPage-1}&stype=${param.stype}&sword=${param.sword}"><-</a>
                        	</c:if>
                        	<c:forEach var="num" begin="${myQna.startPage}" end="${myQna.endPage}">
	                            <li><a href='index.do?page=${num}&stype=${param.stype}&sword=${param.sword}'
	                            <c:if test="${qnaVO.page == num}">class='current'</c:if>>${num}</a></li>
	                        </c:forEach>
	                        <c:if test="${myQna.next == true}">
                        		<li><a href="index.do?page=${myQna.endPage+1}&stype=${param.stype}&sword=${param.sword}">-></a>
                        	</c:if>
                        </ul>
                    	</div>
               	</div>
          	</div>
</div>
                   
</body>
</html>