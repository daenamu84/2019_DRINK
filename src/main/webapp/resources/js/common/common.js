"use strict";
/**
 * 
 */

function goPageMethod(func, pages, pageLine) {
    func(pages,pageLine);
}

//문자열에서 공백제거
function strTrim(str){
    return str.replace(/\s/gi, "");
}

function isNumber(str){
	var pattern =/^\d+$/;
	return pattern.test(str);
}


function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
//콤마 제거
function getNumString(s) {
	var rtn = parseFloat(s.replace(/,/gi, ""));
	if (isNaN(rtn)) {
		return 0;
	} else {
		return rtn;
	}
}
