<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/config.jsp" %>
<%@ page import="java.util.*"%>
	<title>레시피 뷰</title>
	
	<!-- 별점 아이콘 css -->
	<style>
	.getStar li a img {
		vertical-align: middle;
		max-height: 25px;
		max-width: 25px;
		}
		
	.getBookmark img {
		vertical-align: middle;
		max-height: 25px;
		max-width: 25px;
	}
	
	.sub_title {
		float:left;
		font-size: 100%;
		
	}
	div.reviewImg {
		overflow: hidden;
		height: 220px;
	    width: 20%;
	    margin: 15px;
		float: left;
	}
	.swiper-slide {
		display: flex;
	    justify-content: center;
		max-height: 250px;
	}
	div.reviewImg img{
		width: 100%;
	    object-fit: cover;
	    height: 100%;
    }
	</style>
	
	<!-- 포토리뷰 스와이퍼 css -->
	<link
	  rel="stylesheet"
	  href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"
	/>
	
	<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
	<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
	<script type="text/javascript">
		var userNikname;
		var userDayKcal;
		$(function(){
			console.log(${recipe.bookmark});
			if("${loginUser}" == null || "${loginUser}" == ""){
				console.log("로그인 정보가 없습니다.");
				userNikname = "게스트";
				userDayKcal = 2400;
			}else{
				console.log("로그인하셨습니다");
				userNikname = String("${loginUser.nik_name}");
				userDayKcal = Number("${sessCal}");
			}
		});
		
		// 찜해제
		/*
		function processBmk() {
			$.ajax({
				url: "/foody/recipe/processBmk.do",
				
				data: {
					no: ${recipe.no},
					user_no: ${loginInfo.no}
				},
				success: function(res) {
					console.log(res);
					if (res.trim() == "insert") {
						//document.getElementById("heartImg").src =;
						console.log("꽉찬하트");
					} else if (res.trim() == "delete") {
						//$("#heartChange").html("<img id='heartImg' src='/foody/img/empty_heart.png'>");
						console.log("빈하트");
					}
				}
			});
		}
		*/
		
		// 댓글리뷰 리스트
		function getComment(page) {
			$.ajax({
				url: "/foody/comment/clist.do",
				data: {
					board_no: ${recipe.no},
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
			    navigation: {
			      nextEl: ".swiper-button-next",
			      prevEl: ".swiper-button-prev",
			    }
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
				alert('로그인 후 댓글을 작성하실 수 있습니다. 로그인 하시겠습니까?');
				location.href='/foody/user/login.do';
			</c:if>
			<c:if test="${!empty loginInfo}">
				if (confirm('댓글을 저장하시겠습니까?')) {
					
					var formData = new FormData($("#frm")[0]);
					formData.append("user_no",${loginInfo.no});
					formData.append("board_no",${recipe.no});
					formData.append("tablename","recipe");
					formData.append("recipe_no",${recipe.no});
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
				alert('로그인 후 댓글을 작성하실 수 있습니다. 로그인 하시겠습니까?');
				location.href='/foody/user/login.do';
			</c:if>
			<c:if test="${!empty loginInfo}">
				if (confirm('댓글을 저장하시겠습니까?')) {
					
					var formData = new FormData($('#frm'+no)[0]);
					formData.append("user_no",${loginInfo.no});
					formData.append("board_no",${recipe.no});
					formData.append("tablename","recipe");
					formData.append("recipe_no",${recipe.no});
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

		$(function(){
			options={
				title: {
					text: "칼로리: "+${sumKcal}+"kcal"
				},
				data: [{
					type: "doughnut",
					innerRadius: "40%",
					showInLegend: false,
					legendText: "{label}",
					indexLabel: "{label}: #percent%",
					dataPoints: [
						{ label: "탄수화물", y: ${sumCarbo}},
						{ label: "단백질", y: ${sumProtein}},
						{ label: "지방", y: ${sumFat}}
					]
				}]
			};
			$("#chartContainer").CanvasJSChart(options);  
		});
		
		$(function(){
			options={
				title: {
					text:userNikname +" 님의 하루 권장 칼로리: "+userDayKcal+"kcal"
				},
				data: [{
					type: "doughnut",
					innerRadius: "40%",
					showInLegend: false,
					legendText: "{label}",
					indexLabel: "{label}: #percent%",
					dataPoints: [
						{ label: "남은 칼로리", y: (userDayKcal-${sumKcal})},
						{ label: "음식의 칼로리", y: ${sumKcal}}
					]
				}]
			};
			$("#chartContainer2").CanvasJSChart(options);  
		});
	</script>	
	</head>
	<body>
	<%@ include file="../common/navBar.jsp" %>
	레시피 번호: ${recipe.no}<br><br><br>
	
	<!-- 경로수정 해야하는데 모르겠음 -->
	<img src="/foody/upload/${recipe.thumbnail}" style="width:250px; height:140px;"><br><br>
	<img src="/foody/upload/${user.selfi}" style="width:100px; height:100px; border-radius:50%;"><br>
	이름: ${user.nik_name}<br><br>
	
	${recipe.name}<br>
	${recipe.intro}<br>
	
	소요시간 ${recipe.time}분 이내<br>
	분류: ${recipeType}<br>
	총 제공량: ${recipe.serving}인분
	<br><br><br>

	재료:<br>
	<c:forEach var="dataMap" items="${Ingredientlist}" varStatus="status">
		<div id ="ingredientListView">
			<c:if test="${dataMap.weight eq 0}">
				<c:out value="${dataMap.name} (${dataMap.quantity})"/>
			</c:if>
			<c:if test="${dataMap.weight ne 0}">
			<c:out value="${dataMap.name} ${dataMap.weight}g (${dataMap.quantity})"/>
			</c:if>
			<c:if test="${not empty loginUser}">
				<c:forEach var="sessallergyNo" items="${sessAllergyNo}" varStatus="status">
					<c:if test="${sessallergyNo eq dataMap.allergy_no}">
							<span style="color:red;">
								<c:out value="알러지 주의!!"/>
							</span>
					</c:if>
				</c:forEach>
			</c:if>
			<c:if test="${empty loginUser}">
				<c:if test="${dataMap.allergy_no ne 0}">
						<span style="color:red;">
							<c:out value="알러지 주의!!"/>
						</span>
				</c:if>
			</c:if>
		</div>
		<c:if test="${not empty dataMap.detail}">
			<div style="font-size:5px;" >
				<c:out value="(참고:${dataMap.detail})"/>
			</div>
		</c:if>
		<br>
	</c:forEach>
	
	<br><br><br>
	칼로리 및 영양정보(1인 제공량 기준):<br>
	열량: ${sumKcal}kcal  탄수화물: ${sumCarbo}kcal   단백질:${sumProtein}kcal  지방:${sumFat}kcal 
	<br><br><br>
	<div id="chartContainer" style="height: 200px; width: 50%;"></div>
	<br>
	<div id="chartContainer2" style="height: 200px; width: 50%;"></div>
	<br>
	
	조리과정:
	<c:forEach var="dataMap" items="${processlist}" varStatus="status">
		<p><c:out value="Step${dataMap.order_no}"/>
		
		<c:if test="${not empty dataMap.photo}">
		<img src = "<c:out value="/foody/upload/${dataMap.photo}"/>" style="width:250px; height:140px;">
		</c:if>
		
		<c:if test="${empty dataMap.photo}">
		<img src = "<c:out value="/foody/resources/img/processImg.png"/>" style="width:250px; height:140px;">
		</c:if>
		
		<c:out value="${dataMap.content}"/></p>
	</c:forEach>
	
	<br><br>
	
	완성 사진:
	<br>
	<c:if test="${not empty recipe.addedpicture1}">
		<img src = "<c:out value="${recipe.addedpicture1}"/>" style="width:250px; height:140px;">
	</c:if>
	<c:if test="${empty recipe.addedpicture1}">
		<img src = "<c:out value="/foody/resources/img/processImg.png"/>" style="width:250px; height:140px;">
	</c:if>
	
	<c:if test="${not empty recipe.addedpicture2}">
		<img src = "<c:out value="${recipe.addedpicture2}"/>" style="width:250px; height:140px;">
	</c:if>
	<c:if test="${empty recipe.addedpicture2}">
		<img src = "<c:out value="/foody/resources/img/processImg.png"/>" style="width:250px; height:140px;">
	</c:if>
	
	<!-- 찜하기 -->
	<!--
	<div class="getBookmark">
		<c:if test="${!empty loginInfo}">
			<c:if test="${recipe.bookmark eq 1}">
				<img id="heartImg" src="/foody/img/heart.png">
	   		 	<a href="javascript:processBmk();">찜해제</a>
	    		</c:if>
			<c:if test="${recipe.bookmark eq 0 or empty recipe.bookmark}">
				<img id="heartImg2" src="/foody/img/empty_heart.png">
	   		 	<a href="javascript:processBmk();">찜하기</a>
	    		</c:if>
	    </c:if>
	</div>
	-->
	
	<!-- 포토리뷰 -->
	<div class="comment">
	<h2 class="sub_title">포토 리뷰</h2><br>
	</div>
	<div class="swiper mySwiper">
		<div class="swiper-wrapper">
			<div class="swiper-slide" style="display: inline-block;"> 
			<c:forEach var="vo" items="${photoComment}" varStatus="idx">
				<div class="reviewImg">
					<img class="" width='100%' src="/foody/upload/${vo.photo}">
				</div>
			<c:if test="${idx.count % 4 == 0 && !idx.last}">
			</div>
			<div class="swiper-slide" style="display: inline-block;">
			</c:if>
			</c:forEach>
			</div>
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
		                <h2 class="sub_title">댓글 리뷰</h2><br>
                        <div id="commentArea"></div>
                	</div>
                	</div>
                	</div>
	</div>
	<br>
	요리 팁: ${recipe.tip}
	
	</body>
</html>




