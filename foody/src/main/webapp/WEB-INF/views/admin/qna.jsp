<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../common/config.jsp" %>

<head>
<link rel="stylesheet" href="/foody/css/reset.css"/>
<link rel="stylesheet" href="/foody/css/contents.css"/>
<link rel="stylesheet" type="text/css" href="/foody/resources/css/leftMenu.css">
<script type="text/javascript" src="/foody/resources/js/modal/jquery.plainmodal.min.js"></script>
<title>관리자 QnA 페이지</title>

<script>
function openModal(){
	$('.modal').plainModal('open');
}

$('.txt_l').on('click', function() {
	$()
})


</script>

<style>
.modal {
	width: 500px;
	height: 500px;
	background-color: white;
	display: none;
}
</style>

</head>

<body>
<%@ include file="../admin/leftMenu.jsp" %>
<div class="adminContainer">
	<!-- 모달영역 -->
	<div class="modal">
		<div class="view">
            <c:forEach items="${data.list}" var="list" varStatus="status">
            <div class="qna_q">
	            <p>${list.title}</p>
	            <p>${list.content}</p>
	        </div>
        		</c:forEach>
	        <div class="qna_a">
		        <textarea style="width:80%; margin:0 10%;"></textarea>
	        </div>
            <div class="btnSet clear">
                <div class="fl_l">
                <a href="#" class="btn">답변하기</a>
                 <a href="#" class="btn">FAQ에 등록하기</a>
                 <a href="#" class="btn">목록보기</a>
            		</div>
        		</div>
        	</div>
    </div>
    <!-- 모달영역 -->
    
	<div class="qna_list">
            <div class="size">
                <div class="bbs">
	                <form method="get" name="searchForm" id="searchForm" action="qna.do">
	                <div class="search">
		                <ul class="byPeriod" style="display:flex;">
			                <li>기간별&nbsp;&nbsp;|&nbsp;&nbsp;</li>
			                <li><label><input type="radio" id="entire" name="period" value="all" checked/>전체</label></li>
			                <li><label><input type="radio" id="day" name="period" value="1 day"/>1일</label></li>
			                <li><label><input type="radio" id="week" name="period" value="1 week"/>1주</label></li>
			                <li><label><input type="radio" id="month" name="period" value="1 month"/>1개월</label></li>
			                <li><label><input type="radio" id="3months" name="period" value="3 month"/>3개월</label></li>
			                <li><label><input type="radio" id="6months" name="period" value="6 month"/>6개월</label></li>
			                <li><label><input type="radio" id="year" name="period" value="1 year"/>1년</label></li>
		                </ul>
		                <ul class="byResponsed" style="display:flex;">
			                <li>답변 여부&nbsp;&nbsp;|&nbsp;&nbsp;</li>
			                <li><label><input type="radio" id="notResponsed" name="response" value="0" checked/>답변 미완료건</label></li>
			                <li><label><input type="radio" id="responsed" name="response" value="1"/>답변 완료건</label></li>
		                </ul>
	                </div>
	                <div class="bbsSearch" align="left">
	                    <span class="srchSelect">
	                        <select id="stype" name="stype" class="dSelect" title="검색분류 선택">
	                            <option value="all">제목+내용</option>
	                            <option value="title">제목</option>
	                            <option value="content">내용</option>
	                            <option value="writer">작성자</option>
	                        </select>
	                    </span>
	                    <span class="searchWord">
	                        <input type="text" id="sword" name="sword" value="${param.sword}" title="검색어 입력">
	                        <input type="button" id="" value="검색" title="검색">
	                    </span>
	                </div>
	                </form>
                    <table class="list">
                    <p><span><strong>총 ${data.totalCount}개</strong>  |  ${qnaVO.page}/${data.totalPage}페이지</span></p>
                    <!-- boardVO.page 대신 param.page도 가능하지만 1페이지일 때 안 나옴 -->
                        <caption><strong></strong></caption>
                        <colgroup>
                            <col width="80px" />
                            <col width="200px" />
                            <col width="200px" />
                            <col width="*px" />
                            <col width="100px" />
                            <col width="100px" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>작성일</th>
                                <th>질문유형</th>
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
                            <tr class="faq_q">
                                <!-- 총개수-인덱스-(현재페이지번호-1)*페이지당개수 -->
                                <td style="text-align: center;">${data.totalCount - status.index - (qnaVO.page - 1) * qnaVO.pageRow}</td>
                                <td class="date" style="text-align: center;">
                                	<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${list.regdate}" />
                                </td>
                                <td class="qtype">
	                                <c:if test="${list.qtype == 1}">레시피검색/등록</c:if>
	                                <c:if test="${list.qtype == 2}">회원정보</c:if>
	                                <c:if test="${list.qtype == 3}">기타</c:if>
                                </td>
                                <td class="txt_l" style="text-align: left;">
	                                	<!-- 답변 들여쓰기 -->
	                                	<c:forEach begin="1" end="${list.depth}">&nbsp;&nbsp;&nbsp;</c:forEach>
	                                	<c:if test="${list.depth > 0}"><img src="/foody/img/answer_icon.gif"></c:if>
	                                    <a href="javascript:openModal();">${list.title}</a>
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