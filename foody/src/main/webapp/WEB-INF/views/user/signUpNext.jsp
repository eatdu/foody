<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title></title>
<style type="text/css">
    .img {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    overflow: hidden;
    }
    .jb-wrap {
        width: left;
        margin: 10px auto;
    }
    .jb-wrap img {
        width: 100%;
        vertical-align: middle;
    }
    .jb-text {
        padding: 5px 10px;
        background-color: yellow;
        text-align: center;
    }
</style>
<script>
	function goSave(){
		$("#frm").submit();
	}

</script>
</head>
<body>
 	${loginInfo.no}
   	<h3>회원가입</h3>
	<form action="signUpNext.do" method="post" name="frm" id="frm" enctype="multipart/form-data">
 	<input type="hidden" name="no" value="${loginInfo.no}">
	    <div class="jb-wrap">
	    	<h5>프로필사진</h5>
		    <input type="hidden" name="selfi">
	        <div class="jb-image"><input type="file" id="chooseFile" name="chooseFile" class="img-input" style="diplay:none;"></div>
	        <div class="img" >
	    </div>
		</div>
		<div>
			<h5>한줄소개</h5>
			<input type="text" id="intro" name="intro" style="width:200px;height:100px;font-size:20px;">
		</div>
		<h5>칼로리계산기</h5>
		<table class="board_write">
	    <tbody>
	        <tr>
	            <th>키</th>
	            <td>
	               	<input type="text" name="height" id="height"> cm
	            </td>
	        </tr>
	        <tr>
	            <th>몸무게</th>
	            <td>
	                <input type="text" id="weight" name="weight"> kg
	            </td>
	        </tr>
	        <tr>
	            <th>활동지수</th>
	            <td>
	            
	            <select name="activity" style="height:22px;">
		        	<option value="1">앉아서 주로 생활하거나 활동량이 적은 경우,25</option>
		        	<option value="2">규칙적인 생활로 보통의 활동량을 가진 경우,35</option>
		        	<option value="3">육체노동 등 평소 신체 활동량이 많은 경우,45</option>
		        </select>
	            </td>
	        </tr>
        </tbody>
        </table>
        <div>
	        <h5>선호음식</h5>
	        <input type="hidden" name="prefer">
	        <c:forEach var="p" items="">
			<label>밥<input type="checkbox" name="밥" value="밥"/></label>
			<label>떡/한과<input type="checkbox" name="떡/한과" value="떡/한과"/></label>
			<label>만두/면류<input type="checkbox" name="만두/면류" value="만두/면류"/></label>
			<label>국<input type="checkbox" name="국" value="국"/></label>
			<label>나물/생채/샐러드<input type="checkbox" name="나물/생채/샐러드" value="나물/생채/샐러드"/></label>
			<label>구이<input type="checkbox" name="구이" value="구이"/></label>
			<label>볶음<input type="checkbox" name="볶음" value="볶음"/></label>
			<label>밑반찬/김치<input type="checkbox" name="밑반찬/김치" value="밑반찬/김치"/></label>
			<label>조림<input type="checkbox" name="조림" value="조림"/></label>
			<label>찜<input type="checkbox" name="찜" value="찜"/></label>
			<label>튀김/커틀릿<input type="checkbox" name="튀김/커틀릿" value="튀김/커틀릿"/></label><br>
			<label>찌개/전골/스튜<input type="checkbox" name="찌개/전골/스튜" value="찌개/전골/스튜"/></label>
			<label>도시락/간식<input type="checkbox" name="도시락/간식" value="도시락/간식"/></label>
			<label>부침<input type="checkbox" name="부침" value="부침"/></label>
			<label>샌드위치/햄버거<input type="checkbox" name="샌드위치/햄버거" value="샌드위치/햄버거"/></label>
			<label>빵/과자<input type="checkbox" name="빵/과자" value="빵/과자"/></label>
			<label>양념장<input type="checkbox" name="양념장" value="양념장"/></label>
			<label>음료<input type="checkbox" name="음료" value="음료"/></label>
			<label>그라탕/리조또<input type="checkbox" name="그라탕/리조또" value="그라탕/리조또"/></label>
			</c:forEach>
        </div>
		<div>
			<h5>알레르기</h5>
			<input type="hidden" name="allergy">
			<label>계란<input type="checkbox" name="계란" value="계란"/></label>
			<label>우유<input type="checkbox" name="우유" value="우유"/></label>
			<label>밀<input type="checkbox" name="밀" value="밀"/></label>
			<label>갑각류<input type="checkbox" name="갑각류" value="갑각류"/></label>
			<label>생선<input type="checkbox" name="생선" value="생선"/></label>
			<label>호두<input type="checkbox" name="호두" value="호두"/></label>
			<label>돼지고기<input type="checkbox" name="돼지고기" value="돼지고기"/></label>
			<label>땅콩<input type="checkbox" name="땅콩" value="땅콩"/></label>
			<label>조개<input type="checkbox" name="조개" value="조개"/></label>
			<label>복숭아<input type="checkbox" name="복숭아" value="복숭아"/></label><br>
			<label>콩<input type="checkbox" name="콩" value="콩"/></label>
			<label>사과<input type="checkbox" name="사과" value="사과"/></label>
			<label>닭고기<input type="checkbox" name="닭고기" value="닭고기"/></label>
			<label>메밀<input type="checkbox" name="메밀" value="메밀"/></label>
			<label>소고기<input type="checkbox" name="소고기" value="소고기"/></label>
			<label>키위<input type="checkbox" name="키위" value="키위"/></label>
			<label>아몬드<input type="checkbox" name="아몬드" value="아몬드"/></label>
			<label>들깨<input type="checkbox" name="들깨" value="들깨"/></label>
			<label>토마토<input type="checkbox" name="토마토" value="토마토"/></label>
			<label>오징어<input type="checkbox" name="오징어" value="오징어"/></label>
		</div>
	</form>
	<button type="button" id="goBackBtn" name="goBackBtn" onclick="history.back();">돌아가기</button>
	<button type="button" id="goNextBtn" name="goNextBtn" onclick="goSave();">가입하기</button>
<script>
const realInput = document.querySelector(".img-input");
const imgTag = document.querySelector(".img");

const resizeImage = (settings) => {
  const file = settings.file;
  const maxSize = settings.maxSize;
  const reader = new FileReader();
  const image = new Image();
  const canvas = document.createElement("canvas");

  const dataURItoBlob = (dataURI) => {
    const bytes =
      dataURI.split(",")[0].indexOf("base64") >= 0
        ? atob(dataURI.split(",")[1])
        : unescape(dataURI.split(",")[1]);
    const mime = dataURI.split(",")[0].split(":")[1].split(";")[0];
    const max = bytes.length;
    const ia = new Uint8Array(max);
    for (let i = 0; i < max; i++) ia[i] = bytes.charCodeAt(i);
    return new Blob([ia], { type: mime });
  };
  
  const resize = () => {
    let width = image.width;
    let height = image.height;
    if (width > height) {
      if (width > maxSize) {
        height *= maxSize / width;
        width = maxSize;
      }
    } else {
      if (height > maxSize) {
        width *= maxSize / height;
        height = maxSize;
      }
    }
    canvas.width = width;
    canvas.height = height;
    canvas.getContext("2d").drawImage(image, 0, 0, width, height);
    const dataUrl = canvas.toDataURL("image/jpeg");
    return dataURItoBlob(dataUrl);
  };

  return new Promise((ok, no) => {
    if (!file) {
      return;
    }
    if (!file.type.match(/image.*/)) {
      no(new Error("Not an image"));
      return;
    }
    reader.onload = (readerEvent) => {
      image.onload = () => {
        return ok(resize());
      };
      image.src = readerEvent.target.result;
    };
    reader.readAsDataURL(file);
  });
};

const handleImgInput = (e) => {
  const config = {
    file: e.target.files[0],
    maxSize: 350,
  };
  resizeImage(config)
    .then((resizedImage) => {
      const url = window.URL.createObjectURL(resizedImage);
      const img = document.createElement("img");
      img.setAttribute("src", url);
      img.className = "profile-img";
      img.style.display = "block";
      imgTag.appendChild(img);
    })
    .then(() => {
      const img = document.querySelector(".profile-img");
      img.onload = () => {
        const widthDiff = (img.clientWidth - imgTag.offsetWidth) / 2;
        const heightDiff = (img.clientHeight - imgTag.offsetHeight) / 2;
        img.style.transform = `translate( -${widthDiff}px , -${heightDiff}px)`;
      };
    })
    .catch((err) => {
      console.log(err);
    });
};
realInput.addEventListener("change", handleImgInput);




</script>
</body>
</html>