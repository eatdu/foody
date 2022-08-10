<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 등록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$(function(){
		$("#large_cate").change(function(){
			console.log($(this).val());
		});
	});
</script>
</head>
<body>
<form method="post" action="write.do">
   요리명: <input type="text" name = "name" ><br>
   소개: <input type="text" name = "intro" ><br>
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
   소요시간: <input type="number" name = "time" min ="1">분<br>
   재료:
   <select id="large_cate">
    <option value="none">===대분류===</option>
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
    <select name="ingredient_no">
    <option value="none">===리스트===</option>
   	<option value=1>귀리</option>
   	</select><br>
   <input type="number" name = "serving"  min='1'> 인분 기준<br>
   요리팁: <input type="text" name = "tip" ><br>
   <input type="submit" name ="submit">
</form>
   
</body>
</html>