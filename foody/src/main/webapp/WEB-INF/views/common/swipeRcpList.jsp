<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h4 class='titlesm tc'>--- ${result.title} ---</h4>
<div class="swiper mySwiper">
	<div class="swiper-wrapper">
		<div class="swiper-slide">
			<c:forEach var="l1" items="${result.list}" varStatus="idx">
		<div class='rcpCard'>
		<a href="view.do?no=${l1.no}">
		<table class="rcpTable" style='table-layout:fixed'>
			<tr>
				<td class="imgCell" colspan='2'>
				<div height=150px style='border-radius: 15px; position: relative; max-height:150px; align-items:center; overflow:hidden; display: flex; justify-content:center;'>
					<div class="rcpImg">
					<img class="" width='100%' src="${l1.thumbnail}">
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
					${l1.star}
				</div>
				</td>
			</tr>
			<tr class="">
				<td><span class="nameCell">${l1.name}</span></td>
				<td><span class="timeCell">${l1.time}분</span></td>
			</tr>
			<tr><td colspan='2'>--출력 필요 X / no: ${l1.no} / type: ${l1.type}--</td></tr>
		</table>
		</a>
		</div>
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
$(".rcpTable").hover(function(){
	$(this).find(".intro").show();
})
$(".rcpTable").mouseleave(function(){
	$(this).find(".intro").hide();
})
</script>
