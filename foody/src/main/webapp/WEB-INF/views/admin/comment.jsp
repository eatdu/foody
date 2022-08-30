<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../common/config.jsp" %>

<head>

<link rel="stylesheet" type="text/css" href="/foody/resources/css/leftMenu.css">
<link rel="stylesheet" href="/foody/css/reset.css"/>
<link rel="stylesheet" href="/foody/css/contents.css"/>
<script type="text/javascript" src="/foody/resources/js/modal/jquery.plainmodal.min.js"></script>
<title>관리자 댓글 목록 페이지</title>

<script>
	
	//댓글 삭제
	function commentDel(no) {
		if (confirm('정말로 삭제하시겠습니까?')) {
			location.href='delete.do?no='+no;
		}
	}

	
</script>

<style>
.modal {
	width: 500px;
	height: 500px;
	background-color: white;
	display: none;
}
div.adminMenu {
	font: 13px/1.5 '나눔고딕', NanumGothic, 'Nanum Gothic';
    color: #6a6d6f;
}
</style>

</head>

<body>
<%@ include file="../admin/leftMenu.jsp" %>
<div class="adminContainer">
<div class="title"><h1>댓글 목록 조회</h1></div>
	<!-- 모달영역
	<div class="modal">
		<div class="view">
            <div class="title">
                <dl>
                	
                </dl>
            </div>
            <div class="cont"><p>${comment.content}</p></div>
            <div class="btnSet clear">
                <div class="fl_l">
                <a href="#" class="btn">답변하기</a>
                 <a href="#" class="btn">FAQ에 등록하기</a>
                 <a href="#" class="btn">목록보기</a>
            	</div>
        	</div>
        	</div>
    </div>
    -->
    
    <div class="comment_list">
            <div class="size">
                <div class="bbs">
					<div class="search">
					<form method="get" name="searchForm" id="searchForm" action="comment.do">
	                <!-- 관리자 검색조건 -->
	                <div class="byPeriod">
		                <ul class="byPeriod" style="display:flex;">
			                <li>기간별&nbsp;&nbsp;|&nbsp;&nbsp;</li>
			                <li><label><input type="radio" id="all" name="period" value="all" checked/>전체</label></li>
			                <li><label><input type="radio" id="day" name="period" value="1 day" <c:if test="${param.period=='1 day'}"> checked</c:if>/>1일</label></li>
			                <li><label><input type="radio" id="week" name="period" value="1 week" <c:if test="${param.period=='1 week'}"> checked</c:if>/>1주</label></li>
			                <li><label><input type="radio" id="month" name="period" value="1 month" <c:if test="${param.period=='1 month'}"> checked</c:if>/>1개월</label></li>
			                <li><label><input type="radio" id="3months" name="period" value="3 month" <c:if test="${param.period=='3 month'}"> checked</c:if>/>3개월</label></li>
			                <li><label><input type="radio" id="6months" name="period" value="6 month" <c:if test="${param.period=='6 month'}"> checked</c:if>/>6개월</label></li>
			                <li><label><input type="radio" id="year" name="period" value="1 year" <c:if test="${param.period=='1 year'}"> checked</c:if>/>1년</label></li>
		                </ul>
		                <!--  <ul class="byResponsed" style="display:flex;">
			                <li>신고 확인 여부&nbsp;&nbsp;|&nbsp;&nbsp;</li>
			                <li><label><input type="radio" id="notResolved" name="resolved" value="0" checked/>신고 미확인건</label></li>
			                <li><label><input type="radio" id="resolved" name="resolved" value="1"/>신고 확인건</label></li>
		                </ul> -->
	                </div>
	                <div class="orderBy">
		                <ul class="orderBy" style="display:flex;">
			                <li>정렬순&nbsp;&nbsp;|&nbsp;&nbsp;</li>
			                <li><label><input type="radio" id="recent" name="align" value="recent" checked/>최신등록순</label></li>
			                <li><label><input type="radio" id="old" name="align" value="old" <c:if test="${param.align=='old'}"> checked</c:if>/>오래된순</label></li>
			                <li><label><input type="radio" id="writer" name="align" value="writer" <c:if test="${param.align=='writer'}"> checked</c:if>/>작성자순</label></li>
		                </ul>
		            </div>
	                <div class="bbsSearch" style="float:left;">
	                    <span class="srchSelect">
	                        <select id="stype" name="stype" class="dSelect" title="검색분류 선택">
	                            <option value="content" <c:if test="${param.stype=='content'}">selected</c:if>>댓글내용</option>
	                            <option value="writer" <c:if test="${param.stype=='writer'}">selected</c:if>>작성자</option>
	                        </select>
	                    </span>
	                    <span class="searchWord">
	                        <input type="text" id="sword" name="sword" value="${param.sword}" title="검색어 입력">
	                    </span>
	                        <input type="submit" id="" value="검색" style="height:32px; box-sizing:border-box; border:0; line-height:32px; background-color:#fff; border:1px solid #c7c8cc; vertical-align:middle;">
	                </div>
		            <!-- 관리자 검색조건 end -->
	                </form>
	                </div>
	                
	                <!-- 전체 댓글목록 -->
				    <p><span><strong>총 ${comment.totalCount}개</strong>  |  ${commentVO.page}/${comment.totalPage}페이지</span></p>
					<table class="list">
					    <colgroup>
					        <col width="80px" />
					        <col width="200" />
					        <col width="200px" />
					        <col width="*" />
					        <col width="100px" />
					        <col width="200px" />
					    </colgroup>
					    <thead>
                            <tr>
                                <th>번호</th>
                                <th>작성일시</th>
                                <th>원글 제목</th>
                                <th>댓글 내용</th>
                                <th>작성자</th>
                                <th>삭제/비공개</th>
                                <!-- <th>신고확인 여부</th> -->
                            </tr>
					    </thead>
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
				               	<td class="date" style="width:150px;">
				               		<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${list.regdate}" />
				               	</td>
				               	<td>
				               		<c:if test="${list.tablename == 'board'}">
				               		${list.board_title}
				               		</c:if>
				               		<c:if test="${list.tablename == 'recipe'}">
				               		${list.recipe_name}
				               		</c:if>
				               	</td>
				               	<td class="txt_l" style="text-align:left">
				               		<!-- 답변 들여쓰기 -->
					               	<c:forEach begin="1" end="${list.depth}">&nbsp;&nbsp;&nbsp;</c:forEach>
					               	<c:if test="${list.depth > 0}"><img src="/foody/img/comment_icon.gif"></c:if>
					                ${list.content}</a>
				               	</td>
				               	<td class="writer" style="text-align:center;">
				                		${list.user_name}
				               	</td>
				               	<td class="commentDel" style="text-align: center;">
				                		<a href="javascript:del(${list.no});">[삭제]</a>
				                		<!-- <input type="radio" id="all" name="period" value="all" />비공개 -->
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
			           		<li><a href="comment.do?page=${comment.startPage-1}&stype=${param.stype}&sword=${param.sword}">prev</a>
			           	</c:if>
			            <c:forEach var="num" begin="${comment.startPage}" end="${comment.endPage}">
			                <li><a href='comment.do?page=${num}&stype=${param.stype}&sword=${param.sword}'
			                <c:if test='${commentVO.page == num})'>class='current'</c:if>>${num}</a></li>
			            </c:forEach>
			            <c:if test="${comment.next == true}">
			           		<li><a href="comment.do?page=${comment.endPage+1}&stype=${param.stype}&sword=${param.sword}">next</a>
			           	</c:if>
				        </ul>
			        </div>
    				</div>
    </div>

</div>
</body>
</html>