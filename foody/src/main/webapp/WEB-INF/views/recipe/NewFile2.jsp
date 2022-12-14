<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/config.jsp" %>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo:wght@700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" /></head>
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Inter&display=swap" rel="stylesheet" /></head>




<style>

	.header {
		width: 100%;
		height: 157px;
		background: rgba(249,235,200,1);
		opacity: 1;
		position: relative;
		top: 0px;
		left: 0px;
		overflow: hidden;
	}
  
	.bodycontainer{
		width:100%;
		height:2000px;
		float:left;
	}
  
	.content{
		width:70%;
		height:100%;
		float:left;
	}
  
	.bin-left{
		width:15%;
		height:100%;
		float:left;
	}
  
	.bin-right{
	  	width:15%;
	  	height:100%;
	  	float:right;
  	}
  
 	.content-header{
	  	width:100%;
	  	height:8%;
	  	font-size:35px;
  	}
	.bin-top{
	  	width:80%;
	  	height:50%;
	}
	.contents{
	  	width:100%;
	  	height:93%;
	  	background-color: #EAEAEA;
	  	border-radius :50px;
	}
  	.headerImg{
	  	width:50px;
	  	height:50px;
	  	float:left;
	  	margin-left:50px;
  	}
  	.headerMsg{
	  	margin-left:5px;
	  	color: #8C9D7C;
  	}
  	.content-binleft{
	  	width:2%;
	  	height:100%;
	  	float:left;
	}
  	.content-binrignt{
  		width:2%;
  		height:100%;
  		float:right;
  	}
  	.content-container1{
	  	width:96%;
	  	height:20%;
	  	border-radius: 50px;
	  	background-color: #FFFFFF;
	  	margin-top:28px;
	  	float:left;
  	}
  	.subtitle{
	  	font-size:30px;
	  	margin-left:60px;
  	}
  	.content-separated{
	  	width:90%;
	  	margin-left:50px;
  	}
  	.input1{
	  	width:55%;
	  	height:80%;
	  	margin-left:50px;
	  	float:left;
  	}
   	.input2{
	 	width:35%;
	 	height:80%;
	 	float:left;
  	}
  	.element{
  		font-size:25px;
		margin-left:15px;
  	}
  	.element-container{
  		width:25%;
  		height:90%;
  		float:left;
  	}
  	.element-input{
		width:95%;
		height:80px;
		outline:0px;
		border-color:#F1F1F1; 
		border-radius:8px;
		background-color:#F1F1F1;
		font-size:30px;
	}
	
	input[type="text"] {
	    font-size: 22px;
	    color: #2e2e2e;
	    height: 35px;
	    border: 0px solid #F1F1F1;
	    padding: 0 0 0 10px;
	    border-radius:8px; 
	}
	input[type="number"] {
	    font-size: 22px;
	    color: #2e2e2e;
	    height: 35px;
	    border: 0px solid #F1F1F1;
	    padding: 0 0 0 10px;
	    border-radius:8px; 
	}
	
	select{
		height:30px;
		font-size:20px;
		border-radius: 5px; 
	}
	
	.element-input-container{
  		width:70%;
  		height:90%;
  		float:left;
  	}
  	
  	.thumbnail{
  		margin-left:20px;
  	}
  	
  	select option[value=""][disabled] {
		display: none;
	}
  	
  	.addButton{
  		width:120px;
  		height:40px;
  		font-size:20px;
  		background-color: #DAE5D0;
  		border: 0px;
  		border-radius:8px;
  	}
  	.input_name{
  		height:40px;
		font-size:20px;
		border-radius: 5px; 
		border: 1px solid #DAE5D0;
		font-size: 22px;
	    padding: 0 0 0 10px;
  	}
  
</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
	<script type="text/javascript">
		
		var num=0; //???????????? ???????????? weight?????? ??????????????? num
		var options;
		var userNickname= String("${loginInfo.nik_name}");
		
		// -------------------???????????? ???????????? ?????? JS----------------------
		$(function(){
			$("#mainCate_drop").on("change", function(){
				$.ajax({
					url: "mainCate_drop.action",
					type: 'post',
					data:{
						num:$("#mainCate_drop :selected").val() //????????? ??????????????? value???
					},
					success: function(data){
						$("#ingredientName_drop option").remove(); 
						$("#subCate_drop option").remove();
						$("#ingredientName_drop").append("<option value='' disabled selected>?????????</option>");
						$("#subCate_drop").append("<option value='' selected>????????????</option>"); //???????????? ????????? ???????????? ???????????? ?????????
						
						if(data){
							for(var i=0; i< data.length; i++){
								$("#ingredientName_drop").append("<option value="+(i+1)+">"+data[i]+"</option>");
							}//data(????????? ??????????????? value????????? ?????? ??????)?????? ????????? ???????????? ???????????? ?????????
						}
					},
					error:function(){
						alert("???????????? ?????? error");
					}
				});
			});
		});
		
		// -------------------????????? ???????????? ?????? JS----------------------
		$(function(){
			$("#ingredientName_drop").on("change", function(){
				$.ajax({
					url: "ingredientName_drop.action",
					type: 'post',
					data:{
						name:$("#ingredientName_drop :selected").text().toString() //????????? ????????? ?????????
					},
					success: function(data){
						$("#subCate_drop option").remove();
						$("#subCate_drop").append("<option value='' disabled selected>????????????</option>"); //?????????????????? ???????????? ?????????
						
						for(var i=0; i< data.length; i++){
							var detailOption_str ="<option value="; //???????????? ???????????? ????????? ?????? ?????????
						
							//1)??????????????? ?????? ??? <???. ??????(?????????)- ""(????????????)>
							if(data[i].detail === "" && (data.length === 1)){
								detailOption_str += data[i].no+" selected >????????????</option>"; 
							}
							//2)??????????????? ????????? ??? ??? ""??? ???????????? ?????? ??? <???. ???(?????????)- ""(????????????),????????????(????????????),??????(????????????)>	
							else if(data[i].detail === ""){
								detailOption_str += data[i].no+">"+"??????</option>"; 
							}
							//3)??????????????? ????????? ""??? ?????? ??? <???. ??????(?????????)- ?????????(????????????),?????????(????????????)>
							else{
								detailOption_str += data[i].no+">"+data[i].detail+"</option>";
							}
							
							$("#subCate_drop").append(detailOption_str);
						}
					},
					error:function(){
						alert("????????? ?????? error");
					}
				});
			});
		});
		
		// -------------------???????????? ?????? ??? '??????'?????? ??????(??????) JS----------------------
		function cateAdd(){
		
			//???????????? 3??? ??? ???????????? ????????? ?????? ??????
			if($("#mainCate_drop :selected").val() == "" ||$("#ingredientName_drop :selected").val() == ""||$("#subCate_drop :selected").val() == ""){
				alert("??????????????? ??? ???????????????");
			}
			else{
				$.ajax({
					url: "searchName_drop.action", 
					type: 'post',
					data:{
					},
					success: function(data){
						for(var i=0; i< data.length; i++){
							//????????? ????????? allergy_no?????? 0??? ?????? ???, ???????????? ?????????
							var allergyCaution ="";
							
							if(data[i].allergy_no == 0){
								allergyCaution = "";
							}else{
								allergyCaution ="????????? ??????";
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
												+'(??????: '+'<input type="text" name="quantity">'+')'
												+'<input type="button" class="deleteSpan" value="??????">'
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
											+'(??????: '+'<input type="text" name="quantity">'+')'
											+'<input type="button" class="deleteSpan" value="??????">'
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
									// ----------------???????????? ??????JS----------------------
									var idStr = "#weight" + num;
									var weight = 0;
									
									$(idStr).on("keyup", function() {
										
										var sel_ingre = $(".addedSpan");
										var sel_carbo=0; //????????? ?????? ???????????? ?????????
										var sel_protein=0; //????????? ?????? ????????? ?????????
										var sel_fat=0; //????????? ?????? ?????? ?????????
									
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
									alert("?????? ?????????????????????");
								}
							}
						}
						kcalUpdate();
					},
					error:function(){
						alert("???????????? ???????????? ?????? error");
					}

				});
			}	
		}
		// -------------------???????????? ???????????? ?????? JS----------------------
		$(function(){
			$.ajax({
				url: "searchName_drop.action",
				type: 'post',
				data:{
				},
				success: function(data){
					for(var i=0; i< data.length; i++){
						if(data[i].detail==""){
							var searchOption_str ='<option data-no='+data[i].no+' value="'+data[i].name+'" ></option>'; //???????????? ???????????? ????????? ?????? ?????????
						}else{
							var searchOption_str ='<option data-no='+data[i].no+' value="'+data[i].name+'('+data[i].detail+')" ></option>'; //???????????? ???????????? ????????? ?????? ?????????
						}
						
						$("#searchName_drop").append(searchOption_str);
					}
					
				},
				error:function(){
					alert("???????????? error");
				}
			});
		});
		// -------------------serving ?????? ??? JS----------------------
		$(function(){
		  $('#serving').on('input', function() {
			  kcalUpdate();
		  });
		});
		// -------------------???????????? ?????? ??? '??????'?????? ??????(??????) JS----------------------
		function cateAdd(){
		
			//???????????? 3??? ??? ???????????? ????????? ?????? ??????
			if($("#mainCate_drop :selected").val() == "" ||$("#ingredientName_drop :selected").val() == ""||$("#subCate_drop :selected").val() == ""){
				alert("??????????????? ??? ???????????????");
			}
			else{
				$.ajax({
					url: "searchName_drop.action", 
					type: 'post',
					data:{
					},
					success: function(data){
						for(var i=0; i< data.length; i++){
							//????????? ????????? allergy_no?????? 0??? ?????? ???, ???????????? ?????????
							var allergyCaution ="";
							
							if(data[i].allergy_no == 0){
								allergyCaution = "";
							}else{
								allergyCaution ="????????? ??????";
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
												+'(??????: '+'<input type="text" name="quantity">'+')'
												+'<input type="button" class="deleteSpan" value="??????">'
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
											+'(??????: '+'<input type="text" name="quantity">'+')'
											+'<input type="button" class="deleteSpan" value="??????">'
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
									// ----------------???????????? ??????JS----------------------
									var idStr = "#weight" + num;
									var weight = 0;
									
									$(idStr).on("keyup", function() {
										
										var sel_ingre = $(".addedSpan");
										var sel_carbo=0; //????????? ?????? ???????????? ?????????
										var sel_protein=0; //????????? ?????? ????????? ?????????
										var sel_fat=0; //????????? ?????? ?????? ?????????
									
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
									alert("?????? ?????????????????????");
								}
							}
						}
						kcalUpdate();
					},
					error:function(){
						alert("???????????? ???????????? ?????? error");
					}

				});
			}	
		}
		
		// -------------------?????? ?????? ??? '??????'?????? ??????(??????) JS----------------------
		function searchAdd(){
			var sel_no = $('#searchName_drop [value="'+$("#search").val()+'"]').data('no'); //number
			
			$.ajax({
				url: "searchName_drop.action", 
				type: 'post',
				data:{
				},
				success: function(data){
					for(var i=0; i< data.length; i++){
						//????????? ????????? allergy_no?????? 0??? ?????? ???, ???????????? ?????????
						var allergyCaution ="";
						
						if(data[i].allergy_no == 0){
							allergyCaution = "";
						}else{
							allergyCaution ="????????? ??????";
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
											+'(??????: '+'<input type="text" name="quantity">'+')'
											+'<input type="button" class="deleteSpan" value="??????">'
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
											+'(??????: '+'<input type="text" name="quantity">'+')'
											+'<input type="button" class="deleteSpan" value="??????">'
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
								// ----------------???????????? ??????JS----------------------
								var idStr = "#weight" + num;
								var weight = 0;
								$(idStr).on("keyup", function() {
									
									var sel_ingre = $(".addedSpan");
									var sel_carbo=0; //????????? ?????? ???????????? ?????????
									var sel_protein=0; //????????? ?????? ????????? ?????????
									var sel_fat=0; //????????? ?????? ?????? ?????????
								
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
								alert("?????? ?????????????????????");
							}
						}
					}
					kcalUpdate();
					
				},
				error:function(){
					alert("???????????? ???????????? ?????? error");
				}

			});
			
		}
		
		// -------------------?????? ?????? JS----------------------
		function overlapCheck(data){								
			for(var j=0; j<$(".addedSpan").length; j++){
				if($(".addedSpan")[j].dataset.no == data){
					return false;
				}
			}
			return true;
		};
		
		// -------------------?????? ??????1 JS----------------------
		$(function(){
			options={
				title: {
					text: "?????????: 0kcal"
				},
				data: [{
					type: "doughnut",
					innerRadius: "40%",
					showInLegend: false,
					legendText: "{label}",
					indexLabel: "{label}: #percent%",
					dataPoints: [
						{ label: "????????????", y: 50},
						{ label: "?????????", y: 50},
						{ label: "??????", y: 50}
					]
				}]
			};
			$("#chartContainer").CanvasJSChart(options);  
		});
		
		// -------------------?????? ??????2 JS----------------------
		$(function(){
			
			options={
				title: {
					text:userNickname+" ?????? ?????? ?????? ?????????: "+${cal}+"kcal"
				},
				data: [{
					type: "doughnut",
					innerRadius: "40%",
					showInLegend: false,
					legendText: "{label}",
					indexLabel: "{label}: #percent%",
					dataPoints: [
						{ label: "?????? ?????? ?????????", y: ${cal}},
						{ label: "????????? ?????????", y: 0}
					]
				}]
			};
			$("#chartContainer2").CanvasJSChart(options);  
		});
		
		// -------------------????????? ?????????????????? JS----------------------
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
						text: "?????????: "+chart_kcal+"kcal"
					},
					data: [{
						type: "doughnut",
						innerRadius: "40%",
						showInLegend: false,
						legendText: "{label}",
						indexLabel: "{label}: #percent%",
						dataPoints: [
							{ label: "????????????", y: chart_carbo},
							{ label: "?????????", y: chart_protein},
							{ label: "??????", y: chart_fat}
						]
					}]
				};
			$("#chartContainer").CanvasJSChart(options); 
			
			var dayKcal = ${cal};
			var leftKcal = dayKcal-chart_kcal;
			
			options2={
					title: {
						text:  userNickname+" ?????? ?????? ?????? ?????????: "+dayKcal+"kcal"
					},
					data: [{
						type: "doughnut",
						innerRadius: "40%",
						showInLegend: false,
						legendText: "{label}",
						indexLabel: "{label}: #percent%",
						dataPoints: [
							{ label: "?????? ?????????", y: leftKcal},
							{ label: "????????? ?????????", y: chart_kcal}
						]
					}]
				};
			$("#chartContainer2").CanvasJSChart(options2); 
		}
	
		// -------------------????????? ????????? ????????? ????????? ??????(??????) JS----------------------
		
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
		
		// -------------------???????????? div ????????? ??????(??????)----------------------
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
				append_str += '<input type="button" data-val="'+pNum+'" class="deleteProcess" value="??????">'+'</div>'
				
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
		
		// ------------------?????????+?????? div ????????? ??????(??????)----------------------
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
		
		// -------------------STEP ?????? ???????????? ??????(??????) JS----------------------
		function changeStepNum(processCount){
			for(var i=0; i<processCount; i++){
			   $(".stepNum span").eq(i).text("STEP"+(i+1));
			}
		}
		
		// ----------imgupload(input ????????? ????????? ???) ?????? ?????? ??????(??????) JS------------
		function clickevent(input){
			$("#imgupload"+input).trigger('click');
		}
		
		// ----------pictureUpload(input ????????? ????????? ???) ?????? ?????? ??????(??????) JS------------
		function clickeventPic(input){
			$("#pictureUpload"+input).trigger('click');
		}
		
		
		// -------------------???????????? ??????????????? 3??? ????????? ?????? JS----------------------
		$(function(){
			for(var i=0; i<3; i++){
				makeProcessDiv();
				recipePicture(); 
			}
		});
		
		// -------------------JS----------------------
		function goSave(){
			if($("#name").val().trim() == ''){ // ????????? ??????
				alert('???????????? ????????? ?????????.');
				$("#name").focus();
				return false;
			}
			if($("#intro").val().trim() == ''){ // ?????? ??????
				alert('??????????????? ????????? ?????????.');
				$("#intro").focus();
				return false;
			}
			if($("#time").val().trim() == ''){ // ?????? ??????
				alert('??????????????? ????????? ?????????.');
				$("#time").focus();
				return false;
			}
			
			if(document.getElementsByClassName('addedSpan').length == 0){
				alert('????????? ???????????? ???????????????');
				return false;
			}
			
			for(i=0;i<processCount;i++){
				var textValue = document.getElementsByName('content')[i].value;
				if(textValue == "" | textValue == null){
					alert("?????? ????????? ???????????? ???????????????");

					return false;
				}
			}
			
			var fileCheck = document.getElementById("pictureUpload0").value;
			if(!fileCheck){
				alert("????????? ????????? ??????????????????");
				return false;
			}
		}

		
	</script>
</head>

<body>
	<%@ include file="../common/navBar.jsp" %>
	<div class="bodycontainer" style="float:left;">
		<div class="bin-left"></div>
		<div class="content">
			<div class="content-header">
				<div class="bin-top"></div>
				<img src="../resources/img/Register.png" class="headerImg">
				<span class="headerMsg">??? ????????? ??????</span>
			</div>
			<div class="contents">
				<div class="content-binleft"></div>
				<div class="content-container1">
					<div class="content-bin-top" style="width:100%; height:8%;"></div>
					<span class="subtitle">?????? ??????</span>
					<hr class="content-separated" size="3px" color="#DAE5D0">
					<div class="input1">
						<div style="width:100%; height:8%;"></div>
						<div class="element-container">
							<label class="element" for="name">?????????</label><br><br>
							<label class="element" for="intro">?????? ??????</label><br><br>
							<label class="element" for="type">?????? ??????</label><br><br>
							<label class="element" for="time">?????? ??????</label><br><br>
						</div>
						<div class="element-input-container">
							<div style="width:100%; height:1%;"></div>
							<input class="element-input" type="text" id=name name="name"><br><br>
							<div style="width:100%; height:1.5%;"></div>
							<input class="element-input" type="text" size="30" id=intro name="intro" ><br><br>
							<div style="width:100%; height:1.5%;"></div>
							 <select name="type">
							   	<option value=1>???</option>
							   	<option value=2>???/??????</option>
							   	<option value=3>??????/??????</option>
							   	<option value=4>???</option>
							   	<option value=5>??????/??????/?????????</option>
							   	<option value=6>??????</option>
							   	<option value=7>??????</option>
							   	<option value=8>?????????/??????</option>
							   	<option value=9>??????</option>
							   	<option value=10>???</option>
							   	<option value=11>??????/?????????</option>
							   	<option value=12>??????/??????/??????</option>
							   	<option value=13>?????????/??????</option>
							   	<option value=14>??????</option>
							   	<option value=15>????????????/?????????</option>
							   	<option value=16>???/??????</option>
							   	<option value=17>?????????</option>
							   	<option value=18>??????</option>
							   	<option value=19>?????????/?????????</option>
						  	</select><br><br>
						  	<div style="width:100%; height:1.5%;"></div>
						  	<input class="element-input" style="width:50%;" type="number" id="time" name="time" min="1">
						  	<label class="element" for="time" style="margin-left:2px;">???</label>
						</div>
					</div>
				</div>
				<div class="content-container1">
					<div class="content-bin-top" style="width:100%; height:8%;"></div>
					<span class="subtitle">?????? ??????</span>
					<hr class="content-separated" size="3px" color="#DAE5D0">
					<div class="input1" style="width:90%">
						<div style="width:100%; height:8%;"></div>
						<div style="width:100%; height:20%; float:left">
							<div class="element-container"  style="width:15%">
								<label class="element">??????</label>
							</div>
							<select id="mainCate_drop" style="width:250px; height:40px; margin-right:10px">
							    <option value="" disabled selected>??????</option>
							   	<option value=1>?????? ??? ??? ??????</option>
							   	<option value=2>?????? ??? ?????????</option>
							   	<option value=3>??????</option>
							   	<option value=4>??????</option>
							   	<option value=5>????????? ??? ?????????</option>
							   	<option value=6>?????????</option>
							   	<option value=7>?????????</option>
							   	<option value=8>?????????</option>
							   	<option value=9>??????</option>
							   	<option value=10>??????</option>
							   	<option value=11>????????? ??? ?????? ?????????</option>
							   	<option value=12>?????????</option>
							   	<option value=13>?????? ??? ????????????</option>
							   	<option value=14>?????????</option>
							   	<option value=15>??????</option>
							   	<option value=16>?????????</option>
							   	<option value=17>??????</option>
							   	<option value=18>????????????</option>
							   	<option value=19>??????????????????</option>
							   	<option value=20>??????</option>
							   	<option value=21>?????????</option>
							   	<option value=22>?????????</option>
							   	<option value=23>???????????????</option>
							   	<option value=24>??????</option>
							   	<option value=25>??????</option>
							</select>
							
							<!-- ?????????(ingredientName_drop) -->
							<select id="ingredientName_drop" style="width:250px; height:40px; margin-right:10px">
			   					<option value="">?????????</option>
			   				</select>
			   				
			   				<!-- ????????????(subCate_drop) -->
							<select id="subCate_drop" style="width:250px; height:40px; margin-right:10px">
								<option value="" >????????????</option>
							</select>
							
							<!-- ???????????? -->
							<input class="addButton" type="button" value="??????" onclick="cateAdd()"><br>
						</div>
						<div style="width:100%; height:20%; float:right">
							<div class="element-container"  style="width:15%;"></div>
							<label class="element">??????</label>
							<input class="input_name" list="searchName_drop" name="search" id="search">
					   		<datalist id="searchName_drop"></datalist>
					   		
					   		<input class="addButton"  type="button" value="??????" onclick="searchAdd()"><br>
					   		
						</div>
					</div>
					<div class="content-binright"></div>
				</div>
			</div>
			<div class="bin-right"></div>
		</div>
		</div>
</body>
</html>