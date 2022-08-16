<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>레시피 등록</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script type="text/javascript">
			
			/*  <===== 페이지 표시 이름(변수명) =====>
					요리명(name) 
					소개(intro) 
					음식종류(type) 
					소요시간(time) 		   
					재료
					재료종류(mainCate_drop)
					재료명(ingredientName_drop)
					세부분류(subCate_drop)
					이름검색(searchName_drop)
					인분(searving)
					추가된 재료 리스트(addedIngredientList)
					인분(searving)
					팁(tip)
					등록버튼(submit)
					
				<===== function 명 =====>
					페이지(write.do/post)
					재료종류 드롭다운 클릭(mainCate_drop.action/post)
					재료명 드롭다운 클릭(ingredientName_drop.action/post)
					
				<===== function(호출) 명 =====>	
					분류검색 추가버튼 클릭(cateAdd)
					이름검색 추가버튼 클릭(searchAdd)
			*/ 
		
		
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
									detailOption_str += "'0' selected >분류없음</option>"; 
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
							var searchOption_str ="<option data-no="+data[i].no+" value='"+data[i].name+"("+data[i].detail+")'>"; //이름검색 드롭다운 옵션에 넣을 스트링
							
							
							$("#searchName_drop").append(searchOption_str);
						}
					},
					error:function(){
						alert("이름검색 error");
					}
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
						url: "ingredientName_drop.action", 
						type: 'post',
						data:{
							name:$("#ingredientName_drop :selected").text().toString() //추가 버튼을 눌러 선택한 이름값으로 해당 VO객체 가져옴(data)
						},
						success: function(data){
							for(var i=0; i< data.length; i++){
								
								//선택한 세부분류의 value 값이 0일때,즉 세부분류가 없을 때 (참고:재료명 드롭다운 클릭 JS)
								if(data[i].detail === ""){
									if($("#subCate_drop :selected").val() == "0"){
										$("#addedIngredientList").append(
												'<span class="addedSpan"'
												+' data-no="'+data[i].no+'" data-name="'+data[i].name+'"'
												+' data-carbo="'+data[i].carbo+'" data-protein="'+data[i].protein+'" data-fat="'+data[i].fat
												+'" data-allergy="'+data[i].allergy_no+'">'
												+data[i].name
												+'<input type="button" class="deleteSpan" value="삭제">'
												+'<br>'
												+'</span>'
										);
										$(".deleteSpan").off('click');
										$(".deleteSpan").click(function() {
											var idx = $(this).index(".deleteSpan");
											$(".addedSpan").eq(idx).remove();
										});
									}
								}
								else{
									if(data[i].no == $("#subCate_drop :selected").val()){
										$("#addedIngredientList").append(
												'<span class="addedSpan"'
												+' data-no="'+data[i].no+'" data-name="'+data[i].name+'"'
												+' data-carbo="'+data[i].carbo+'" data-protein="'+data[i].protein+'" data-fat="'+data[i].fat
												+'" data-allergy="'+data[i].allergy_no+'">'
												+data[i].name+'('+data[i].detail+')'
												+'<input type="button" class="deleteSpan" value="삭제">'
												+'<br>'
												+'</span>'
										);
										$(".deleteSpan").off('click');
										$(".deleteSpan").click(function() {
											var idx = $(this).index(".deleteSpan");
											$(".addedSpan").eq(idx).remove();
										});
									}
								}
							}
						},
						error:function(){
							alert("카테고리 추가버튼 클릭 error");
						}
					});
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
		<form method="post" action="write.do">
			<!-- 요리명(name) -->
			요리명: <input type="text" name="name" ><br>
			
			<!-- 소개(intro) -->
			소개: <input type="text" name="intro" ><br>
			
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
			소요시간: <input type="number" name="time" min="1">분<br>
			
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
				
				<!-- 추가된 재료 리스트 -->
				<br><div id="addedIngredientList"></div><br>
				
			<!-- 인분(searving) -->
				<input type="number" name="serving" min='1' value="1"> 인분 기준<br>	
				
			<!-- 팁(tip) -->
			요리tip! &nbsp <input type="text" name="tip" ><br>   
		
			<!-- 등록버튼(submit) -->
			<input type="submit" name ="submit">
		</form>
	</body>
</html>

