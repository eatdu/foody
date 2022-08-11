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

function search(pageNo, target, type){
	$.ajax({
		url: "/foody/search.do",
		method: "post",
		contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({
        	keywordArr: ingreNameArr,
        	ingreCateArr: ingreArr,
        	rcpCateArr: rcpArr,
        	startNo: (pageNo - 1) * 12 + 1,
        	endNo: pageNo * 12,
			type: type
        	}),
		success: function(result){
			$("#" + target).empty().append(result);
		},
		error: function(e){
			console.log(e);
		}
	});
}