<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
<script>
$(function(){
	//Better to construct options first and then pass it as a parameter
	var options = {
		title: {
			text: "월별 가입자 통계"              
		},
		data: [              
		{
			// Change type to "doughnut", "line", "splineArea", etc.
			type: "line",
			dataPoints: [
				{ label: '${cntUser.withM[4].month}',  y: ${cntUser.withM[4].cnt}  },
				{ label: '${cntUser.withM[3].month}', y: ${cntUser.withM[3].cnt}  },
				{ label: '${cntUser.withM[2].month}', y: ${cntUser.withM[2].cnt}  },
				{ label: '${cntUser.withM[1].month}',  y: ${cntUser.withM[1].cnt}  },
				{ label: '${cntUser.withM[0].month}',  y: ${cntUser.withM[0].cnt}  }
			]
		}
		]
	};

	$("#chartContainer").CanvasJSChart(options);
});
</script>
<style>
	td {
		text-align: center;
	}
	ul{
		list-style:none;
		padding-left:0px;
   	}
	#dashBoard {
		width: 100%;
		display: inline-block;
	}
	#dashBoard .container {
		height: 400px;
		width: 48%;
		background-color: #FAF4C0;
		margin: 10px 10px 10px 10px;
		float: left;
	}
	#chartContainer {
		height: 280px;
		width: 90%;
		margin: 10px auto;
	}
</style>
<link rel="stylesheet" type="text/css" href="/foody/resources/css/leftMenu.css">
</head>
<body>
<%@ include file="../admin/leftMenu.jsp" %>
<div class="adminContainer">
<h2>회원목록</h2>
	<div id="dashBoard" >
		<div class="container" id='signUser'>
			<h2>가입자현황</h2>
			총 가입자 수: ${cntUser.all} 명<br>
			<div id="chartContainer"></div>
		</div>
		<div class="container" id='exitUser'>
			<h2>탈퇴자 현황</h2>
			총 탈퇴자 수:   명
			<div id="chartContainer"></div>
		</div>
	</div>
	<div class="sub" style="margin:30px 0 0 0;">
	    <div class="size" >
	        <div class="bbs">
	            <table class="list" id="userList">
	                <colgroup>
	                    <col width="10%"/>
	                    <col width="10%"/>
	                    <col width="10%"/>
	                    <col width="10%"/>
	                    <col width="10%"/>
	                    <col width="10%"/>
	                    <col width="10%"/>
	                </colgroup>
	                <thead>
	                    <tr>
	                        <th>이메일</th>
	                        <th>닉네임</th>
	                        <th>이름</th>
	                        <th>작성한 레시피</th>
	                        <th>작성한 댓글</th>
	                        <th>가입일</th>
	                        <th>상태</th>
	                    </tr>
	                </thead>
	                <tbody>
					<c:forEach var="vo" items="${data.userList}" varStatus="status">
	                     <tr>
	                     	<td>${vo.email}</td>
	                     	<td>${vo.nik_name}</td>
	                     	<td>${vo.name}</td>
	                     	<td>${vo.recipe_count}</td>
	                     	<td>${vo.comment_count}</td>
	                     	<td><fmt:formatDate value="${vo.regdate}" pattern="yyyy-MM-dd"/></td>
	                     	<td>
	                     		<c:if test="${vo.exit eq 0}">가입</c:if>
	                     		<c:if test="${vo.exit eq 1}">탈퇴</c:if>
	                     	</td>
	                     </tr>
					</c:forEach>
	            	</tbody>
	            </table>
	            <%-- <div class="pagenate clear">
	               <ul class='paging'>
	               		<c:if test="${data.prev == true}">
	                		<div>${data.startPage }</div>
	                		<li><a href="userList.do?page=${data.startPage-1}&stype=${param.stype}&sword=${param.sword}"><-</a>
	                	</c:if>
	                	<c:forEach var="num" begin="${data.startPage}" end="${data.endPage}">
	                    <li><a href='userList.do?page=${num}&stype=${param.stype}&sword=${param.sword}' 
	                	<c:if test="${boardVO.page == num}"> class='current' </c:if>>${num}</a></li>
	                </c:forEach>
	                <c:if test="${page.next == true}">
	                		<li><a href="userList.do?page=${data.endPage+1}&stype=${param.stype}&sword=${param.sword}">-></a>
	               	</c:if>
	               </ul> 
	            </div>
	        
	            <!-- 페이징처리 -->
	            <div class="bbsSearch">
	                <form method="get" name="searchForm" id="searchForm" action="">
	                    <span class="srchSelect">
	                        <select id="stype" name="stype" class="dSelect" title="검색분류 선택">
	                            <option value="all" <c:if test="${param.stype == 'all'}">selected</c:if>>전체</option>
	                            <option value="title" <c:if test="${param.stype == 'title'}">selected</c:if>>제목</option>
	                            <option value="content" <c:if test="${param.stype == 'content'}">selected</c:if>>내용</option>
	                        </select>
	                    </span>
	                    <span class="searchWord">
	                        <input type="text" id="sval" name="sword" value="${param.sword}" title="검색어 입력">
	                        <input type="button" id="" value="검색" title="검색">
	                    </span>
	                </form>
	            </div>--%>
	        </div> 
	    </div>
	</div>
</div>
</body>
</html>