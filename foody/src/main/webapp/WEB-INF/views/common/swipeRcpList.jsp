<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h4 class='titlesm tc'>--- ${result.title} ---</h4>
<div class="swiper mySwiper">
	<div class="swiper-wrapper">
		<div class="swiper-slide">
			<c:forEach var="l1" items="${result.list}" varStatus="idx">
		<a href="view.do?no=${l1.no}">
		<div class='rcpCard'>
		<table class="rcpTable" style='table-layout:fixed'>
			<tr>
				<td class="imgCell" colspan='2'>
				<div height=150px style='border-radius: 15px; position: relative; max-height:150px; align-items:center; overflow:hidden; display: flex; justify-content:center;'>
					<div class="rcpImg">
					<img class="thumbnail" width='100%' src="/foody/upload/${l1.thumbnail}">
					</div>
					<div class="intro">${l1.intro}</div>
				</div>
				</td>
			</tr>
			<tr>
				<td colspan='2'>
				<div class="icons">
					<img class="" width='20px' src="/foody/resources/img/viewcnt.png">
					${l1.viewcount}
					<img class="" width='20px' src="/foody/resources/img/reply.png">
					${l1.reply}
					<img class="" width='20px' src="/foody/img/heart.png">
					${l1.bookmark} 
					<img class="" width='20px' src="/foody/img/star.png">
					${l1.avgStar}
				</div>
				</td>
			</tr>
			<tr class="">
				<td><div class="timename">${l1.name}</div></td>
				<td><div class="timename">${l1.time}분</div></td>
			</tr>
		</table>
		</div>
		</a>
		<c:if test="${idx.count % 4 == 0 && !idx.last}">
	</div>
	<div class='swiper-slide'>
		</c:if>
	</c:forEach>
		</div>
	</div>
	<div class="swiper-button-next"></div>
	<div class="swiper-button-prev"></div>
</div>
<script>
  var swiper = new Swiper(".mySwiper", {
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
  });
$(".rcpCard").hover(function(){
	$(this).find(".intro").show();
	$(this).find(".thumbnail").css("opacity", 0.7);
})
$(".rcpCard").mouseleave(function(){
	$(this).find(".intro").hide();
	$(this).find(".thumbnail").css("opacity", 1.0);
})
</script>
