<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	
<script type="text/javascript">
	
	// 한글입력막기 스크립트
	$( function(){
		$("#login_id" ).on("blur keyup", function() {
			$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
		});
	})
	
	
	
	var ajaxFlag = false;
	
	$(document).ready(function(){
		
		
		//목록
		$("#proposalList").click(function(){
			location.href="/proPosalList";
		});
		
		
		$("#proPosalForm01_List").click(function(){
			document.viewForm.action="/proPosalForm";
			document.viewForm.submit();
		});
		
		
		function  goStep03(prps_id){
			$("#prps_id").val(prps_id);
			document.insert02.action = "/proPosalForm03";
			document.insert02.submit();
		}
		
		//등록
		$("#saveWork2").click(function(){			
			if(ajaxFlag)return;
			  ajaxFlag=true;
			var prps_id = $("#prps_id").val();
			
			var _addParam1 = [];
			
			var _prodNoSitemNm1 = $("input[name='prodNoSitemNm1']");
			var _prodNoSitemCd1 =  $("input[name='prodNoSitemCd1']");
			var _unitIncentive_amt = $("input[name='unit_incentive_amt1']");
			var _delivery_cnt1 = $("input[name='delivery_cnt1']");
			
			var _incentive_amt1 = $("input[name='incentive_amt1']");
			var _up_case9l = $("input[name='up_case9l']");
			var _up_incentive_amt1 = $("input[name='up_incentive_amt1']");
			var _case_rate1 = $("input[name='case_rate1']");
			var _vs_std1 = $("input[name='vs_std1']");
			var _std_case_rate1 = $("input[name='std_case_rate1']");
			var _rmk_cntn1 =  $("input[name='rmk_cntn1']");
			var _up_prpsd_id =  $("input[name='up_prpsd_id']");
			
			for (var i = 0; i < prodNoSitemNm1.length; i++) {
				
				if( (Number(getNumString(_unitIncentive_amt[i].value)) != 0 || Number(getNumString(_delivery_cnt1[i].value)) != 0) && prodNoSitemNm1[i].value.replace(/\s/gi, "") ==""){
					prodNoSitemNm1[i].focus();
					alert("품목명이 입력 되지 않습니다. 확인 해주세요.");
					 ajaxFlag=false;
					return;
				}
				if(prodNoSitemNm1[i].value.replace(/\s/gi, "") ==""){
					continue;
				}
				
				_addParam1.push({"prodNoSitemNm1":_prodNoSitemNm1[i].value,"prodNoSitemCd1":_prodNoSitemCd1[i].value,"unit_incentive_amt1":getNumString(_unitIncentive_amt[i].value),
					"delivery_cnt1":getNumString(_delivery_cnt1[i].value),"incentive_amt1":getNumString(_incentive_amt1[i].value),"up_case9l":getNumString(_up_case9l[i].value),
					"up_incentive_amt1":getNumString(_up_incentive_amt1[i].value),"case_rate1":getNumString(_case_rate1[i].value),"vs_std1":getNumString(_vs_std1[i].value),
					"std_case_rate1":getNumString(_std_case_rate1[i].value),"rmk_cntn1":_rmk_cntn1[i].value,"up_prpsd_id":_up_prpsd_id[i].value});
			}
			
			var gubun = $("#gubun").val();
			
			if(_addParam1.length ==0){
				  ajaxFlag=false;
				  alert("데이터를 입력하십시오.");
				  return;
			}
			
			var url = "";
			if (gubun == "") {
				url = "/proposalWork2-1";
			}else{
				url = "/proposalUpdate2-1";
			}
			
			$.ajax({      
			    type:"POST",  
			    url:url,
			    data: JSON.stringify({"_addPram":_addParam1,"prps_id":prps_id}),
			    dataType:"json",
			    contentType:"application/json;charset=UTF-8",
			    traditional:true,
			    success:function(args){   
			        if(args.returnCode == "0000"){
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	if(args.retgubun == "insert"){
			        		goStep03(prps_id);
			        		//location.replace("/proPosalForm02");
			        	}else if(args.retgubun == "update"){
			        		goStep03(prps_id);
			        		//document.viewForm.action="/proPosalView#defultView";
			    			//document.viewForm.submit();
			        		
			        	}else{
			        		//alert(0);
			        		//ViewMember(emp_no,args.retgubun);	
			        	}
			        	//location.replace("/callList");
			        	//location.reload();
			        }else{
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	//location.reload();
			        }
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        if(xhr.status == 403){
			        	alert("로그인이 필요한 메뉴 입니다.");
			        	location.replace("/logIn");
			        }else{
			        	alert("처리중 에러가 발생 하였습니다.");
			        	location.reload();
			        }
			        ajaxFlag=false;
			    }   
			});
			 
		});
	});
	
	var popListObj = null;
	
	$(document).on("click","input[id='productInsertLayer']",function() {
		$("#popLayer").modal("show");
		popListObj = this;
	});

	
	//제품 검색 후 제품 세팅 
	function setValueDate(arg1, arg2,arg3){
		
		var obj = popListObj;
		$(obj).parent().parent().children().find("#prodNoSitemNm").val(arg2);
		$(obj).parent().parent().find("#prodNoSitemCd").val(arg1);
		
		var caserate_amt = numberWithCommas(arg3);
		console.log(caserate_amt);
		$(obj).parent().parent().parent().find('input[name="caserate_amt"]').val(caserate_amt);   
		$("#popLayer").modal("hide");
	}
	


	

	
	
	function step2Calcu(){
		var _up_prpsd_id = $("input[name='up_prpsd_id']");
		for(var t=0;t<_up_prpsd_id.length;t++){
			var _prpsdId = _up_prpsd_id[t].value;
			var _unitIncentive_amt = $("input[name='unit_incentive_amt1'][data-prpsdid="+_prpsdId+"]");
			var _delivery_cnt1 = $("input[name='delivery_cnt1'][data-prpsdid="+_prpsdId+"]");
			
			var _incentive_amt1 = $("input[name='incentive_amt1'][data-prpsdid="+_prpsdId+"]");
			var _up_case9l = $("input[name='up_case9l'][data-prpsdid="+_prpsdId+"]");
			var _up_incentive_amt1 = $("input[name='up_incentive_amt1'][data-prpsdid="+_prpsdId+"]");
			var _case_rate1 = $("input[name='case_rate1'][data-prpsdid="+_prpsdId+"]");
			var _vs_std1 = $("input[name='vs_std1'][data-prpsdid="+_prpsdId+"]");
			var _std_case_rate1 = $("input[name='std_case_rate1'][data-prpsdid="+_prpsdId+"]");
	
			var _incentive_amt1_t = $("input[name='incentive_amt1_t'][data-prpsdid="+_prpsdId+"]");
			var _up_case9l_t = $("input[name='up_case9l_t'][data-prpsdid="+_prpsdId+"]");
			var _up_incentive_amt1_t = $("input[name='up_incentive_amt1_t'][data-prpsdid="+_prpsdId+"]");
			var _case_rate1_t = $("input[name='case_rate1_t'][data-prpsdid="+_prpsdId+"]");
			var _vs_std1_t = $("input[name='vs_std1_t'][data-prpsdid="+_prpsdId+"]");
			
			var _sumIncentive_amt = 0;
			for(var i=0; i< _unitIncentive_amt.length; i++){
				var _vSum = (Number(getNumString(_unitIncentive_amt[i].value)) * Number(getNumString(_delivery_cnt1[i].value)));
				if(!isNaN(_vSum)){
					_sumIncentive_amt +=_vSum;
				}
			}
			
			for(var i=0; i< _incentive_amt1.length; i++){
				_incentive_amt1[i].value = numberWithCommas(_sumIncentive_amt);
			}
			for(var i=0; i< _incentive_amt1_t.length; i++){
				_incentive_amt1_t[i].value = numberWithCommas(_sumIncentive_amt);
			}
			
			var _sumCaseRate = 0;
			if(_up_incentive_amt1_t.length ==0 ||_up_case9l_t.length==0 || _sumIncentive_amt ==0 ){
				//return;
			}
			if(isFinite( (Number(getNumString(_up_incentive_amt1_t[0].value)) + Number(_sumIncentive_amt)) /getNumString(_up_case9l_t[0].value))){
				_sumCaseRate= Number(((Number(getNumString(_up_incentive_amt1_t[0].value)) + Number(_sumIncentive_amt)) /getNumString(_up_case9l_t[0].value)).toFixed(2));
			}else{
				return;
			} 
			for(var i=0; i< _case_rate1_t.length; i++){
				_case_rate1_t[i].value = numberWithCommas(_sumCaseRate);
			}
			
			for(var i=0; i< _case_rate1.length; i++){
				_case_rate1[i].value = numberWithCommas(_sumCaseRate);
			}
			
			if(_std_case_rate1.length ==0 ){
				return;
			}
			var _sumStdCaseRate = 0;
			_sumStdCaseRate = Number(Number(getNumString(_std_case_rate1[0].value)) - Number(_sumCaseRate));
			for(var i=0; i< _vs_std1.length; i++){
				_vs_std1[i].value = numberWithCommas(_sumStdCaseRate);
			}
			for(var i=0; i< _vs_std1_t.length; i++){
				_vs_std1_t[i].value =numberWithCommas(_sumStdCaseRate);
			}
			
			var _pUnitIncentive_amt1 = $("input[name='unit_incentive_amt1']");
			
			var _tmpSumary =0;
			for(var i=0; i<_pUnitIncentive_amt1.length;i++){
				_tmpSumary += Number(getNumString(_pUnitIncentive_amt1[i].value));
			}
			$("#s_unit_incentive_amt1").val(numberWithCommas(_tmpSumary));
			
			var _pDelivery_cnt1 = $("input[name='delivery_cnt1']");
			 _tmpSumary =0;
			for(var i=0; i<_pDelivery_cnt1.length;i++){
				_tmpSumary += Number(getNumString(_pDelivery_cnt1[i].value));
			}
			$("#s_delivery_cnt1").val(numberWithCommas(_tmpSumary));
			
			var _pIncentive_amt1_t = $("input[name='incentive_amt1_t']");
			 _tmpSumary =0;
			for(var i=0; i<_pIncentive_amt1_t.length;i++){
				_tmpSumary += Number(getNumString(_pIncentive_amt1_t[i].value));
			}
			$("#s_incentive_amt1").val(numberWithCommas(_tmpSumary));
		}
	}
</script>
	
	
<div class="">
	<div class="container-fluid">
		<div class="row" style="padding-top:10px; overflow-x:auto;width:90%;text-align: center; margin: 0 auto;">
			<div class="title">A&P</div> 
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col"  style="width:auto;">품목명</th>
			      <th scope="col"  width="10%">개당 금액</th>
			      <th scope="col"  width="7%">수량</th>
			      <th scope="col"  width="10%">총금액</th>
			      <th scope="col"  width="7%">CASE(9L)</th>
			      <th scope="col"  width="10%">총 광고비</th>
			      <th scope="col"  width="10%">케이스 별 광고비</th>
			      <th scope="col"  width="10%">광고비 차액</th>
			      <th scope="col"  width="13%">REMARK</th>
			    </tr>
			  </thead>
			  <tbody id="view2">
			  	 	<c:forEach items="${ProPosalDList1}" var="i" varStatus="status">
			  	 		<c:set var="aNpSize"  value="0" ></c:set>
			  	 			<tr>
						  		<td colspan="9" class="text-left">${i.PROD_NO_SITEM_NM2}
						  		</td>
						  	</tr>
			  	 		<c:forEach items="${ProPosalDList2}" var="j" varStatus="st">
			  	 			<c:if test="${i.PRPSD_ID eq j.UP_PRPSD_ID}">
			  	 			<tr>
				  	 			<td>
						  			<input type="text" id="prodNoSitemNm1" class="form-control" name="prodNoSitemNm1"  value="${j.PROD_NO_SITEM_NM}">
						  			<input type="hidden" id="prodNoSitemCd1" class="form-control" name="prodNoSitemCd1" value="">
						  		</td>
						  		<td><input type="text" id="unit_incentive_amt1" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="unit_incentive_amt1" onkeyup="javascript:step2Calcu(this);" value="<fmt:formatNumber value="${j.UNIT_INCENTIVE_AMT}" pattern="#,###" />"></td>
						  		<td><input type="text" id="delivery_cnt1" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="delivery_cnt1" value="${j.DELIVERY_CNT}" onkeyup="javascript:step2Calcu(this);"></td>
						  		<c:if test="${aNpSize eq 0}">
						  		<td rowspan="3" class="align-middle"><input type="text" id="incentive_amt1_t" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="incentive_amt1_t"  value="<fmt:formatNumber value="${j.INCENTIVE_AMT}" pattern="#,###" />" readonly></td>
						  		<td rowspan="3" class="align-middle"><input type="text" id="up_case9l1_t" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="up_case9l_t"  value="${i.CASE9L}" readonly></td>
						  		<td rowspan="3" class="align-middle"><input type="text" id="up_incentive_amt1_t" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="up_incentive_amt1_t" value="${i.INCENTIVE_AMT}" readonly></td>
						  		<td rowspan="3" class="align-middle"><input type="text" id="case_rate1_t" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="case_rate1_t" value="${j.CASE_RATE}" readonly></td>
						  		<td rowspan="3" class="align-middle"><input type="text" id="vs_std1_t" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="vs_std1_t" value="${j.VS_STD}" readonly></td>
						  		</c:if>
						  		<td><input type="text" id="rmk_cntn1" class="form-control" name="rmk_cntn1" value="${j.RMK_CNTN}">
						  				<input type="hidden" id="incentive_amt1" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="incentive_amt1"  value="${j.INCENTIVE_AMT}" readonly>
						  				<input type="hidden" id="up_case9l1" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="up_case9l" value="${i.CASE9L}" readonly>
						  				<input type="hidden" id="up_incentive_amt1" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="up_incentive_amt1" value="${i.INCENTIVE_AMT}" readonly>
						  				<input type="hidden" id="case_rate1" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="case_rate1" value="${j.CASE_RATE}" readonly>
						  				<input type="hidden" id="vs_std1" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="vs_std1" value="${j.VS_STD}" readonly>
						  				<input type="hidden" id="std_case_rate1" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="std_case_rate1" value="${i.STD_CASE_RATE}" readonly>
						  				<input type="hidden" id="up_prpsd_id" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="up_prpsd_id" value="${i.PRPSD_ID}" readonly>
						  		</td>
						  	</tr>
						  	<c:set var="aNpSize"  value="${aNpSize+1}" ></c:set>
						  	</c:if>
			  	 		</c:forEach>
			  	 		<c:forEach var="j" begin="1"  end="${3-aNpSize}" step="1" varStatus="js">
			  	 			<tr>
				  	 			<td>
						  			<input type="text" id="prodNoSitemNm1" class="form-control" name="prodNoSitemNm1"  value="">
						  			<input type="hidden" id="prodNoSitemCd1" class="form-control" name="prodNoSitemCd1" value="">
						  		</td>
						  		<td><input type="text" id="unit_incentive_amt1" class="form-control" data-prpsdid="${i.PRPSD_ID}" onkeyup="javascript:step2Calcu(this);" name="unit_incentive_amt1"  value=""></td>
						  		<td><input type="text" id="delivery_cnt1" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="delivery_cnt1" value="" onkeyup="javascript:step2Calcu(this);"></td>
						  		<c:if test="${aNpSize eq 0 and js.index eq 1}">
						  		<td rowspan="3" class="align-middle"><input type="text" id="incentive_amt1_t" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="incentive_amt1_t"  value="" readonly></td>
						  		<td rowspan="3" class="align-middle"><input type="text" id="up_case9l1_t" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="up_case9l_t" value="${i.CASE9L}" readonly></td>
						  		<td rowspan="3" class="align-middle"><input type="text" id="up_incentive_amt1_t" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="up_incentive_amt1_t" value="${i.INCENTIVE_AMT}" readonly></td>
						  		<td rowspan="3" class="align-middle"><input type="text" id="case_rate1_t" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="case_rate1_t" value="" readonly></td>
						  		<td rowspan="3" class="align-middle"><input type="text" id="vs_std1_t" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="vs_std1_t" value="" readonly></td>
						  		</c:if>
						  		<td><input type="text" id="rmk_cntn1" class="form-control" name="rmk_cntn1" value="">
						  			<input type="hidden" id="incentive_amt1" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="incentive_amt1"  value="" readonly>
					  				<input type="hidden" id="up_case9l1" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="up_case9l" value="${i.CASE9L}" readonly>
					  				<input type="hidden" id="up_incentive_amt1" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="up_incentive_amt1" value="${i.INCENTIVE_AMT}" readonly>
					  				<input type="hidden" id="case_rate1" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="case_rate1" value="" readonly>
					  				<input type="hidden" id="vs_std1" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="vs_std1" value="" readonly>
					  				<input type="hidden" id="std_case_rate1" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="std_case_rate1" value="${i.STD_CASE_RATE}" readonly>
					  				<input type="hidden" id="up_prpsd_id" class="form-control" data-prpsdid="${i.PRPSD_ID}" name="up_prpsd_id" value="${i.PRPSD_ID}" readonly>
						  		</td>
						  	</tr>
			  	 		</c:forEach>
			  	 </c:forEach>
			  </tbody>
			</table>
			<table class="table border">
			  <thead>
			    <tr>
			      <th scope="col"  style="width:auto;">SUBTOTAL</th>
			      <th scope="col"  width="10%"><input type="text" class="form-control" name="s_unit_incentive_amt1" id="s_unit_incentive_amt1" readonly/></th>
			      <th scope="col"  width="7%"><input type="text" class="form-control" name="s_delivery_cnt1" id="s_delivery_cnt1" readonly/></th>
			      <th scope="col"  width="10%"><input type="text" class="form-control" name="s_incentive_amt1" id="s_incentive_amt1" readonly/></th>
			      <th scope="col"  width="7%">&nbsp;</th>
			      <th scope="col"  width="10%">&nbsp;</th>
			      <th scope="col"  width="10%">&nbsp;</th>
			      <th scope="col"  width="10%">&nbsp;</th>
			      <th scope="col"  width="13%">&nbsp;</th>
			    </tr>
			  </thead>
			</table>
		</div>
		<div class="row" style="padding: 5px 0px;">
			<div class="col-12 col-sm-6 text-left">
				<input class="btn btn-light" type="button" id="proposalList" value="목록">
				<input class="btn btn-light" type="button" id="proPosalForm01_List" value="STEP01 수정">
			</div>
			<div class="col-12 col-sm-6 text-right">
				<input type="hidden" name="gubun" id="gubun" value="${gubun}">
				<c:if test="${gubun ne 'update'}">
					<input class="btn btn-primary" type="button" id="saveWork2"	value="STEP03 등록">
				</c:if>
				<c:if test="${gubun eq 'update' }">
					<input class="btn btn-primary" type="button" id="saveWork2"	value="STEP02 수정">
				</c:if>

			</div>
		</div>
	</div>
</div>

<form name="insert02" method="post">
	<input type="hidden" name="prps_id" id="prps_id" value="${prps_id}"/>
	<input type="hidden" name="gubun" value="${gubun}"/>
</form>

<form name="viewForm" method="post">
	<input type="hidden" name="prps_id"  value="${prps_id}"/> 
	<input type="hidden" name="gubun" value="${gubun}"/>
</form>
<script>
<c:if test="${gubun eq 'update' }">
</c:if>
</script>
