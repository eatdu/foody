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
//ajax로 검색하는 함수
function search(data, targetId){
	
	sendAjax(
		"/foody/search.do",
		data,
		function(result){
			$("#" + targetId).empty().append(result);
		}
	);
}
//메인화면 - 추천 레시피 검색 - 알러지 필터, 선호도 필터
function searchPrefer() {
	var data = {};
	data.jsp = 'common/swipeRcpList';

	data.type = 'prefer'; //수정필요, 임시로 all 해놓음
	data.title = '추천 레시피';

	search(data, 'preferRcpArea');	
}
//메인화면 - 인기 레시피 검색 - 알러지 필터, 인기순 정렬
function searchBest() {
	var data = {};
	data.jsp = 'common/swipeRcpList';

	data.type = 'all'; //수정필요, 임시로 all 해놓음
	data.title = '인기 레시피';
	search(data, 'bestRcpArea');	
}
//상세검색에서 pageNo추가하여 검색  
function searchBtn(pageNo){
	var flagI = false;
	var flagR = false;
	var flagK = false;
	$("#rcpArea1").empty();
	$("#rcpArea2").empty();
	$("#rcpArea3").empty();
	$("#rcpArea4").empty();

	var data = {};
	data.pageNo = pageNo;
	//컨트롤러가 리턴할 jsp
	data.jsp = 'common/rcpList';

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
		search(data, 'rcpArea2');
		//K(I제거)
		delete data.ingreCateArr;
		data.title = 'K';
		search(data, 'rcpArea3');
		//I(K제거, I추가)
		delete data.keywordArr;
		data.ingreCateArr = ingreArr;
		data.title = 'I';
		search(data, 'rcpArea4');
	} else if (flagI && !flagR && flagK) {
		//IK
		data.type = 'common';
		data.title = 'IK';
		search(data, 'rcpArea1');
		//K(I제거)
		delete data.ingreCateArr;
		data.title = 'K';
		search(data, 'rcpArea2');
		//I(I제거, R추가)
		delete data.keywordArr;
		data.title = 'I';
		data.ingreCateArr = ingreArr;
		search(data, 'rcpArea3');
	} else if (!flagI && flagR && flagK) {
		//RK
		data.type = 'common';
		data.title = 'RK';
		search(data, 'rcpArea1');
		//K(R제거)
		delete data.rcpCateArr;
		data.title = 'K';
		search(data, 'rcpArea2');
	} else if (flagI && flagR && !flagK) {
		//IR
		data.type = 'common';
		data.title = 'IR';
		search(data, 'rcpArea1');
		//I(R제거)
		delete data.rcpCateArr;
		data.title = 'I';
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