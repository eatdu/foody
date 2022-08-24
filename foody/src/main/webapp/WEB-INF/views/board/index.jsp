<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/config.jsp" %>
<link rel="stylesheet" href="/foody/css/reset.css"/>
<link rel="stylesheet" href="/foody/css/contents.css"/>
<title>게시판목록</title>

<script>
	function goWrite() {
		<c:if test="${empty loginInfo}">
			alert('로그인 후 작성하실 수 있습니다.');
			location.href='/foody/user/login.do';
		</c:if>
		<c:if test="${!empty loginInfo}">
			location.href='write.do';
		</c:if>
	}
</script>


</head>

<body>
<%@ include file="../common/navBar.jsp" %>
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">자유게시판</h3>
                <h3 class="sub_">로그인 한 사람: ${loginInfo.name}</h3>
                <div class="bbs">
                    <table class="list">
                    <p><span><strong>총 ${data.totalCount}개</strong>  |  ${boardVO.page}/${data.totalPage}페이지</span></p>
                        <caption>게시판 목록</caption>
                        <colgroup>
                            <col width="80px" />
                            <col width="*" />
                            <col width="100px" />
                            <col width="100px" />
                            <col width="200px" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>조회수</th>
                                <th>작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty data.list}">
                            <tr>
                                <td class="first" colspan="5">등록된 글이 없습니다.</td>
                            </tr>
                        </c:if>
                        <c:forEach items="${data.list }" var="list" varStatus="status">
                            <tr>
                                <!-- 총개수-인덱스-(현재페이지번호-1)*페이지당개수 -->
                                <td>${data.totalCount - status.index - (boardVO.page - 1) * boardVO.pageRow}</td>
                                <td class="txt_l">
                                    <a href="view.do?no=${list.no}">${list.title} [${list.comment_count}]</a>
                                </td>
                                <td class="writer">
                                    ${list.user_name}
                                </td>
                                <td> ${list.viewcount}</td>
                                <td class="date">
                                		<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${list.regdate}"/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="btnSet" style="text-align:right;">
                    	<a class="btn" href="javascript:goWrite();">글작성 </a>
                    </div>
                    
                    <!-- 페이지처리 -->
                    <div class="pagenate clear">
                        <ul class='paging'>
                        	<c:if test="${data.prev == true}">
                        		<!-- prev 버튼 클릭시 stype, sword 값을 그대로 가지고 이전 페이지로 이동 -->
                        		<li><a href="index.do?page=${data.startPage-1}&stype=${param.stype}&sword=${param.sword}">prev</a>
                        	</c:if>
                        	<c:forEach var="num" begin="${data.startPage}" end="${data.endPage}">
	                            <li><a href='index.do?page=${num}&stype=${param.stype}&sword=${param.sword}'
	                            <c:if test="${boardVO.page == num}">class='current'</c:if>>${num}</a></li>
	                        </c:forEach>
	                        <c:if test="${data.next == true}">
                        		<li><a href="index.do?page=${data.endPage+1}&stype=${param.stype}&sword=${param.sword}">next</a>
                        	</c:if>
                        </ul>
                    </div>
                    
                    <!-- 검색조건/키워드 -->
                    <div class="bbsSearch">
                        <form method="get" name="searchForm" id="searchForm" action="">
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
                        </form>
                    </div>
                    
                </div>
            </div>
        </div>
</body>
</html>