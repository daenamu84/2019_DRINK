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
		
		
		//변경버튼 
		$("#cntUpdate").click(function(){
			 var productCnt = $("#productCnt").val();
			 var supplyCnt = $("#supplyCnt").val();
			 var productLayer = $("#view1 > tr");
			 
			 if(productLayer.length > productCnt){
				 for(var i = 0; i< productLayer.length; i++){
					 if(productCnt  <=  i){
						 $($("#view1 > tr")[productCnt]).remove()
					 }
				 }
			 }else if(productLayer.length < productCnt){
				 for(var y= 0; y< productCnt - productLayer.length ; y++){
				 	//$("#view1").append("<tr><td><span class=\"col-12 col-md-9 float-left\" style=\"padding:0px;\"><input type=\"text\" id=\"prodNoSitemNm\" class=\"form-control float-right\" name=\"prodNoSitemNm\" value=\"\"></span><span class=\"col-12 col-md-3 float-left\" style=\"padding:0px;\"><input class=\"btn btn-dark\" type=\"button\" value=\"검색\" id=\"productInsertLayer\"/></span><input type=\"hidden\" id=\"prodNoSitemCd\" class=\"form-control\" name=\"prodNoSitemCd\" value=\"\"></td><td><input type=\"text\" id=\"deliveryCnt\" class=\"form-control\" name=\"deliveryCnt\" value=\"\"></td><td><input type=\"text\" id=\"deliveryAmt\" class=\"form-control\" name=\"deliveryAmt\" value=\"\"></td><td><input type=\"text\" id=\"dcRate\" class=\"form-control\" name=\"dcRate\" value=\"\"></td><td><input type=\"text\" id=\"lastDeliverAmt\" class=\"form-control\" name=\"lastDeliverAmt\" value=\"\"></td></tr>");
				 	//$("#view1").append("<tr><td><span class=\"col-12 col-md-9 float-left\" style=\"padding:0px;\"><input type=\"text\" id=\"prodNoSitemNm\" class=\"form-control float-right\" name=\"prodNoSitemNm\" value=\"\" readonly></span><span class=\"col-12 col-md-3 float-left\" style=\"padding:0px;\"><input class=\"btn btn-dark\" type=\"button\" value=\"검색\" id=\"productInsertLayer\"/></span><input type=\"hidden\" id=\"prodNoSitemCd\" class=\"form-control\" name=\"prodNoSitemCd\" value=\"\"></td><td><input type=\"text\" id=\"std_case_rate\" class=\"form-control\" name=\"std_case_rate\" readonly /></td><td><input type=\"text\" id=\"delivery_cnt\" class=\"form-control\" name=\"delivery_cnt\" onkeyup=\"javascript:case9l_calcul()\"></td><td><input type=\"text\" id=\"case9l\" class=\"form-control\" name=\"case9l\" readonly></td><td><input type=\"text\" id=\"case_rate\" class=\"form-control\" name=\"case_rate\" readonly></td><td><input type=\"text\" id=\"unit_incentive_amt\" class=\"form-control\" name=\"unit_incentive_amt\" onkeyup=\"javascript:incentive_amt_calcul()\"  ></td><td><input type=\"text\" id=\"incentive_amt\" class=\"form-control\" name=\"incentive_amt\" readonly></td><td><input type=\"text\" id=\"vs_std\" class=\"form-control\" name=\"vs_std\" readonly></td></tr>");
					 //$("#view1").append("<tr><td><span class=\"col-12 col-md-9 float-left\" style=\"padding:0px;\"><input type=\"text\" id=\"prodNoSitemNm\" class=\"form-control float-right\" name=\"prodNoSitemNm\" value=\"\" readonly></span><span class=\"col-12 col-md-3 float-left\" style=\"padding:0px;\"><input class=\"btn btn-dark\" type=\"button\" value=\"검색\" id=\"productInsertLayer\"/></span><input type=\"hidden\" id=\"prodNoSitemCd\" class=\"form-control\" name=\"prodNoSitemCd\" value=\"\"></td><td><input type=\"text\" id=\"std_case_rate\" class=\"form-control\" name=\"std_case_rate\" readonly /></td><td><input type=\"text\" id=\"delivery_cnt\" class=\"form-control\" name=\"delivery_cnt\" onkeyup=\"javascript:case9l_calcul()\"></td><td><input type=\"text\" id=\"case9l\" class=\"form-control\" name=\"case9l\" readonly></td><td><input type=\"text\" id=\"unit_incentive_amt\" class=\"form-control\" name=\"unit_incentive_amt\" onkeyup=\"javascript:incentive_amt_calcul()\"  ></td><td><input type=\"text\" id=\"incentive_amt\" class=\"form-control\" name=\"incentive_amt\" readonly></td><td><input type=\"text\" id=\"case_rate\" class=\"form-control\" name=\"case_rate\" readonly></td><td><input type=\"text\" id=\"vs_std\" class=\"form-control\" name=\"vs_std\" readonly></td></tr>");
					 $("#view1").append("<tr><td><span class=\"col-12 col-md-9 float-left\" style=\"padding:0px;\"><input type=\"hidden\" id=\"prpsd_id\" name=\"prpsd_id\"><input type=\"text\" id=\"prodNoSitemNm\" class=\"form-control float-right\" name=\"prodNoSitemNm\" value=\"\" readonly></span><span class=\"col-12 col-md-3 float-left\" style=\"padding:0px;\"><input class=\"btn btn-dark\" type=\"button\" value=\"검색\" id=\"productInsertLayer\"/></span><input type=\"hidden\" id=\"prodNoSitemCd\" class=\"form-control\" name=\"prodNoSitemCd\" value=\"\"></td><td><input type=\"text\" id=\"std_case_rate\" class=\"form-control\" name=\"std_case_rate\" readonly /></td><td><input type=\"text\" id=\"delivery_cnt\" class=\"form-control\" name=\"delivery_cnt\" onkeyup=\"javascript:case9l_calcul()\"></td><td><input type=\"text\" id=\"case9l\" class=\"form-control\" name=\"case9l\" readonly></td><td><input type=\"text\" id=\"unit_incentive_amt\" class=\"form-control\" name=\"unit_incentive_amt\" onkeyup=\"javascript:incentive_amt_calcul()\"  ></td><td><input type=\"text\" id=\"incentive_amt\" class=\"form-control\" name=\"incentive_amt\" readonly></td><td><input type=\"text\" id=\"case_rate\" class=\"form-control\" name=\"case_rate\" readonly></td><td><input type=\"text\" id=\"vs_std\" class=\"form-control\" name=\"vs_std\" readonly></td></tr>");					 
				 }
			 }
			 
			 
			 vs_std_calcul();
			 incentive_amt1_calcul();
		});
		
		// modal - 서브 브랜드 검색 
		$(document).on("change","#iBrandId", _.debounce( function(){
			if(ajaxFlag)return;
			ajaxFlag=true;
			$("#iSubBrandId").empty();
			$.ajax({      
			    type:"GET",  
			    url:"/brandSCd?BrandId="+$(this).val()+"&bsearch=proposal",      
			    dataType:"html",
			    traditional:true,
			    success:function(args){   
			    	$("#iSubBrandId").html(args);
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    }  
			});
		},0));


		// 제품 검색
		$(document).on("change","#iSubBrandId", _.debounce( function(){
			if(ajaxFlag)return;
			ajaxFlag=true;
			var iBrandId = $("#iBrandId option:selected").val() ;
			var iSubBrandId = $("#iSubBrandId option:selected").val() ;
			
			
			$.ajax({      
			    type:"GET",  
			    url:"/productBrandSearch?BrandId="+iBrandId+"&subBrandID="+iSubBrandId+"&bsearch=proposal",      
			    dataType:"html",
			    traditional:true,
			    success:function(args){  
			    	$("#prodcutseach").html(args);
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    }  
			});
		},0));
		
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
			document.insert02.action = "/proPosalForm02-1";
			document.insert02.submit();
		}
		
		//등록
		$("#saveWork2").click(function(){			
			if(ajaxFlag)return;
			var prps_id = $("#prps_id").val();
			var prpsd_id = $("input[name='prpsd_id']");
			var prodNoSitemNm = $("input[name='prodNoSitemNm']");
			var prodNoSitemCd = $("input[name='prodNoSitemCd']");
			var std_case_rate = $("input[name='std_case_rate']");
			var delivery_cnt = $("input[name='delivery_cnt']");
			var case9l = $("input[name='case9l']");
			var case_rate = $("input[name='case_rate']");
			var unit_incentive_amt = $("input[name='unit_incentive_amt']");
			var incentive_amt = $("input[name='incentive_amt']");
			var vs_std = $("input[name='vs_std']");
			
			var prodNoSitemNm1 = $("input[name='prodNoSitemNm1']");
			var prodNoSitemCd1 = $("input[name='prodNoSitemCd1']");
			var unit_incentive_amt1 = $("input[name='unit_incentive_amt1']");
			var delivery_cnt1 = $("input[name='delivery_cnt1']");
			var incentive_amt1 = $("input[name='incentive_amt1']");
			var rmk_cntn1 = $("input[name='rmk_cntn1']");
			
			var _addParam = [];
			
			
			
			for (var i = 0; i < prodNoSitemNm.length; i++) {
				if(prodNoSitemNm[i].value ==""){
					continue;
				}
				
				_addParam.push({"prpsd_id":prpsd_id[i].value,"prodNoSitemNm":prodNoSitemNm[i].value,"prodNoSitemCd":prodNoSitemCd[i].value,"std_case_rate":getNumString(std_case_rate[i].value),"delivery_cnt":delivery_cnt[i].value,"case9l":case9l[i].value,"case_rate":getNumString(case_rate[i].value),"unit_incentive_amt":getNumString(unit_incentive_amt[i].value),"incentive_amt":getNumString(incentive_amt[i].value),"vs_std":getNumString(vs_std[i].value)});
			}
			
			var gubun = $("#gubun").val();
			
			var url = "";
			if (gubun == "") {
				url = "/proposalWork2";
			}else{
				url = "/proposalUpdate2";
			}
			
			$.ajax({      
			    type:"POST",  
			    url:url,
			    data: JSON.stringify({"_addPram":_addParam,"prps_id":prps_id}),
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
		
		var std_case_rate = numberWithCommas(arg3);
		console.log(std_case_rate);
		$(obj).parent().parent().parent().find('input[name="std_case_rate"]').val(std_case_rate);   
		if(arg3!=""){
			case9l_calcul();
			vs_std_calcul();
		}
		$("#popLayer").modal("hide");
	}
	
	// 1.case 9l(기준) 계산
	// 출고수량 / 12
	function case9l_calcul() {
		var v_case9l = null;

		var fileValue = $("input[name='delivery_cnt']").length;
		var fileData = new Array(fileValue);
		for (var i = 0; i < fileValue; i++) {
			if ($("input[name='delivery_cnt']")[i].value != "") {
				$("input[name='case9l']")[i].value = $("input[name='delivery_cnt']")[i].value / 12;
				incentive_amt_calcul();
			}

		}
	}

	//2.STD caserate 계산 (case_rate)
	// 제품caser ate * case(9l) 
	// std_case_rate *case9l
	function stdcaserate_calcul() {
		var fileValue = $("input[name='std_case_rate']").length;
		//console.log("fileValue=" + fileValue);
		var fileData = new Array(fileValue);
		for (var i = 0; i < fileValue; i++) {
			//fileData[i] = $("input[name='std_case_rate']")[i].value * $("input[name='case9l']")[i].value);
			if ($("input[name='case9l']")[i].value != "") {
				$("input[name='case_rate']")[i].value = numberWithCommas(getNumString($("input[name='std_case_rate']")[i].value) * $("input[name='case9l']")[i].value);
			}
		}
	}

	//3.인센티브 계산 (incentive_amt)
	// 출고수량 * 인센티브 병당 가격
	// delivery_cnt * unit_incentive_amt
	function incentive_amt_calcul() {
		var fileValue = $("input[name='unit_incentive_amt']").length;
		var fileData = new Array(fileValue);
		for (var i = 0; i < fileValue; i++) {
			//fileData[i] = $("input[name='std_case_rate']")[i].value * $("input[name='case9l']")[i].value);
			if ($("input[name='unit_incentive_amt']")[i].value != "") {
				$("input[name='incentive_amt']")[i].value = numberWithCommas($("input[name='delivery_cnt']")[i].value * getNumString($("input[name='unit_incentive_amt']")[i].value));
				//$("input[name='unit_incentive_amt']")[i].value =  numberWithCommas(getNumString($("input[name='unit_incentive_amt']")[i].value));
				$("input[name='case_rate']")[i].value = numberWithCommas(getNumString($("input[name='incentive_amt']")[i].value) / $("input[name='case9l']")[i].value);
				vs_std_calcul();
			}
		}
	}
	
	//4.vs STD  계산 vs_std
	// STD caserate - 인센티브
	// case_rate - incentive_amt
	function vs_std_calcul() {
		var fileValue = $("input[name='incentive_amt']").length;
		var v_std_case_rate = 0;
		var v_delivery_cnt = 0;
		var v_case9l = 0;
		var v_case_rate = 0;
		var v_unit_incentive_amt = 0;
		var v_incentive_amt = 0;
		var v_vs_std = 0;
		
		
		var fileData = new Array(fileValue);
		for (var i = 0; i < fileValue; i++) {
			//fileData[i] = $("input[name='std_case_rate']")[i].value * $("input[name='case9l']")[i].value);
			if ($("input[name='incentive_amt']")[i].value != "") {
				$("input[name='vs_std']")[i].value = numberWithCommas(getNumString($("input[name='std_case_rate']")[i].value) - getNumString($("input[name='case_rate']")[i].value));
				v_std_case_rate 	=  Number(v_std_case_rate) + getNumString($("input[name='std_case_rate']")[i].value);
				v_delivery_cnt 	=  Number(v_delivery_cnt) + getNumString($("input[name='delivery_cnt']")[i].value);
				v_case9l		=  Number(v_case9l) + getNumString($("input[name='case9l']")[i].value);
				v_case_rate 		=  Number(v_case_rate) + getNumString($("input[name='case_rate']")[i].value);
				v_unit_incentive_amt =  Number(v_unit_incentive_amt) + getNumString($("input[name='unit_incentive_amt']")[i].value);
				v_incentive_amt =  Number(v_incentive_amt) + getNumString($("input[name='incentive_amt']")[i].value);
				v_vs_std 		=  Number(v_vs_std) + getNumString($("input[name='vs_std']")[i].value);
				
				$("#sum_std_case_rate").val(numberWithCommas(v_std_case_rate));
				$("#sum_delivery_cnt").val(numberWithCommas(v_delivery_cnt));
				$("#sum_case9l").val(numberWithCommas(v_case9l));
				$("#sum_case_rate").val(numberWithCommas(v_case_rate));
				$("#sum_unit_incentive_amt").val(numberWithCommas(v_unit_incentive_amt));
				$("#sum_incentive_amt").val(numberWithCommas(v_incentive_amt));
				$("#sum_vs_std").val(numberWithCommas(v_vs_std));
				
			}
		}
	}

	// A&P 계산 incentive_amt1
	function incentive_amt1_calcul() {
		
		var v_unit_incentive_amt1 = 0;
		var v_delivery_cnt1 = 0;
		var v_incentive_amt1 = 0;
		
		var fileValue = $("input[name='unit_incentive_amt1']").length;
		var fileData = new Array(fileValue);
		for (var i = 0; i < fileValue; i++) {
			//fileData[i] = $("input[name='std_case_rate']")[i].value * $("input[name='case9l']")[i].value);
			if ($("input[name='delivery_cnt1']")[i].value != "") {
				
				$("input[name='incentive_amt1']")[i].value = numberWithCommas(getNumString($("input[name='unit_incentive_amt1']")[i].value) * $("input[name='delivery_cnt1']")[i].value);
				$("input[name='unit_incentive_amt1']")[i].value =  numberWithCommas(getNumString($("input[name='unit_incentive_amt1']")[i].value));
				
				v_unit_incentive_amt1 	=  Number(v_unit_incentive_amt1) + getNumString($("input[name='unit_incentive_amt1']")[i].value);
				v_delivery_cnt1 		=  Number(v_delivery_cnt1) + Number($("input[name='delivery_cnt1']")[i].value);
				v_incentive_amt1   		=  Number(v_incentive_amt1) + getNumString($("input[name='incentive_amt1']")[i].value);
				
				$("#s_unit_incentive_amt1").val(numberWithCommas(v_unit_incentive_amt1));
				$("#s_delivery_cnt1").val(v_delivery_cnt1);
				$("#s_incentive_amt1").val(numberWithCommas(v_incentive_amt1));
				
			}
		}
	}
</script>
	
	
<div class="">
	<div class="container-fluid">
		<div class="row">			
			<div class="title col col-12  col-sm-;5" style="padding: 1px 0px;">◈  STEP2. PROPOSAL 제품/지원목록 등록</div> 
			<label class="col col-12 col-sm-1" style="padding: 1px 0px;">제안제품수</label>
			<div class="col col-12 col-sm-2" style="padding: 1px 0px;">
					<select name="productCnt" class="form-control" id="productCnt">
								<option value="1" <c:if test="${fn:length(ProPosalDList1) eq '1'}">selected </c:if>>1</option>
								<option value="2" <c:if test="${fn:length(ProPosalDList1) eq '2'}">selected </c:if>>2</option>
								<option value="3" <c:if test="${fn:length(ProPosalDList1) eq '3'}">selected </c:if>>3</option>
								<option value="4" <c:if test="${fn:length(ProPosalDList1) eq '4'}">selected </c:if>>4</option>
								<option value="5" <c:if test="${fn:length(ProPosalDList1) eq '5'}">selected </c:if><c:if test="${gubun ne 'update'}">selected </c:if>>5</option>
								<option value="6" <c:if test="${fn:length(ProPosalDList1) eq '6'}">selected </c:if>>6</option>
								<option value="7" <c:if test="${fn:length(ProPosalDList1) eq '7'}">selected </c:if>>7</option>
								<option value="8" <c:if test="${fn:length(ProPosalDList1) eq '8'}">selected </c:if>>8</option>
								<option value="9" <c:if test="${fn:length(ProPosalDList1) eq '9'}">selected </c:if>>9</option>
								<option value="10" <c:if test="${fn:length(ProPosalDList1) eq '10'}">selected </c:if>>10</option>
					</select>
			</div>
			<div class="col col-12 col-sm-1" style="padding: 1px 0px;">
					<input class="btn btn-primary" type="button" id="cntUpdate" value="변경">
					<input type="hidden" id="prps_id" name="prps_id" value="${prps_id}">
			</div>
		</div>
		<div class="row" style="padding-top:10px; overflow-x:auto; width:90%;text-align: center; margin: 0 auto;" >
			<div class="title"> 인센티브</div> 
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col" style="width:auto">제품명</th>
			      <th scope="col" width="10%">STD CASE RATE</th>
			      <th scope="col" width="7%">출고수량</th>
			      <th scope="col" width="10%">CASE(9L)</th>
			      <th scope="col" width="10%">인센티브 병당가격</th>
			      <th scope="col" width="10%">인센티브</th>
			      <th scope="col" width="10%">CASE RATEE</th>
			      <th scope="col" width="10%">VS STD</th>
			    </tr>
			  </thead>
			  <tbody id="view1">
			  <c:if test="${gubun ne 'update'}">
			  	<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="hidden" id="prpsd_id" name="prpsd_id">
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="" readonly>
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer"/>
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="">
			  		</td>
			  		<td><input type="text" id="std_case_rate" class="form-control" name="std_case_rate" readonly /></td>
			  		<td><input type="text" id="delivery_cnt" class="form-control" name="delivery_cnt" onkeyup="javascript:case9l_calcul()"></td>
			  		<td><input type="text" id="case9l" class="form-control" name="case9l" readonly></td>
			  		<td><input type="text" id="unit_incentive_amt" class="form-control" name="unit_incentive_amt" onkeyup="javascript:incentive_amt_calcul()"  ></td>
			  		<td><input type="text" id="incentive_amt" class="form-control" name="incentive_amt" readonly></td>
			  		<td><input type="text" id="case_rate" class="form-control" name="case_rate" readonly></td>
			  		<td><input type="text" id="vs_std" class="form-control" name="vs_std" readonly></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="hidden" id="prpsd_id" name="prpsd_id">
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="" readonly>
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer" />
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="">
			  		</td>
			  		<td><input type="text" id="std_case_rate" class="form-control" name="std_case_rate" readonly /></td>
			  		<td><input type="text" id="delivery_cnt" class="form-control" name="delivery_cnt" onkeyup="javascript:case9l_calcul()"></td>
			  		<td><input type="text" id="case9l" class="form-control" name="case9l" readonly></td>
			  		<td><input type="text" id="unit_incentive_amt" class="form-control" name="unit_incentive_amt" onkeyup="javascript:incentive_amt_calcul()"></td>
			  		<td><input type="text" id="incentive_amt" class="form-control" name="incentive_amt" readonly></td>
			  		<td><input type="text" id="case_rate" class="form-control" name="case_rate" readonly></td>
			  		<td><input type="text" id="vs_std" class="form-control" name="vs_std" readonly></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="hidden" id="prpsd_id" name="prpsd_id">
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="" readonly>
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer"/>
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="">
			  		</td>
			  		<td><input type="text" id="std_case_rate" class="form-control" name="std_case_rate" readonly /></td>
			  		<td><input type="text" id="delivery_cnt" class="form-control" name="delivery_cnt" onkeyup="javascript:case9l_calcul()"></td>
			  		<td><input type="text" id="case9l" class="form-control" name="case9l" readonly></td>
			  		<td><input type="text" id="unit_incentive_amt" class="form-control" name="unit_incentive_amt" onkeyup="javascript:incentive_amt_calcul()"></td>
			  		<td><input type="text" id="incentive_amt" class="form-control" name="incentive_amt" readonly></td>
			  		<td><input type="text" id="case_rate" class="form-control" name="case_rate" readonly></td>
			  		<td><input type="text" id="vs_std" class="form-control" name="vs_std" readonly></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="hidden" id="prpsd_id" name="prpsd_id">
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="" readonly>
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer"/>
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="">
			  		</td>
			  		<td><input type="text" id="std_case_rate" class="form-control" name="std_case_rate" readonly /></td>
			  		<td><input type="text" id="delivery_cnt" class="form-control" name="delivery_cnt" onkeyup="javascript:case9l_calcul()"></td>
			  		<td><input type="text" id="case9l" class="form-control" name="case9l" readonly></td>
			  		<td><input type="text" id="unit_incentive_amt" class="form-control" name="unit_incentive_amt" onkeyup="javascript:incentive_amt_calcul()"></td>
			  		<td><input type="text" id="incentive_amt" class="form-control" name="incentive_amt" readonly></td>
			  		<td><input type="text" id="case_rate" class="form-control" name="case_rate" readonly></td>
			  		<td><input type="text" id="vs_std" class="form-control" name="vs_std" readonly></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="hidden" id="prpsd_id" name="prpsd_id">
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="" readonly>
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer"/>
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="">
			  		</td>
			  		<td><input type="text" id="std_case_rate" class="form-control" name="std_case_rate" readonly /></td>
			  		<td><input type="text" id="delivery_cnt" class="form-control" name="delivery_cnt" onkeyup="javascript:case9l_calcul()"></td>
			  		<td><input type="text" id="case9l" class="form-control" name="case9l" readonly></td>
			  		<td><input type="text" id="unit_incentive_amt" class="form-control" name="unit_incentive_amt" onkeyup="javascript:incentive_amt_calcul()"></td>
			  		<td><input type="text" id="incentive_amt" class="form-control" name="incentive_amt" readonly></td>
			  		<td><input type="text" id="case_rate" class="form-control" name="case_rate" readonly></td>
			  		<td><input type="text" id="vs_std" class="form-control" name="vs_std" readonly></td>
			  	</tr>
			  </c:if>
			  <c:if test="${gubun eq 'update' }">
			  	<c:forEach items="${ProPosalDList1}" var="i" varStatus="status">
				<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="hidden" id="prpsd_id" name="prpsd_id"  value="${i.PRPSD_ID}" >
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="${i.PROD_NO_SITEM_NM2}" readonly>
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer"/>
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="${i.PROD_NO_SITEM_NM}">
			  		</td>
			  		<td><input type="text" id="std_case_rate" class="form-control" name="std_case_rate"  value="<fmt:formatNumber value="${i.STD_CASE_RATE}" pattern="#,###" />" readonly /></td>
			  		<td><input type="text" id="delivery_cnt" class="form-control" name="delivery_cnt"  value="${i.DELIVERY_CNT}" onkeyup="javascript:case9l_calcul()"></td>
			  		<td><input type="text" id="case9l" class="form-control" name="case9l" value="${i.CASE9L}"  readonly></td>
			  		<td><input type="text" id="unit_incentive_amt" class="form-control" name="unit_incentive_amt"  value="<fmt:formatNumber value="${i.UNIT_INCENTIVE_AMT}" pattern="#,###" />" onkeyup="javascript:incentive_amt_calcul()"  ></td>
			  		<td><input type="text" id="incentive_amt" class="form-control" name="incentive_amt" value="<fmt:formatNumber value="${i.INCENTIVE_AMT}" pattern="#,###" />" readonly></td>
			  		<td><input type="text" id="case_rate" class="form-control" name="case_rate" value="<fmt:formatNumber value="${i.CASE_RATE}" pattern="#,###" />" readonly></td>
			  		<td><input type="text" id="vs_std" class="form-control" name="vs_std" value="<fmt:formatNumber value="${i.VS_STD}" pattern="#,###" />" readonly></td>
			  	</tr>
				</c:forEach>
			  </c:if>
			  </tbody>
			</table>
			<table class="table border">
				<tr>
					<th scope="col" style="width: auto">SUBTOTAL</th>
					<th scope="col" width="10%"><input type="text" id="sum_std_case_rate" class="form-control" name="sum_std_case_rate" readonly /></th>
					<th scope="col" width="7%"><input type="text" id="sum_delivery_cnt" class="form-control" name="sum_delivery_cnt" readonly /></th>
					<th scope="col" width="10%"><input type="text" id="sum_case9l" class="form-control" name="sum_case9l" readonly /></th>
					<th scope="col" width="10%"><input type="text" id="sum_unit_incentive_amt" class="form-control" name="sum_unit_incentive_amt" readonly /></th>
					<th scope="col" width="10%"><input type="text" id="sum_incentive_amt" class="form-control" name="sum_incentive_amt" readonly /></th>
					<th scope="col" width="10%"><input type="text" id="sum_case_rate" class="form-control" name="sum_case_rate" readonly /></th>
					<th scope="col" width="10%"><input type="text" id="sum_vs_std" class="form-control" name="sum_vs_std" readonly /></th>
				</tr>
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
	<!-- modal start  -->
	<div id="popLayer" class="modal fade" role="dialog">
		<div class="modal-dialog" style="max-width:640px">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">TB 제품검색</h5>
					<a href="#" class="close" data-dismiss="modal" aria-label="Close"><span
						aria-hidden="true">&times;</span></a>
				</div>
				<div class="modal-body">
					<div class="container-fluid">
						<div class="row" style="padding: 5px 0px;">
							<div class="col-sm-2">브랜드</div>
							<div class="col-sm-3">
								<select class="custom-select" id="iBrandId">
										<option value="">선택하세요</opption>
									<c:forEach var="i" items="${mBrandCd}" varStatus="status">
										<option value="${i.BRAND_ID}">${i.BRAND_NM}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-3">서브 브랜드</div>
							<div class="col-sm-4">
								<select class="custom-select" id="iSubBrandId">
								</select>
							</div>
						</div>
						
					</div>
				</div>
				<div class="modal-footer">
					<div class="container-fluid">
						<div class="row" style="padding: 5px 0px;" id="prodcutseach">
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<input class="btn btn-secondary float-right" type="button"	data-dismiss="modal" value="Close">
				</div>
			</div>
		</div>
	</div>
	<!-- modal  end  -->
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
vs_std_calcul();
incentive_amt1_calcul();
</c:if>
</script>
