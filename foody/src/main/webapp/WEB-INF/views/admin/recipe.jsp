<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../common/config.jsp" %>
<script type="text/javascript" src="/foody/resources/js/modal/jquery.plainmodal.min.js"></script>
<link rel="stylesheet" type="text/css" href="/foody/resources/datepicker/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
function openModal(){
	$('#modal').plainModal('open');
	$('#modal').css("display", "inline-block");
}

$( function() {
	var to = new Date();
	var toY = to.getFullYear();
	var toM = to.getMonth() + 1;
    var toD = to.getDate();
    var toStr = toY + "-" + toM + "-" + toD;
    $("#to").val(toStr);
	
    var dftFrom = new Date(Date.parse(to) - $("#selectDate").val()*1000*60*60*24);
	var dftFromY = dftFrom.getFullYear();
	var dftFromM = dftFrom.getMonth() + 1;
    var dftFromD = dftFrom.getDate();
    $("#from").val(dftFromY + "-" + dftFromM + "-" + dftFromD);
	
    
	$("#selectDate").on("change", function(){
		var from = new Date(Date.parse(new Date()) - $(this).val()*1000*60*60*24);
		
		var fromY = from.getFullYear();
		var fromM = from.getMonth() + 1;
        var fromD = from.getDate();
        
        var fromStr = fromY + "-" + fromM + "-" + fromD;
        
		$("#from").val(fromStr);
		$("#to").val(toStr);
	});
	
    var dateFormat = "yy-mm-dd",
      from = $( "#from" )
        .datepicker({
          dateFormat: dateFormat,
          changeMonth: true,
          showOn: 'button',
          prevText: '이전 달',
          nextText: '다음 달',
          monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월',],
          monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월',],
          dayNames: ['일','월','화','수','목','금','토'],
          dayNamesShort: ['일','월','화','수','목','금','토'],
          dayNamesMin: ['일','월','화','수','목','금','토'],
          showMonthAfterYear: true,
          yearSuffix: '년',
          buttonImage: "/foody/resources/img/calendar.png", //버튼 이미지 경로
          buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
        })
        .on( "change", function() {
          to.datepicker( "option", "minDate", getDate( this ) );
        }),
      to = $( "#to" ).datepicker({
    	dateFormat: dateFormat,
        changeMonth: true,
        showOn: 'button',
        prevText: '이전 달',
        nextText: '다음 달',
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월',],
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월',],
        dayNames: ['일','월','화','수','목','금','토'],
        dayNamesShort: ['일','월','화','수','목','금','토'],
        dayNamesMin: ['일','월','화','수','목','금','토'],
        showMonthAfterYear: true,
        yearSuffix: '년',
        buttonImage: "/foody/resources/img/calendar.png", //버튼 이미지 경로
        buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
      })
      .on( "change", function() {
        from.datepicker( "option", "maxDate", getDate( this ) );
      });
 
    function getDate( element ) {
      var date;
      try {
        date = $.datepicker.parseDate( dateFormat, element.value );
      } catch( error ) {
        date = null;
      }
 
      return date;
    }
    searchRcp(1);
} );
</script>

<style>
.ui-datepicker-trigger {
    position: relative;
    top: 2px;
    width: 24px;
    margin-left: 5px;
}
#modal {
	width: 80%;
	height: 80%;
	background-color: white;
	display: none;
}
#modal .summaryArea{
    width: 100%;
    height: 30%;
    background: aliceblue;
}
#modal .ingreArea{
    width: 50%;
    height: 50%;
    float: left;
    background: antiquewhite;
}
#modal .processArea{
    width: 50%;
    height: 50%;
    float: right;
    background: aqua;
}
#modal .endArea{
	width: 100%;
    height: 20%;
    background: white;
}
#bbs {
	width: 90%;
	margin: auto;
	overflow: hidden;
}
#bbs table tbody tr:hover {
	background-color: #FFA7A7;
}
#recipeArea {
	height: 80%;
	max-height: 85%;
	max-height: 85%;
	overflow: auto;
	overflow-x: hidden;
}
.form{
	height: 10%;
    display: flex;
    align-items: center;
    justify-content: center;
}
#form{
    background-color: #FAF4C0;
    padding: 5px;
    border: solid 8px #FAED7D;
}
td.head{
	background-color: white;
}

</style>
<link rel="stylesheet" type="text/css" href="/foody/resources/css/leftMenu.css">
<title>레시피 목록</title>
</head>
<body>
<%@ include file="../admin/leftMenu.jsp" %>
<div class="adminContainer">
<div class="title"><h1>레시피 목록 조회</h1></div>
<div class="form">
	<form id="form" method="post" action="recipe.do">

			확인여부
				<select name="adminChk">
					<option value='1' <c:if test="${mode eq 2}">selected</c:if>>확인</option>
					<option value='0' <c:if test="${mode eq 3}">selected</c:if>>미확인</option>
					<option value='0 or 1' <c:if test="${mode eq 0 or mode eq 1}">selected</c:if>>모두</option>
				</select>
				삭제여부
				<select name="print">
					<option value='1'>삭제된 건만</option>
					<option value='0'>출력되는 건만</option>
					<option value='0 or 1' selected>모두</option>
				</select>
			정렬조건
				<select name="orderBy">
					<option value="regdate desc" selected>최신순</option>
					<option value="regdate">오래된순</option>
					<option value="nikname">작성자</option>
				</select>
			페이지당 출력 갯수
				<select name="rcpPerPage">
					<option value="10">10개</option>
					<option value="30" selected>30개</option>
					<option value="50">50개</option>
				</select>
			기간: 
			<select id="selectDate" name="date">
				<option value='1'>1일</option>
				<option value='7' <c:if test="${mode != 0}">selected</c:if>>1주</option>
				<option value='30' <c:if test="${mode eq 0}">selected</c:if>>1개월</option>
				<option value='90'>3개월</option>
				<option value='180'>6개월</option>
				<option value='365'>1년</option>
				<option value='3650'>전체기간</option>
			</select>
			직접입력
				<input type="text" id="from" name="from" readonly>
				<label for="from">부터</label>
			
				<input type="text" id="to" name="to" readonly>
				<label for="to">까지</label>
			옵션별 검색
			<select name="type">
				<option value="title">제목</option>
				<option value="nikname">닉네임</option>
			</select>
				<input type="text" name="keyword">
				<input type="button" value="검색하기" onclick="searchRcp(1);">
	</form>
</div>
	<div id="recipeArea">
	</div>
</div>
<div id="modal"></div>
</body>
</html>
