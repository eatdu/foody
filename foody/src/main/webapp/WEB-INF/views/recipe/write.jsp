<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
	<head>
	<link rel="stylesheet" type="text/css" href="/foody/resources/css/board.css">
	<link rel="stylesheet" type="text/css" href="/foody/resources/css/basic.css">
	<link rel="stylesheet" type="text/css" href="/foody/resources/css/layout.css">
	<link rel="stylesheet" type="text/css" href="/foody/resources/css/manage.css">
		<meta charset="UTF-8">
		<title>레시피 등록</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
		<script type="text/javascript">
			
			var num=0; //추가되는 재료들의 weight값을 구분해주는 num
			var options;
			var userNickname= String("${loginInfo.nik_name}");
			
			// -------------------재료종류 드롭다운 클릭 JS----------------------
			$(function(){
				$("#mainCate_drop").on("change", function(){
					$.ajax({
						url: "mainCate_drop.action",
						type: 'post',
						data:{
							num:$("#mainCate_drop :selected").val() //선택한 재료종류의 value값
						},
						success: function(data){
							$("#ingredientName_drop option").remove(); 
							$("#subCate_drop option").remove();
							$("#ingredientName_drop").append("<option value='' disabled selected>재료명</option>");
							$("#subCate_drop").append("<option value='' selected>세부분류</option>"); //재료종류 바뀌면 재료명과 세부분류 초기화
							
							if(data){
								for(var i=0; i< data.length; i++){
									$("#ingredientName_drop").append("<option value="+(i+1)+">"+data[i]+"</option>");
								}//data(선택한 재료종류의 value값으로 찾은 결과)값을 하나씩 드롭다운 리스트에 넣어줌
							}
						},
						error:function(){
							alert("재료종류 클릭 error");
						}
					});
				});
			});
			
			// -------------------재료명 드롭다운 클릭 JS----------------------
			$(function(){
				$("#ingredientName_drop").on("change", function(){
					$.ajax({
						url: "ingredientName_drop.action",
						type: 'post',
						data:{
							name:$("#ingredientName_drop :selected").text().toString() //선택한 재료명 이름값
						},
						success: function(data){
							$("#subCate_drop option").remove();
							$("#subCate_drop").append("<option value='' disabled selected>세부분류</option>"); //재료명바뀌면 세부분류 초기화
							
							for(var i=0; i< data.length; i++){
								var detailOption_str ="<option value="; //세부분류 드롭다운 옵션에 넣을 스트링
							
								//1)세부분류가 없을 때 <예. 과당(재료명)- ""(세부분류)>
								if(data[i].detail === "" && (data.length === 1)){
									detailOption_str += data[i].no+" selected >분류없음</option>"; 
								}
								//2)세부분류가 있는데 그 중 ""이 포함되어 있을 때 <예. 꿀(재료명)- ""(세부분류),아카시아(세부분류),잡화(세부분류)>	
								else if(data[i].detail === ""){
									detailOption_str += data[i].no+">"+"기본</option>"; 
								}
								//3)세부분류가 있는데 ""이 없을 때 <예. 귀리(재료명)- 오트밀(세부분류),쌀귀리(세부분류)>
								else{
									detailOption_str += data[i].no+">"+data[i].detail+"</option>";
								}
								
								$("#subCate_drop").append(detailOption_str);
							}
						},
						error:function(){
							alert("재료명 클릭 error");
						}
					});
				});
			});
			
			
			// -------------------이름검색 드롭다운 클릭 JS----------------------
			$(function(){
				$.ajax({
					url: "searchName_drop.action",
					type: 'post',
					data:{
					},
					success: function(data){
						for(var i=0; i< data.length; i++){
							if(data[i].detail==""){
								var searchOption_str ='<option data-no='+data[i].no+' value="'+data[i].name+'" ></option>'; //이름검색 드롭다운 옵션에 넣을 스트링
							}else{
								var searchOption_str ='<option data-no='+data[i].no+' value="'+data[i].name+'('+data[i].detail+')" ></option>'; //이름검색 드롭다운 옵션에 넣을 스트링
							}
							
							$("#searchName_drop").append(searchOption_str);
						}
						
					},
					error:function(){
						alert("이름검색 error");
					}
				});
			});
			// -------------------serving 바뀔 때 JS----------------------
			$(function(){
			  $('#serving').on('input', function() {
				  kcalUpdate();
			  });
			});
			// -------------------드롭다운 선택 후 '추가'버튼 클릭(호출) JS----------------------
			function cateAdd(){
			
				//드롭다운 3개 다 선택되어 있어야 추가 가능
				if($("#mainCate_drop :selected").val() == "" ||$("#ingredientName_drop :selected").val() == ""||$("#subCate_drop :selected").val() == ""){
					alert("카테고리를 다 선택하세요");
				}
				else{
					$.ajax({
						url: "searchName_drop.action", 
						type: 'post',
						data:{
						},
						success: function(data){
							for(var i=0; i< data.length; i++){
								//선택한 재료의 allergy_no값이 0이 아닐 때, 주의표시 띄워줌
								var allergyCaution ="";
								
								if(data[i].allergy_no == 0){
									allergyCaution = "";
								}else{
									allergyCaution ="알러지 주의";
								}
								
								if(data[i].no == $("#subCate_drop :selected").val()){
									if(overlapCheck(data[i].no)){
										if(data[i].detail === ""){
											$("#addedIngredientList").append(
													'<span class="addedSpan"'
													+' data-no="'+data[i].no+'" data-name="'+data[i].name+'"'
													+' data-carbo="'+data[i].carbo+'" data-protein="'+data[i].protein+'" data-fat="'+data[i].fat+'"'
													+' data-carbokcal="'+data[i].carbo+'"data-proteinkcal="'+data[i].protein+'" data-fatkcal="'+data[i].fat+'"'
													+' data-allergy="'+data[i].allergy_no+'">'
													+data[i].name
													+'<input type="hidden" name=ingredient_no value="'+data[i].no+'">'
													+'<input type="number" value="100" min="0" name="weight" data-no="'+data[i].no+'" id="weight'
													+num+'"> g'
													+'(수량: '+'<input type="text" name="quantity">'+')'
													+'<input type="button" class="deleteSpan" value="삭제">'
													+allergyCaution
													+'<br>'
													+'</span>'
											);
											$(".deleteSpan").off('click');
											$(".deleteSpan").click(function() {
												var idx = $(this).index(".deleteSpan");
												$(".addedSpan").eq(idx).remove();
												kcalUpdate();
											});
										}
										else{
											$("#addedIngredientList").append(
												'<span class="addedSpan"'
												+' data-no="'+data[i].no+'" data-name="'+data[i].name+'"'
 												+' data-carbo="'+data[i].carbo+'" data-protein="'+data[i].protein+'" data-fat="'+data[i].fat+'"'
												+' data-carbokcal="'+data[i].carbo+'"data-proteinkcal="'+data[i].protein+'" data-fatkcal="'+data[i].fat+'"'
												+' data-allergy="'+data[i].allergy_no+'">'
												+data[i].name+'('+data[i].detail+')'
												+'<input type="hidden" name=ingredient_no value="'+data[i].no+'">'
												+'<input type="number" value="100" min="0" name="weight" data-no="'+data[i].no+'" id="weight'
												+num+'"> g'
												+'(수량: '+'<input type="text" name="quantity">'+')'
												+'<input type="button" class="deleteSpan" value="삭제">'
												+allergyCaution
												+'<br>'
												+'</span>'
											);
											$(".deleteSpan").off('click');
											$(".deleteSpan").click(function() {
												var idx = $(this).index(".deleteSpan");
												$(".addedSpan").eq(idx).remove();
												kcalUpdate();
											});										
										}
										// ----------------입력감지 코드JS----------------------
										var idStr = "#weight" + num;
										var weight = 0;
										
										$(idStr).on("keyup", function() {
											
											var sel_ingre = $(".addedSpan");
											var sel_carbo=0; //선택한 값의 탄수화물 칼로리
											var sel_protein=0; //선택한 값의 단백질 칼로리
											var sel_fat=0; //선택한 값의 지방 칼로리
										
											weight = $(idStr).val();
											
											for(var i=0; i<sel_ingre.length;i++){
												if(sel_ingre[i].dataset.no == $(idStr).data('no')){
													
													sel_carbo = Number(sel_ingre[i].dataset.carbo)/100 * weight ;
													sel_protein = Number(sel_ingre[i].dataset.protein)/100 * weight;
													sel_fat = Number(sel_ingre[i].dataset.fat)/100 * weight;
													
													sel_ingre[i].dataset.carbokcal = sel_carbo;
													sel_ingre[i].dataset.proteinkcal = sel_protein;
													sel_ingre[i].dataset.fatkcal = sel_fat;
												}
											}
											kcalUpdate();
										});
										num++;
									}else{
										alert("이미 등록되었습니다");
									}
								}
							}
							kcalUpdate();
						},
						error:function(){
							alert("카테고리 추가버튼 클릭 error");
						}

					});
				}	
			}
			
			// -------------------이름 검색 후 '추가'버튼 클릭(호출) JS----------------------
			function searchAdd(){
				var sel_no = $('#searchName_drop [value="'+$("#search").val()+'"]').data('no'); //number
				
				$.ajax({
					url: "searchName_drop.action", 
					type: 'post',
					data:{
					},
					success: function(data){
						for(var i=0; i< data.length; i++){
							//선택한 재료의 allergy_no값이 0이 아닐 때, 주의표시 띄워줌
							var allergyCaution ="";
							
							if(data[i].allergy_no == 0){
								allergyCaution = "";
							}else{
								allergyCaution ="알러지 주의";
							}
							
							if(data[i].no == sel_no){
								if(overlapCheck(data[i].no)){
									if(data[i].detail === ""){
										$("#addedIngredientList").append(
												'<span class="addedSpan"'
												+' data-no="'+data[i].no+'" data-name="'+data[i].name+'"'
												+' data-carbo="'+data[i].carbo+'" data-protein="'+data[i].protein+'" data-fat="'+data[i].fat+'"'
												+' data-carbokcal="'+data[i].carbo+'"data-proteinkcal="'+data[i].protein+'" data-fatkcal="'+data[i].fat+'"'
												+' data-allergy="'+data[i].allergy_no+'">'
												+data[i].name
												+'<input type="hidden" name=ingredient_no value="'+data[i].no+'">'
												+'<input type="number" value="100" min="0" name="weight" data-no="'+data[i].no+'" id="weight'
												+num+'"> g'
												+'(수량: '+'<input type="text" name="quantity">'+')'
												+'<input type="button" class="deleteSpan" value="삭제">'
												+allergyCaution
												+'<br>'
												+'</span>'
											);
										$(".deleteSpan").off('click');
										$(".deleteSpan").click(function() {
											var idx = $(this).index(".deleteSpan");
											$(".addedSpan").eq(idx).remove();
											kcalUpdate();
										});
									}
									else{
										$("#addedIngredientList").append(
												'<span class="addedSpan"'
												+' data-no="'+data[i].no+'" data-name="'+data[i].name+'"'
												+' data-carbo="'+data[i].carbo+'" data-protein="'+data[i].protein+'" data-fat="'+data[i].fat+'"'
												+' data-carbokcal="'+data[i].carbo+'"data-proteinkcal="'+data[i].protein+'" data-fatkcal="'+data[i].fat+'"'
												+' data-allergy="'+data[i].allergy_no+'">'
												+data[i].name+'('+data[i].detail+')'
												+'<input type="hidden" name=ingredient_no value="'+data[i].no+'">'
												+'<input type="number" value="100" min="0" name="weight" data-no="'+data[i].no+'" id="weight'
												+num+'"> g'
												+'(수량: '+'<input type="text" name="quantity">'+')'
												+'<input type="button" class="deleteSpan" value="삭제">'
												+allergyCaution
												+'<br>'
												+'</span>'
											);
										$(".deleteSpan").off('click');
										$(".deleteSpan").click(function() {
											var idx = $(this).index(".deleteSpan");
											$(".addedSpan").eq(idx).remove();
											kcalUpdate();
										});
									}
									// ----------------입력감지 코드JS----------------------
									var idStr = "#weight" + num;
									var weight = 0;
									$(idStr).on("keyup", function() {
										
										var sel_ingre = $(".addedSpan");
										var sel_carbo=0; //선택한 값의 탄수화물 칼로리
										var sel_protein=0; //선택한 값의 단백질 칼로리
										var sel_fat=0; //선택한 값의 지방 칼로리
									
										weight = $(idStr).val();
										
										for(var i=0; i<sel_ingre.length;i++){
											if(sel_ingre[i].dataset.no == $(idStr).data('no')){
												
												sel_carbo = Number(sel_ingre[i].dataset.carbo)/100 * weight ;
												sel_protein = Number(sel_ingre[i].dataset.protein)/100 * weight;
												sel_fat = Number(sel_ingre[i].dataset.fat)/100 * weight;
												
												sel_ingre[i].dataset.carbokcal = sel_carbo;
												sel_ingre[i].dataset.proteinkcal = sel_protein;
												sel_ingre[i].dataset.fatkcal = sel_fat;
											}
 										}
										kcalUpdate();
									});
									num++;
								}else{
									alert("이미 등록되었습니다");
								}
							}
						}
						kcalUpdate();
						
					},
					error:function(){
						alert("카테고리 추가버튼 클릭 error");
					}

				});
				
			}
			
			// -------------------중복 체크 JS----------------------
			function overlapCheck(data){								
				for(var j=0; j<$(".addedSpan").length; j++){
					if($(".addedSpan")[j].dataset.no == data){
						return false;
					}
				}
				return true;
			};
			
			// -------------------도넛 차트1 JS----------------------
			$(function(){
				options={
					title: {
						text: "칼로리: 0kcal"
					},
					data: [{
						type: "doughnut",
						innerRadius: "40%",
						showInLegend: false,
						legendText: "{label}",
						indexLabel: "{label}: #percent%",
						dataPoints: [
							{ label: "탄수화물", y: 50},
							{ label: "단백질", y: 50},
							{ label: "지방", y: 50}
						]
					}]
				};
				$("#chartContainer").CanvasJSChart(options);  
			});
			
			// -------------------도넛 차트2 JS----------------------
			$(function(){
				
				options={
					title: {
 						text:userNickname+" 님의 하루 권장 칼로리: "+${cal}+"kcal"
					},
					data: [{
						type: "doughnut",
						innerRadius: "40%",
						showInLegend: false,
						legendText: "{label}",
						indexLabel: "{label}: #percent%",
						dataPoints: [
							{ label: "하루 권장 칼로리", y: ${cal}},
							{ label: "음식의 칼로리", y: 0}
						]
					}]
				};
				$("#chartContainer2").CanvasJSChart(options);  
			});
			
			// -------------------실시간 칼로리계산기 JS----------------------
			function kcalUpdate() {
				var sel_ingre = $(".addedSpan");
				var sum_carbo=0;
				var sum_protein=0;
				var sum_fat=0;
				var sum_kcal=0;
				var serving= Number($('#serving').val());
				
				for(var i=0; i<sel_ingre.length;i++){
					sum_carbo+= Number(sel_ingre[i].dataset.carbokcal*4);
					sum_protein += Number(sel_ingre[i].dataset.proteinkcal*4);
					sum_fat += Number(sel_ingre[i].dataset.fatkcal*9);
				}
				sum_kcal = sum_carbo+ sum_protein + sum_fat;
				
				var chart_carbo;
				var chart_protein;
				var chart_fat;
				
				if(sum_kcal == 0){
					chart_carbo= 50;
					chart_protein= 50;
					chart_fat= 50;
				}else{
					chart_carbo= Math.round(sum_carbo/serving*10)/10;
					chart_protein= Math.round(sum_protein/serving*10)/10;
					chart_fat= Math.round(sum_fat/serving *10)/10;
				}
				
				chart_kcal = Math.round(sum_kcal/serving);
				
				options={
						title: {
							text: "칼로리: "+chart_kcal+"kcal"
						},
						data: [{
							type: "doughnut",
							innerRadius: "40%",
							showInLegend: false,
							legendText: "{label}",
							indexLabel: "{label}: #percent%",
							dataPoints: [
								{ label: "탄수화물", y: chart_carbo},
								{ label: "단백질", y: chart_protein},
								{ label: "지방", y: chart_fat}
							]
						}]
					};
				$("#chartContainer").CanvasJSChart(options); 
				
				var dayKcal = ${cal};
				var leftKcal = dayKcal-chart_kcal;
				
				options2={
						title: {
							text:  userNickname+" 님의 하루 권장 칼로리: "+dayKcal+"kcal"
						},
						data: [{
							type: "doughnut",
							innerRadius: "40%",
							showInLegend: false,
							legendText: "{label}",
							indexLabel: "{label}: #percent%",
							dataPoints: [
								{ label: "남은 칼로리", y: leftKcal},
								{ label: "음식의 칼로리", y: chart_kcal}
							]
						}]
					};
				$("#chartContainer2").CanvasJSChart(options2); 
			}
		
			// -------------------버튼이 눌리면 이미지 프리뷰 코드(호출) JS----------------------
			
			function readURL(input,num1) {
				if (input.files && input.files[0]) {
					var reader = new FileReader();
					var id="processImg"+num1;
					reader.onload = function(e) {
						document.getElementById(id).src = e.target.result;
					};
					reader.readAsDataURL(input.files[0]);
				} else {
					document.getElementById(id).src = "";
				}
			}
			
			function readURL2(input,num1) {
				if (input.files && input.files[0]) {
					var reader = new FileReader();
					var id="additionalPic"+num1;
					reader.onload = function(e) {
						document.getElementById(id).src = e.target.result;
					};
					reader.readAsDataURL(input.files[0]);
				} else {
					document.getElementById(id).src = "";
				}
			}
			
			// -------------------조리과정 div 만드는 함수(호출)----------------------
            var pNum = 0;
            var processCount = 0;
            
			function makeProcessDiv(){
				var append_str ='<div class="process" id="process'+pNum+'" style="height: 150px; width: 1000px; padding:2.5px;">'
								+'<input type="file" data-val="'+pNum+'" name="photo" id="imgupload'+pNum+'" style="display:none"/>'
								+'<div class="stepNum" style="float:left;"><span>STEP'+(pNum+1)+'</span></div>'
								+'<div id="Imagebutton'+pNum+'" onclick="clickevent('+pNum+')" style="padding-top:0px; height: 140px; width: 220px; float:left; background-color:#ECECEC; text-align: center;">'
								+'<img id="processImg'+pNum+'" src="resources/img/PlusIcon.png" style="height: 140px; width: 220px; object-fit: cover;">'
								+'</div>'
								+'<textarea name="content" id="processText'+pNum+'" rows="5" cols="30" style="height: 140px; padding:0px; resize:none;"></textarea>'
				if(pNum>2){
					append_str += '<input type="button" data-val="'+pNum+'" class="deleteProcess" value="삭제">'+'</div>'
					
				}else{
					append_str += '</div>'
				}
				$('#processList').append(append_str);
				processCount++;
				changeStepNum(processCount);
				
				$("#imgupload"+pNum).change(function() {
					readURL(this,$(this).data('val'));
				}); 
				
				$(".deleteProcess").off('click');
				$(".deleteProcess").click(function() {
					var idx = $(this).index(".deleteProcess")+3;
					$('.process').eq(idx).remove();
					processCount--;
					changeStepNum(processCount);
				});
				
				pNum++;
				
			}
			
			// ------------------썸네일+사진 div 만드는 함수(호출)----------------------
			var PNum = 0;
			function recipePicture(){
				var append_str ='<span style="height: 140px; width: 230px;">'
								+'<input type="file" name="thumbnail" data-val="'+PNum+'" id="pictureUpload'+PNum+'" style="display:none"/>'	
								+'<span onclick="clickeventPic('+PNum+')" style="padding-top:0px; margin-right:20px; float:left; height: 140px; width: 220px; background-color:#ECECEC; text-align: center;">'
								+'<img id="additionalPic'+PNum+'" src="resources/img/PlusIcon.png" style="height: 140px; width: 220px; object-fit: cover;">'
								+'</span></span>'

				$('#recipePicture').append(append_str);
								
				$("#pictureUpload"+PNum).change(function() {
					readURL2(this,$(this).data('val'));
				}); 
				
				PNum++;
				
			}
			
			// -------------------STEP 숫자 바꿔주는 함수(호출) JS----------------------
			function changeStepNum(processCount){
				for(var i=0; i<processCount; i++){
				   $(".stepNum span").eq(i).text("STEP"+(i+1));
				}
			}
			
			// ----------imgupload(input 이미지 고르는 창) 뜨게 하는 함수(호출) JS------------
			function clickevent(input){
				$("#imgupload"+input).trigger('click');
			}
			
			// ----------pictureUpload(input 이미지 고르는 창) 뜨게 하는 함수(호출) JS------------
			function clickeventPic(input){
				$("#pictureUpload"+input).trigger('click');
			}
			
			
			// -------------------조리과정 기본적으로 3개 만드는 함수 JS----------------------
			$(function(){
				for(var i=0; i<3; i++){
					makeProcessDiv();
					recipePicture(); 
				}
			});
			
			// -------------------JS----------------------
			function goSave(){
				if($("#name").val().trim() == ''){ // 요리명 체크
					alert('요리명을 입력해 주세요.');
					$("#name").focus();
					return false;
				}
				if($("#intro").val().trim() == ''){ // 소개 체크
					alert('요리소개를 입력해 주세요.');
					$("#intro").focus();
					return false;
				}
				if($("#time").val().trim() == ''){ // 시간 체크
					alert('소요시간을 입력해 주세요.');
					$("#time").focus();
					return false;
				}
				
				if(document.getElementsByClassName('addedSpan').length == 0){
					alert('재료를 하나라도 추가하세요');
					return false;
				}
				
				for(i=0;i<processCount;i++){
					var textValue = document.getElementsByName('content')[i].value;
					if(textValue == "" | textValue == null){
						alert("과정 설명을 빠짐없이 기입하세요");

						return false;
					}
				}
				
				var fileCheck = document.getElementById("pictureUpload0").value;
				if(!fileCheck){
					alert("썸네일 파일을 추가해주세요");
					return false;
				}
			}

			
		</script>
		
	</head>
	
	<!-- 드롭다운 설명 텍스트 숨기기 -->
	<style>
		select option[value=""][disabled] {
			display: none;
		}
	</style>

	<body>
	<%@ include file="../common/navBar.jsp" %>
		<form id="frm" method="post" action="write.do" enctype="multipart/form-data" onsubmit="return goSave();">
			<!-- 요리명(name) -->
			요리명: <input type="text" id=name name="name" ><br>
			
			<!-- 소개(intro) -->
			소개: <input type="text" id=intro name="intro" ><br>
			
			<!-- 음식종류(type) -->
		 	음식종류:  
		    <select name="type">
			   	<option value=1>밥</option>
			   	<option value=2>떡/한과</option>
			   	<option value=3>만두/면류</option>
			   	<option value=4>국</option>
			   	<option value=5>나물/생채/샐러드</option>
			   	<option value=6>구이</option>
			   	<option value=7>볶음</option>
			   	<option value=8>밑반찬/김치</option>
			   	<option value=9>조림</option>
			   	<option value=10>찜</option>
			   	<option value=11>튀김/커틀릿</option>
			   	<option value=12>찌개/전골/스튜</option>
			   	<option value=13>도시락/간식</option>
			   	<option value=14>부침</option>
			   	<option value=15>샌드위치/햄버거</option>
			   	<option value=16>빵/과자</option>
			   	<option value=17>양념장</option>
			   	<option value=18>음료</option>
			   	<option value=19>그라탕/리조또</option>
		  		</select><br>
		  		
		  	<!-- 소요시간(time) -->
			소요시간: <input type="number" id="time" name="time" min="1">분<br>
			
			<!-- 재료 -->
			재료:
				<!-- 재료종류(mainCate_drop) -->
				<select id="mainCate_drop">
				    <option value="" disabled selected>종류</option>
				   	<option value=1>곡류 및 그 제품</option>
				   	<option value=2>감자 및 전분류</option>
				   	<option value=3>당류</option>
				   	<option value=4>두류</option>
				   	<option value=5>견과류 및 종실류</option>
				   	<option value=6>채소류</option>
				   	<option value=7>버섯류</option>
				   	<option value=8>과실류</option>
				   	<option value=9>육류</option>
				   	<option value=10>난류</option>
				   	<option value=11>어패류 및 기타 수산물</option>
				   	<option value=12>해조류</option>
				   	<option value=13>우유 및 유제품류</option>
				   	<option value=14>유지류</option>
				   	<option value=15>차류</option>
				   	<option value=16>음료류</option>
				   	<option value=17>주류</option>
				   	<option value=18>조미료류</option>
				   	<option value=19>조리가공품류</option>
				   	<option value=20>기타</option>
				   	<option value=21>갑각류</option>
				   	<option value=22>두족류</option>
				   	<option value=23>수산가공품</option>
				   	<option value=24>어류</option>
				   	<option value=25>패류</option>
				</select>
				
				<!-- 재료명(ingredientName_drop) -->
				<select id="ingredientName_drop">
			   		<option value="">재료명</option>
			   	</select>
			   	
			   	<!-- 세부분류(subCate_drop) -->
				<select id="subCate_drop">
					<option value="" >세부분류</option>
				</select>
				<input type="button" value="추가" onclick="cateAdd()"><br>
			
				<!-- 이름검색(searchName_drop) -->
				또는
				<input list="searchName_drop" name="search" id="search">
			   		<datalist id="searchName_drop">
			   		</datalist>
			   	<input type="button" value="추가" onclick="searchAdd()"><br>
				<!-- 인분(searving) -->
				<input type="number" id="serving" name="serving" min='1' value="1"> 인분 기준<br>
				
				<!-- 추가된 재료 리스트 -->
				<br><div id="addedIngredientList"></div><br>
				
			<!-- 영양 정보(차트 하나 더 넣게 되면 float:left 해줘야 함 -->
			영양정보:
			<div id="chartContainer" style="height: 200px; width: 50%;"></div>
			<br>
			<div id="chartContainer2" style="height: 200px; width: 50%;"></div>
			<br>
			
			<!-- 조리 과정 style 먹인거 나중에 다 빼기 -->
			조리과정:
			<div id="processList"></div>
			<div style="height: 40px; width: 180px;">
				<img id="addProcessButton" onclick="makeProcessDiv()" src="../resources/img/추가버튼.png" style="height: 40px; width: 180px;">
			</div>
			
			요리사진:
			<div id="recipePicture" style="height: 150px; width: 100%;">
			</div>
			
			 
			<!-- 팁(tip) -->
			<div>
				요리tip! &nbsp <input type="text" name="tip" ><br>
				
				<!-- 등록버튼(submit) -->
				<input type="submit" name ="submit" value="저장">
			</div>
		</form>
	</body>

</html>
