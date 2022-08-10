function makeArr(name){
	var tempArr = new Array();
	$("input[name='" + name + "']:checked").each(function() { 
		tempArr.push($(this).val());
    });
	return tempArr;
}