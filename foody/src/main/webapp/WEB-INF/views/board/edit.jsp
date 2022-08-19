<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/config.jsp" %>
    <title>게시판 수정</title>
    <link rel="stylesheet" href="/foody/css/reset.css"/>
    <link rel="stylesheet" href="/foody/css/contents.css"/>
    
    <script src="/foody/smarteditor/js/HuskyEZCreator.js"></script>
	<script src="/foody/js/function.js"></script>
    
    <script>
    	function goSave() {
    		editor.getById['content'].exec('UPDATE_CONTENTS_FIELD', []);
    		frm.submit();
    	}
    	var editor; // 전역변수로 선언
        $(function() {
        	editor = setEditor('content'); // 문서 열리자마자 editor 객체에 담아줌
        })
    </script>
</head>

<body>
<%@ include file="../common/navBar.jsp" %>
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">게시판</h3>
                <div class="bbs">
                <form method="post" name="frm" id="frm" action="update.do" enctype="multipart/form-data" >
                    <input type="hidden" name="no" value="${data.no}"/>
                    <table class="board_write" border="2">
                        <tbody>
                        <tr>
                            <th>제목</th>
                            <td>
                                <input type="text" name="title" id="title" class="wid100" value="${data.title }"/>
                            </td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td>
                                <textarea name="content" id="content">${data.content }</textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>첨부파일</th>
                            <td>
                            	${data.filename_org}
                                <input type="file" name="file">
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