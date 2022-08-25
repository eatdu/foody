jQuery.fn.serializeObject = function() {
	    var obj = null;
	    try {
	        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
	            var arr = this.serializeArray();
	            if (arr) {
	                obj = {};
	                jQuery.each(arr, function() {
	                    obj[this.name] = this.value;
	                });
	            }//if ( arr ) {
	        }
	    } catch (e) {
	        alert(e.message);
	    } finally {
	    }
	 
	    return obj;
	};

function makeArr(name){
	var tempArr = new Array();
	$("input[name='" + name + "']:checked").each(function() { 
		tempArr.push($(this).val());
    });
	return tempArr;
}

function makeComboBox(origin, target){
	$.ajax({
		url: "/foody/comboBox.do",
		method: "post",
		contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({
        	name: origin,
        	data: $('#' + origin).val()
        	}),
		success: function(result){
			$('select[name="' + target + '"]').html(result);
		},
		error: function(e){
			console.log(e);
		}
	});
}

//ajax보내는 함수
function sendAjax(reqUrl, data, callback){
	$.ajax({
		url: reqUrl,
		method: "post",
		contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(data),
		success: function(result){
			callback(result);
		},
		error: function(e){
			console.log(e);
		}
	});
}
//관리자 - 레시피 검색
function searchRcp(pageNo){
	var data = $('#form').serializeObject();
	data.pageNo = pageNo;
	sendAjax(
			"/foody/admin/recipe.do",
			data,
			function(result){
				$('#recipeArea').html(result);
			}
	);
}
//관리자 - 레시피 상세 보기(모달)
function rcpDetailAdmin(no){
	var data = {};
	data.no = no;
	sendAjax(
		"/foody/admin/rcpDetail.do",
		data,
		function(result){
			$('#modal').html(result);
			openModal();
			$("#"+no).find("#adminChk").html('<strong class="colG01">확인</strong>');
		}
	);
}

//ajax로 재료 정보 추가
function addIngre(){
	var data = {};
	if ($('#ingreAddArea select[name=large_cate]').val() == 0) {
		alert("재료 분류를 선택해주세요.");
		return;
	}
	data.no = $('#ingreAddArea input[name=no]').val();
	data.allergy_no = $('#ingreAddArea select[name=allergy_no]').val();
	data.name = $('#ingreAddArea input[name=name]').val();
	data.carbo = $('#ingreAddArea input[name=carbo]').val();
	data.protein = $('#ingreAddArea input[name=protein]').val();
	data.fat = $('#ingreAddArea input[name=fat]').val();
	data.large_cate = $('#ingreAddArea select[name=large_cate]').val();
	data.detail = $('#ingreAddArea input[name=detail]').val();
	data.print = 0;
	if ($('#ingreAddArea input[name=print]').is(":checked") == false) {
		data.print = 1;
	}

	sendAjax(
		"/foody/admin/ingreInsert.do",
		data,
		function(result){
			if(result == true) {
				$('#ingreAddArea input').each(function(idx, obj){
					$(this).val(' ');
				});
				$('#ingreAddArea input:checkbox').prop("checked", false);
				$('#ingreAddArea select').each(function(idx, obj){
					$(this).val('0');
				});
				alert("재료 정보 추가에 성공하였습니다.");
			} else alert("재료 추가 실패");
		}
	);
}

//ajax로 재료 정보 수정
function updateIngre(){
	var data = {};
	if ($('#ingreInfoArea select[name=large_cate]').val() == 0) {
		alert("재료 분류를 선택해주세요.");
		return;
	}
	data.no = $('#ingreInfoArea input[name=no]').val();
	data.allergy_no = $('#ingreInfoArea select[name=allergy_no]').val();
	data.name = $('#ingreInfoArea input[name=name]').val();
	data.carbo = $('#ingreInfoArea input[name=carbo]').val();
	data.protein = $('#ingreInfoArea input[name=protein]').val();
	data.fat = $('#ingreInfoArea input[name=fat]').val();
	data.large_cate = $('#ingreInfoArea select[name=large_cate]').val();
	data.detail = $('#ingreInfoArea input[name=detail]').val();
	data.print = 0;
	if ($('#ingreInfoArea input[name=print]').is(":checked") == false) {
		data.print = 1;
	}

	sendAjax(
		"/foody/admin/ingreUpdate.do",
		data,
		function(result){
			if(result == true) {
				alert("재료 정보 수정에 성공하였습니다.");
				$("#ingreInfoArea").empty().append("조회할 재료를 선택해주세요.");
			} else alert("재료 수정 실패");
		}
	);
}

//ajax로 검색하는 함수
function search(data, targetId){
	
	sendAjax(
		"/foody/search.do",
		data,
		function(result){
			$("#" + targetId).html(result);
		}
	);
}
//메인화면 - 추천 레시피 검색 - 알러지 필터, 선호도 필터
function searchPrefer() {
	var data = {};
	data.jsp = 'common/swipeRcpList';
	data.orderBy = 'bookmark';//찜
	data.allergyChk = '1';

	data.type = 'prefer'; //수정필요, 임시로 all 해놓음
	data.title = '추천 레시피';
	search(data, 'preferRcpArea');	
}
//메인화면 - 인기 레시피 검색 - 알러지 필터, 인기순 정렬
function searchBest() {
	var data = {};
	data.jsp = 'common/swipeRcpList';
	data.orderBy = 'star';//별점
	data.allergyChk = '1';

	data.type = 'best'; //수정필요, 임시로 all 해놓음
	data.title = '인기 레시피';
	search(data, 'bestRcpArea');	
}
//각 검색 결과에서 페이지 이동에 이용될 함수
function movePage(title, pageNo, areaNo, sType, keyword){
	data = {};
	data.orderBy = $('#rcpArea' + areaNo).find('#orderBy').val();
	data.areaNo = areaNo;
	data.title = title;
	data.pageNo = pageNo;
	data.jsp = 'common/rcpList';
	data.type = 'common';
	data.allergyChk = '0';
	if (sType != "") data.sType = sType;
	if (keyword != "") data.keyword = keyword;
	if ($('#allergyChk').is(':checked')) {
		data.allergyChk = '1';
	}

	data.ingreCateArr = ingreArr;
	data.rcpCateArr = rcpArr;
	data.keywordArr = ingreNameArr;
	//IRK
	if(title == 'IRK'){
		search(data, 'rcpArea'+areaNo);
	}
	//IR
	if(title == 'IR'){
		delete data.keywordArr;
		search(data, 'rcpArea'+areaNo);
	}
	//IK
	if(title == 'IK'){
		delete data.rcpCateArr;
		search(data, 'rcpArea'+areaNo);
	}
	//RK
	if(title == 'RK'){
		delete data.ingreCateArr;
		search(data, 'rcpArea'+areaNo);
	}
	//I
	if(title == 'I'){
		delete data.rcpCateArr;
		delete data.keywordArr;
		search(data, 'rcpArea'+areaNo);
	}
	//R
	if(title == 'R'){
		delete data.keywordArr;
		delete data.ingreCateArr;
		search(data, 'rcpArea'+areaNo);
	}
	//K
	if(title == 'K'){
		delete data.rcpCateArr;
		delete data.ingreCateArr;
		search(data, 'rcpArea'+areaNo);
	}
	//all
	if(title == 'all'){
		delete data.ingreCateArr;
		delete data.rcpCateArr;
		delete data.keywordArr;
		search(data, 'rcpArea'+areaNo);
	}
}

//상세검색에서 pageNo추가하여 검색  
function searchBtn(pageNo, sType, keyword){
	var flagI = false;
	var flagR = false;
	var flagK = false;

	var data = {};
	data.sType = sType;
	if (keyword != "") data.keyword = keyword;
	data.pageNo = pageNo;
	data.areaNo = 1;
	data.orderBy = 'regdate';
	//컨트롤러가 리턴할 jsp
	data.jsp = 'common/rcpList';
	data.allergyChk = '0';

	//알러지 필터 적용 여부
	if ($('#allergyChk').is(':checked')) {
		data.allergyChk = '1';
	}
	//I
	if (ingreArr.length != 0) {
		flagI = true;
		data.ingreCateArr = ingreArr;
	}
	//R
	if (rcpArr.length != 0) {
		flagR = true;
		data.rcpCateArr = rcpArr;
	}
	//K
	if (ingreNameArr.length != 0) {
		flagK = true;
		data.keywordArr = ingreNameArr;
	}



	if (flagI && flagR && flagK) {
		//IRK
		data.type = 'common';
		data.title = 'IRK';
		search(data, 'rcpArea1');
		//IK(R제거)
		delete data.rcpCateArr;
		data.title = 'IK';
		data.areaNo = 2;
		search(data, 'rcpArea2');
		//K(I제거)
		delete data.ingreCateArr;
		data.title = 'K';
		data.areaNo = 3;
		search(data, 'rcpArea3');
		//I(K제거, I추가)
		delete data.keywordArr;
		data.ingreCateArr = ingreArr;
		data.title = 'I';
		data.areaNo = 4;
		search(data, 'rcpArea4');
	} else if (flagI && !flagR && flagK) {
		//IK
		data.type = 'common';
		data.title = 'IK';
		search(data, 'rcpArea1');
		//K(I제거)
		delete data.ingreCateArr;
		data.title = 'K';
		data.areaNo = 2;
		search(data, 'rcpArea2');
		//I(I제거, R추가)
		delete data.keywordArr;
		data.title = 'I';
		data.ingreCateArr = ingreArr;
		data.areaNo = 3;
		search(data, 'rcpArea3');
	} else if (!flagI && flagR && flagK) {
		//RK
		data.type = 'common';
		data.title = 'RK';
		search(data, 'rcpArea1');
		//K(R제거)
		delete data.rcpCateArr;
		data.title = 'K';
		data.areaNo = 2;
		search(data, 'rcpArea2');
	} else if (flagI && flagR && !flagK) {
		//IR
		data.type = 'common';
		data.title = 'IR';
		search(data, 'rcpArea1');
		//I(R제거)
		delete data.rcpCateArr;
		data.title = 'I';
		data.areaNo = 2;
		search(data, 'rcpArea2');
	} else if (!flagI && flagR && !flagK) {
		//R
		data.type = 'common';
		data.title = 'R';
		search(data, 'rcpArea1');
	} else if (flagI && !flagR && !flagK) {
		//I
		data.type = 'common';
		data.title = 'I';
		search(data, 'rcpArea1');
	} else if (!flagI && !flagR && flagK) {
		//K
		data.type = 'common';
		data.title = 'K';
		search(data, 'rcpArea1');
	} else if (!flagI && !flagR &&! flagK) {
		//selectAll
		data.type = 'common';
		data.title = 'all';
		search(data, 'rcpArea1');
	}
}

// function search2(pageNo, target, type){
// 	$.ajax({
// 		url: "/foody/search.do",
// 		method: "post",
// 		contentType: 'application/json; charset=utf-8',
//         data: JSON.stringify({
//         	keywordArr: ingreNameArr,
//         	ingreCateArr: ingreArr,
//         	rcpCateArr: rcpArr,
//         	startNo: (pageNo - 1) * 12 + 1,
//         	endNo: pageNo * 12,
// 			type: type
//         	}),
// 		success: function(result){
// 			$("#" + target).empty().append(result);
// 		},
// 		error: function(e){
// 			console.log(e);
// 		}
// 	});
// }