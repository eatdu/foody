<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../common/config.jsp" %>

<script>
function essearch(){
	var url = "/foody/esApi.do?keyword=" + $("#keyword").val();
	$.ajax({
		url: url,
		method: "get",
		contentType: 'application/json; charset=utf-8',
		success: function(res){
			console.log(res);
			var html = "";
			html +=	"<div class='row'>";
			res.hits.hits.forEach(function(rcp, idx){
				console.log(rcp);
				html += "<a href='recipe/view.do?no=" + rcp._source.rno + "'>"
					+		"<div class='rcpCard'>"
					+			"<table class='rcpTable' style='table-layout:fixed'>"
					+				"<colgroup>"
					+					"<col width='25%'/>"
					+					"<col width='75%'/>"
					+				"</colgroup>"
					+				"<tr><th colspan='2' style='font-size: 15px; color: black;'>" + rcp._source.rname + "</th></tr>"
					+ 				"<tr>"
					+					"<td class='imgCell' colspan='2'>"
					+						"<div height=150px style='border-radius: 15px; position: relative; max-height:150px; align-items:center; overflow:hidden; display: flex; justify-content:center;'>"
					+							"<div class='rcpImg'>"
					+								"<img class='thumbnail' width='100%' src='/foody/upload/" + rcp._source.thumbnail + "' />"
					+							"</div>"
					+							"<div class='intro'>" + rcp._source.intro + "</div>"
					+						"</div>"
					+					"</td>"
					+				"</tr>"
					+				"<tr>"
					+					"<td><div class='timename'>" + rcp._source.time + "분</span></td>"
					+					"<td>"
					+						"<div class='timename'>"
					+							"<img width='20px' src='/foody/resources/img/viewcnt.png'>" + rcp._source.viewcount
					+							"<img width='20px' src='/foody/resources/img/reply.png'>" + rcp._source.reply
					+							"<img width='20px' src='/foody/img/heart.png'>" + rcp._source.bookmark
					+							"<img width='20px' src='/foody/img/star.png'>" + rcp._source.avgstar/10
					+						"</div>"
					+					"</td>"
					+				"</tr>"
					+			"</table>"
					+		"</div>"
					+	"</a>";
				if ((idx + 1) % 4 == 0 && idx != 11) {
					html += "</div>"
						+	"<div class='row'>";
				}
			});
			html += "</div>";
			$("#rcpArea1").html(html);
			$(".rcpCard").hover(function(){
				$(this).find(".intro").show();
				$(this).find(".thumbnail").css("opacity", 0.7);
			});
			$(".rcpCard").mouseleave(function(){
				$(this).find(".intro").hide();
				$(this).find(".thumbnail").css("opacity", 1.0);
			});
		},
		error: function(e){
			console.log(e);
		}
	});
}
</script>
<style>
</style>
<title>상세 검색-ES</title>
</head>
<body>
 
<%@ include file="../common/navBar.jsp"  %>
<div class="container">
	<div class='row' style="padding: 15px;">
		<input type="text" id="keyword" placeholder="검색어 입력" style="width: 400px;">
		<button type="button" onclick="javascript:essearch();">검색</button>
	</div>
	<div class="rcpArea" id="rcpArea1">
	</div>
</div>
</body>
</html>