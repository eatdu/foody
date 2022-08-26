<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/config.jsp" %>
<%@ page import="java.util.*"%>
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>

	<style>
		.getStar li a img {
			vertical-align: middle;
			max-height: 25px;
			max-width: 25px;
			}
	</style>
	
	<link
	  rel="stylesheet"
	  href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"
	/>
	
	<script>
		
		// 댓글리뷰 리스트
		function getComment(page) {
			$.ajax({
				url: "/foody/comment/clist.do",
				data: {
					board_no: ${recipeDatas.no},
					tablename: 'recipe',
					page: page
				},
				success: function(res) {
					$("#commentArea").html(res);
				}
			});
		}
		
		$(function() {
			getComment(1);
			
			// 댓글리뷰 스와이퍼
			var swiper = new Swiper(".mySwiper", {
				slidesPerView : 4,
			    navigation: {
			      nextEl: ".swiper-button-next",
			      prevEl: ".swiper-button-prev",
			    },
			});
			
			// 별점 등록
			$(".getStar li a img").hover(function() { // 마우스오버 이벤트
				var idx = $(this).index(".getStar li a img"); // 오버한 객체의 인덱스값(배열)
				for (var i=0; i<$(".getStar li a img").length; i++) { // 전체별 반복
					if (i <= idx) { // 맨앞에서부터 내가 오버한 곳까지
						$(".getStar li a img").eq(i).attr("src", "/foody/img/star_icon_on.png");
					} else { // 내가 오버한거 뒤에
						$(".getStar li a img").eq(i).attr("src", "/foody/img/star_icon.jpg");
					}
				}
			}, function() { // 마우스아웃
				for (var i=0; i<$(".getStar li a img").length; i++) { // 전체배열 반복
					if (i < $("#starVal").val()) { // 히든(내가 전에 클릭한 별점)에 있는 값보다 작으면 노란별
						$(".getStar li a img").eq(i).attr("src", "/foody/img/star_icon_on.png");
					} else { // 내가 좀 전에 클릭한 별점보다 큰거는 회색별
						$(".getStar li a img").eq(i).attr("src", "/foody/img/star_icon.jpg");
					}
				}
			});
			$(".getStar li a img").click(function() { // 클릭이벤트(내가 별점을 주기위한)
				var idx = $(this).index(".getStar li a img"); // 내가 클릭한 인덱스
				
				$("#starVal").val(idx+1); // 히든에 내가 클릭한 인덱스+1 (별점은 1부터 시작)
			})	
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
					formData.append("board_no",${recipeDatas.no});
					formData.append("tablename","recipe");
					formData.append("recipe_no",${recipeDatas.no});
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
		
		// 답글 클릭시 답글입력창 아래에 보여주기
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
					formData.append("board_no",${recipeDatas.no});
					formData.append("tablename","recipe");
					formData.append("recipe_no",${recipeDatas.no});
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
	
	<body>
	레시피 번호: ${recipeDatas.no}<br><br><br>
	${recipeDatas.name}<br>
	${recipeDatas.intro}<br>
	소요시간 ${recipeDatas.time}분 이내<br>
	분류: ${typeName}<br><br><br>
	
	
	작성자: ${recipeDatas.user_no}<br>
	하하하하
	
	<!-- 포토리뷰 -->
	<div class="swiper mySwiper">
		<div class="swiper-wrapper">
		<h3 class="sub_title">포토 리뷰</h3>
			<c:forEach var="vo" items="${comment.list}" varStatus="idx">
			<div class="swiper-slide"> 
				<div class='reviewCard'>
				<table class="rcpTable" style='table-layout:fixed'>
					<tr>
						<td class="imgCell">
							<div height=150px; style='border-radius:15px; position:relative; max-height:150px; align-items:center; overflow:hidden; display:flex; justify-content:center;'>
								<div class="reviewImg">
									<img class="" width='100%' src="/foody/upload/${vo.photo}">
								</div>
							</div>
						</td>
					</tr>
				</table>
				</div>
			</div>
			</c:forEach>
		</div>
		<div class="swiper-button-next"></div>
		<div class="swiper-button-prev"></div>
	</div>

	<!-- 댓글 영역 -->
	<div class="sub">
            <div class="size">
                <div class="bbs">
                	<div class="comment">
	                	<form method="post" name="frm" id="frm" enctype="multipart/form-data" >
	                	<input type="hidden" id="starVal" name="star" value="0">
	                        <table class="board_write">
	                            <colgroup>
	                                <col width="*" />
	                                <col width="250px" />
	                            </colgroup>
	                            <tbody>
	                            <tr>
	                                <td>
	                                    <textarea name="content" id="content" placeholder="댓글리뷰를 남겨주세요."
	                                    onfocus="this.placeholder=''" onblur="this.placeholder='댓글리뷰를 남겨주세요.'"
	                                    style="height:100px;"></textarea>
	                                </td>
	                                <td>
		                                <ul class="getStar" style="display:flex;">
					                			<li style="list-style:none;" id="star1"><a href="#"><img src="/foody/img/star_icon.jpg"/></a></li>
					                			<li style="list-style:none;" id="star2"><a href="#"><img src="/foody/img/star_icon.jpg"/></a></li>
					                			<li style="list-style:none;" id="star3"><a href="#"><img src="/foody/img/star_icon.jpg"/></a></li>
					                			<li style="list-style:none;" id="star4"><a href="#"><img src="/foody/img/star_icon.jpg"/></a></li>
					                			<li style="list-style:none;" id="star5"><a href="#"><img src="/foody/img/star_icon.jpg"/></a></li>
				                			
					                		</ul>
					                		<br>
										<input type="file" name="uploadFile" id="uploadFile">
	                                     <div class="btnSet" style="text-align:left;">
	                                        <a class="btn" href="javascript:goSave();">저장</a>
	                                     </div>
	                                </td>
	                            </tr>
	                            </tbody>
	                        </table>
	                   	</form>
		                <h2 class="sub_title">댓글 리뷰</h3>
                        <div id="commentArea"></div>
                	</div>
                	</div>
                	</div>
	</div>
	</body>

</html>




