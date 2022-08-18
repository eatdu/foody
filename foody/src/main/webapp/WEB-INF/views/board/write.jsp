<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/config.jsp" %>
<link rel="stylesheet" href="/foody/css/reset.css"/>
<link rel="stylesheet" href="/foody/css/contents.css"/>
<title>게시판 등록</title>



<script>
	function goSave() {
		frm.submit();
	}
</script>
</head>

<body>
<%@ include file="../common/navBar.jsp" %>
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">게시판</h3>
                <div class="bbs">
                <form method="post" name="frm" id="frm" action="insert.do" enctype="multipart/form-data" >
                <input type="hidden" name="user_no" value="${loginInfo.no}">
                    <table class="board_write" border="2">
                        <tbody>
                        <tr>
                            <th>제목</th>
                            <td>
                                <input type="text" name="title" id="title" class="wid100" value=""/>
                            </td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td>
                                <textarea name="content" id="content"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>첨부파일</th>
                            <td>
                                <input type="file" name="file" id="file">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="btnSet"  style="text-align:right;">
                        <a class="btn" href="javascript:goSave();">저장 </a>
                        <a class="btn" href="index.do">취소 </a>
                    </div>
                    </form>
                </div>
            </div>
        </div>
</body>
</html>