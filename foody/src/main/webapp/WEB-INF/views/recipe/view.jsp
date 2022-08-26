<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>레시피 뷰</title>
	</head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
	<script type="text/javascript">
		var userNikname;
		var userDayKcal;
		$(function(){
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
	<body>
	레시피 번호: ${recipe.no}<br><br><br>
	
	<!-- 경로수정 해야하는데 모르겠음 -->
	<img src="${recipe.thumbnail}" style="width:250px; height:140px;"><br><br>
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
	열량: ${sumKcal}kcal  탄수화물: ${sumCarbo}g   단백질:${sumProtein}g 지방:${sumFat}g
	<br><br><br>
	<div id="chartContainer" style="height: 200px; width: 50%;"></div>
	<br>
	<div id="chartContainer2" style="height: 200px; width: 50%;"></div>
	<br>
	
	조리과정:
	<c:forEach var="dataMap" items="${processlist}" varStatus="status">
		<p><c:out value="Step${dataMap.order_no}"/>
		
		<c:if test="${not empty dataMap.photo}">
		<img src = "<c:out value="${dataMap.photo}"/>" style="width:250px; height:140px;">
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
		<img src = "<c:out value="${recipe.addedpicture1}"/>" style="width:250px; height:140px;">
	</c:if>
	<c:if test="${empty recipe.addedpicture2}">
		<img src = "<c:out value="/foody/resources/img/processImg.png"/>" style="width:250px; height:140px;">
	</c:if>
	
	</body>
</html>




