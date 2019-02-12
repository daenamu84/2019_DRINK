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

//택배사별 송장번호 규칙성 체크
function BLNo_Check(blNo, deliCompanyID){
	blNo = strTrim(blNo);
	var tmpBLNo;

	//대한통운
	if(deliCompanyID == "03")
	{
		if(!(blNo.length == 12 || blNo.length == 10) )
			return false;
	}
	//로엑스택배(아주택배)
	else if(deliCompanyID == "11")
	{
		if(blNo.length != 10)
			return false;
	}
	//현대택배
	else if(deliCompanyID == "04")
	{
		if(blNo.length != 10 && blNo.length != 12)
			return false;

		if(blNo.length == 10)
		{
			tmpBLNo = blNo.substring(0, 9);
			if(eval(tmpBLNo) % 7 != parseInt(blNo.substring(9, 10)))
				return false;
		}
		else if(blNo.length == 12)
		{
			tmpBLNo = blNo.substring(0, 11);
			if(eval(tmpBLNo) % 7 != parseInt(blNo.substring(11, 12)))
				return false;
		}
		else
			return false;
	}
	//CJGLS
	else if(deliCompanyID == "09")
	{
		if(blNo.length != 10 && blNo.length != 12)
			return false;

		tmpBLNo = blNo.substring(0, 9);
		if(blNo.length == 10)
		{
			if((eval(tmpBLNo) % 7) != parseInt(blNo.substring(9, 10)))
				return false;
		}
		else if(blNo.length == 12)
		{
		}
	}
	//한진택배
	else if(deliCompanyID == "01" || deliCompanyID == "69")
	{
		if(blNo.length != 10 && blNo.length != 12)
			return false;

		if(blNo.length == 10 )
		{
			tmpBLNo = blNo.substring(0, 9);
			if((eval(tmpBLNo) % 7) != parseInt(blNo.substring(9, 10)))
				return false;
		}
		else if(blNo.length == 12)
		{
			tmpBLNo = blNo.substring(0, 11);
			if((eval(tmpBLNo) % 7) != parseInt(blNo.substring(11, 12)))
				return false;
		}
	}
	//하나로택배
	else if(deliCompanyID == "72")
	{
		if(blNo.length != 10)
			return false;

		tmpBLNo = blNo.substring(0, 9);
		if((eval(tmpBLNo) % 7) != parseInt(blNo.substring(9, 10)))
			return false;
	}
	//사가와익스프레스
	else if(deliCompanyID == "73")
	{
		if(blNo.length != 10 && blNo.length != 12)
			return false;

		tmpBLNo = blNo.substring(0, 9);
		if(blNo.length == 10)
		{
			if((eval(tmpBLNo) % 7) != parseInt(blNo.substring(9, 10)))
				return false;
		}
		else if(blNo.length == 12)
		{
		}
	}
	//SEDEX
	else if(deliCompanyID == "70")
	{
		if(blNo.length != 10)
			return false;

		tmpBLNo = blNo.substring(0, 9);
		if((eval(tmpBLNo) % 7)+2 != parseInt(blNo.substring(9, 10)))
			return false;
	}
	//KGB택배
	else if(deliCompanyID == "67")
	{
		if(blNo.length != 10)
			return false;
	}
	//로젠택배
	else if(deliCompanyID == "16")
	{
		if(blNo.length != 11)
			return false;

		tmpBLNo = blNo.substring(0, 10);
		if((eval(tmpBLNo) % 7) != parseInt(blNo.substring(10, 11)))
			return false;
	}
	//옐로우캡
	else if(deliCompanyID == "13")
	{
		if(blNo.length != 11)
			return false;

		tmpBLNo = blNo.substring(0, 10);
		if((eval(tmpBLNo) % 7) != parseInt(blNo.substring(10, 11)))
			return false;
	}
	//삼성HTH
	else if(deliCompanyID == "08")
	{
		if(blNo.length != 11 && blNo.length != 12)
			return false;

		if(blNo.length == 11)
		{
			tmpBLNo = blNo.substring(3, 10);
			if((eval(tmpBLNo) % 7) != parseInt(blNo.substring(10, 11)))
				return false;
		}
		else if(blNo.length == 12)
		{
		}
	}
	//동부택배
	else if(deliCompanyID == "07")
	{
		if(blNo.length != 12)
			return false;

		tmpBLNo = blNo.substring(0, 11);
		if((eval(tmpBLNo) % 7) != parseInt(blNo.substring(11, 12)))
			return false;
	}
	//우체국 택배
	else if(deliCompanyID == "02")
	{
		if(blNo.length != 13)
			return false;

		if(blNo.substring(0, 1) != "6" && blNo.substring(0, 1) != "7" && blNo.substring(0, 1) != "8")
			return false;
	}
	//우편 등기
	else if(deliCompanyID == "20")
	{
		if(blNo.length != 13)
			return false;

		if(blNo.substring(0, 1) != "1" && blNo.substring(0, 1) != "2" && blNo.substring(0, 1) != "3")
			return false;
	}
	//동원택배
	else if(deliCompanyID == "71")
	{
		if(blNo.length != 10)
			return false;
	}
	//네덱스택배
	else if(deliCompanyID == "74")
	{
		if(blNo.length != 10)
			return false;

		tmpBLNo = blNo.substring(0, 9);
		if((eval(tmpBLNo) % 7) != parseInt(blNo.substring(9, 10)))
			return false;
	}
	//이노지스택배
	else if(deliCompanyID == "75")
	{
		if(blNo.length < 10 || blNo.length > 13)
			return false;
	}
	return true;
}