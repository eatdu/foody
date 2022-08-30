<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/config.jsp" %>

<link rel="stylesheet" href="/foody/css/reset.css"/>
<link rel="stylesheet" href="/foody/css/contents.css"/>
<title>게시판 등록</title>

<script src="/foody/smarteditor/js/HuskyEZCreator.js"></script>
<script src="/foody/js/function.js"></script>

<script>


	function goSave() {
   		editor.getById['content'].exec('UPDATE_CONTENTS_FIELD', []);
   		frm.submit();
   		//opener.parent.location.reload();
   		//window.close();
    }
	
    var editor; // 전역변수로 선언
    $(function() {
    	editor = setEditor('content'); // 문서 열리자마자 editor 객체에 담아줌
    })
    
</script>
</head>

<body>
        <div class="sub">
            <div class="size">
                <h3 class="sub_title"></h3>
                <div class="bbs">
                	<div class="view">
                        <div class="title">
                            <dl>
                                <dt>${data.title}</dt>
                                <dd class="date">
                                	<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${data.regdate}"/>
                                </dd>
                            </dl>
                        </div>
                        <div class="content"><p>${data.content}</p> </div>
                    	</div>
                </div>
	                <form method="post" name="frm" id="frm" action="reply.do" enctype="multipart/form-data" >
	                <input type="hidden" name="qna_no" value="${data.no}">
	                <input type="hidden" name="user_no" value="${data.user_no}">
	                <input type="hidden" name="qtype" value="${data.qtype}">
	                <input type="hidden" name="gno" value="${data.gno}">
	                <input type="hidden" name="ono" value="${data.ono}">
	                <input type="hidden" name="depth" value="${data.depth}">
                <table class="admin_write" border="2">
                        <tbody>
                        <tr>
                            <th>제목</th>
                            <td>
                                <input type="text" name="title" id="title" class="wid100" value="답변완료">
                            </td>
                        </tr>
                        <tr>
                            <th>답변내용</th>
                            <td>
                                <textarea name="content" id="content"></textarea>
                            </td>
                        </tr>
                        </tbody>
                </table>
                    </form>
                    <div class="btnSet"  style="text-align:right;">
                        <a class="btn" href="javascript:goSave();">저장</a>
                        <a class="btn" onclick="window.close();">닫기</a>
                    </div>
                </div>
            </div>
        
</body>
</html>