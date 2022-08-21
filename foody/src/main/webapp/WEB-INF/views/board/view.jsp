<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../common/config.jsp" %>
    <link rel="stylesheet" href="/foody/css/reset.css"/>
    <link rel="stylesheet" href="/foody/css/contents.css"/>
    <title>게시판 상세</title>


<style>
	.getStar li a img {
		vertical-align: middle;
		max-height: 25px;
		max-width: 25px;
		}
</style>


<script>
	
	/*
	$(function() {
		$(".getStar li a img").mouseenter(function() {
			var idx = $(this).index()+1;
			$(".getStar").removeClass();
			$(".getStar").addClass("star"+idx);
		});
	});
	
	
	<script type="text/javascript">
	var a = $(".getStar li").get();
	console.log("a");
	*/
	
	// 일단 li 자리에 회색별 하나씩 놓고
	// 마우스오버하면 해당 위치보다 숫자가 낮으면 모두 노란별로 바꿔주고
	// 그대로 클릭시에는 ajax로 li의 value값을 서버로 넘겨준다
	// 넘겨준 데이터 값은 VO에 담기고 sql문을 수정해 줘야 할 듯?
	

	
	$(".getStar li a img").hover(function() {
		$(this).attr("src", $(this).attr("src").replace(".jpg", "_on.png"));
	}, function() {
		$(this).attr("src", $(this).attr("src").replace("_on.png", ".jpg"));
	});
	
	// 게시글 삭제 확인
	function del(no) {
		if (confirm('삭제하시겠습니까?')) {
			location.href='delete.do?no='+no;
		}
	}
	
	// 댓글 리스트
	function getComment(page) {
		$.ajax({
			url: "/foody/comment/list.do",
			data: {
				board_no: ${data.no},
				tablename: 'board',
				page: page
			},
			success: function(res) {
				$("#commentArea").html(res);
			}
		});
	}
	
	$(function() {
		getComment(1);
	});
	
	// 댓글 저장
	function goSave() {
		<c:if test="${empty loginInfo}">
			alert('로그인 후 댓글을 작성하실 수 있습니다.');
			location.href='/foody/user/login.do';
		</c:if>
		<c:if test="${!empty loginInfo}">
			if (confirm('댓글을 저장하시겠습니까?')) {
				
				var formData = new FormData($("#frm")[0]);
				formData.append("user_no",${loginInfo.no});
				formData.append("board_no",${data.no});
				formData.append("tablename","board");
				console.log(JSON.stringify(formData));
				
				$.ajax ({
					url: "/foody/comment/insert.do",
					data: formData,
					contentType: false,
					processData: false,
					type: 'post',
					success: function(res) {
						if (res.trim() == "1") {
							alert('댓글이 정상적으로 등록되었습니다.');
							$("#content").val('');
							getComment(1);
						}
					}
				});
			}
		</c:if>
	}
	
	// 댓글 삭제
	function commentDel(no) {
		if (confirm('정말로 삭제하시겠습니까?')) {
			console.log('여기');
			$.ajax({
				url: '/foody/comment/delete.do?no='+no,
				success: function(res) {
					if (res.trim == 1) {
						alert('댓글이 정상적으로 삭제되었습니다.');
						getComment(1);
					}
				}
			});
		}
	}
	
	// 답글달기 클릭시 답글입력창 아래에 보여주기
	function addBox(no) {
		$(".add_reCmt"+no).toggle();
	}

	// 대댓글 저장
	function insert_reCmt(no) {
		<c:if test="${empty loginInfo}">
			alert('로그인 후 댓글을 작성하실 수 있습니다.');
			location.href='/foody/user/login.do';
		</c:if>
		<c:if test="${!empty loginInfo}">
			if (confirm('댓글을 저장하시겠습니까?')) {
				
				var formData = new FormData($('#frm'+no)[0]);
				formData.append("user_no",${loginInfo.no});
				formData.append("board_no",${data.no});
				formData.append("tablename","board");
				console.log(JSON.stringify(formData));
				
				$.ajax ({
					url: "/foody/comment/insert_reCmt.do",
					data: formData,
					contentType: false,
					processData: false,
					type: 'post',
					success: function(res) {
						if (res.trim() == "1") {
							alert('댓글이 정상적으로 등록되었습니다.');
							$("#content").val('');
							getComment(1);
						}
					}
				});
			}
		</c:if>
	}

</script>

</head>

<body>
<%@ include file="../common/navBar.jsp" %>
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">자유게시판</h3>
                <div class="bbs">
                    <div class="view">
                        <div class="title">
                            <dl>
                                <dt>${data.title }</dt>
                                <dd class="date">
                                	<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${data.regdate }"/>
                                </dd>
                            </dl>
                        </div>
                        <div class="cont"><p>${data.content}</p> </div>
                        <dl class="file">
                            <dt>첨부파일 </dt>
                            <dd>
                            <img src="/foody/upload/${data.filename_real}" style="width:100px; height:100px;">
                            <a href="/foody/common/download.jsp?oName=${URLEncoder.encode(data.filename_org, 'UTF-8')}&sName=${data.filename_real}"
                            target="_blank">${data.filename_org} </a></dd>
                        </dl>
                        <div class="btnSet clear">
                            <div class="fl_l">
                            <a href="index.do" class="btn">목록으로</a>
                            <c:if test="${!empty loginInfo}">
	                            <a href="edit.do?no=${data.no}" class="btn">수정</a>
	                            <a href="javascript:del(${data.no});" class="btn">삭제</a>
                            </c:if>
                        	</div>
                    	</div>
                	</div>
                	<!-- 댓글 영역 -->
                	<div class="comment">
	                	<form method="post" name="frm" id="frm" enctype="multipart/form-data" >
	                        <table class="board_write">
	                            <colgroup>
	                                <col width="*" />
	                                <col width="250px" />
	                            </colgroup>
	                            <tbody>
	                            <tr>
	                                <td>
	                                    <textarea name="content" id="content" placeholder="댓글을 입력해 주세요."
	                                    onfocus="this.placeholder=''" onblur="this.placeholder='댓글을 입력해 주세요.'"
	                                    style="height:100px;"></textarea>
	                                </td>
	                                <td>
		                                <ul class="getStar" style="display:flex;">
					                			<li style="list-style:none;" id="star1" value="10"><a href="#"><img src="/foody/img/star_icon.jpg"/></a></li>
					                			<li style="list-style:none;" id="star2" value="20"><a href="#"><img src="/foody/img/star_icon.jpg"/></a></li>
					                			<li style="list-style:none;" id="star3" value="30"><a href="#"><img src="/foody/img/star_icon.jpg"/></a></li>
					                			<li style="list-style:none;" id="star4" value="40"><a href="#"><img src="/foody/img/star_icon.jpg"/></a></li>
					                			<li style="list-style:none;" id="star5" value="50"><a href="#"><img src="/foody/img/star_icon.jpg"/></a></li>
					                		</ul>
					                		<br>
										<input type="file" name="uploadFile" id="uploadFile">
	                                     <div class="btnSet" style="text-align:left;">
	                                        <a class="btn" href="javascript:goSave();">저장 </a>
	                                     </div>
										
	                                </td>
	                            </tr>
	                            </tbody>
	                        </table>
	                   	</form>
                        <div id="commentArea"></div>
                	</div>
                	</div>
            	</div>
        	</div>
</body>

</html>