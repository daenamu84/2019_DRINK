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
			 var supplyLayer = $("#view2 > tr");
			 
			 
			 if(productLayer.length > productCnt){
				 for(var i = 0; i< productLayer.length; i++){
					 if(productCnt  <=  i){
						 $($("#view1 > tr")[productCnt]).remove()
					 }
				 }
			 }else if(productLayer.length < productCnt){
				 for(var y= 0; y< productCnt - productLayer.length ; y++){
				 	$("#view1").append("<tr><td><span class=\"col-12 col-md-9 float-left\" style=\"padding:0px;\"><input type=\"text\" id=\"prodNoSitemNm\" class=\"form-control float-right\" name=\"prodNoSitemNm\" value=\"\"></span><span class=\"col-12 col-md-3 float-left\" style=\"padding:0px;\"><input class=\"btn btn-dark\" type=\"button\" value=\"검색\" id=\"productInsertLayer\"/></span><input type=\"hidden\" id=\"prodNoSitemCd\" class=\"form-control\" name=\"prodNoSitemCd\" value=\"\"></td><td><input type=\"text\" id=\"deliveryCnt\" class=\"form-control\" name=\"deliveryCnt\" value=\"\"></td><td><input type=\"text\" id=\"deliveryAmt\" class=\"form-control\" name=\"deliveryAmt\" value=\"\"></td><td><input type=\"text\" id=\"dcRate\" class=\"form-control\" name=\"dcRate\" value=\"\"></td><td><input type=\"text\" id=\"lastDeliverAmt\" class=\"form-control\" name=\"lastDeliverAmt\" value=\"\"></td></tr>");
				 }
			 }
			 
			 if(supplyLayer.length > supplyCnt){
				 for(var i = 0; i< supplyLayer.length; i++){
					 if(supplyCnt  <=  i){
						 $($("#view2 > tr")[supplyCnt]).remove()
					 }
				 }
			 }else if(supplyLayer.length < supplyCnt){
				 for(var y= 0; y< supplyCnt - supplyLayer.length ; y++){
					 	$("#view2").append("<tr><td><input type=\"text\" id=\"prodNoSitemNm1\" class=\"form-control\" name=\"prodNoSitemNm1\" value=\"\"><input type=\"hidden\" id=\"prodNoSitemCd1\" class=\"form-control\" name=\"prodNoSitemCd1\" value=\"\"></td><td><input type=\"text\" id=\"deliveryCnt1\" class=\"form-control\" name=\"deliveryCnt1\" value=\"\"></td><td><input type=\"text\" id=\"deliveryAmt1\" class=\"form-control\" name=\"deliveryAmt1\" value=\"\"></td><td><input type=\"text\" id=\"dcRate1\" class=\"form-control\" name=\"dcRate1\" value=\"\"></td><td><input type=\"text\" id=\"lastDeliverAmt1\" class=\"form-control\" name=\"lastDeliverAmt1\" value=\"\"></td></tr>");
					 }
			 }
			 
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
			document.insert02.action = "/proPosalForm03";
			document.insert02.submit();
		}
		
		//등록
		$("#saveWork2").click(function(){			
			if(ajaxFlag)return;
			var prps_id = $("#prps_id").val();
			var prodNoSitemNm = $("input[name='prodNoSitemNm']");
			var prodNoSitemCd = $("input[name='prodNoSitemCd']");
			var deliveryCnt = $("input[name='deliveryCnt']");
			var deliveryAmt = $("input[name='deliveryAmt']");
			var dcRate = $("input[name='dcRate']");
			var lastDeliverAmt = $("input[name='lastDeliverAmt']");
			
			var prodNoSitemNm1 = $("input[name='prodNoSitemNm1']");
			var prodNoSitemCd1 = $("input[name='prodNoSitemCd1']");
			var deliveryCnt1 = $("input[name='deliveryCnt1']");
			var deliveryAmt1 = $("input[name='deliveryAmt1']");
			var dcRate1 = $("input[name='dcRate1']");
			var lastDeliverAmt1 = $("input[name='lastDeliverAmt1']");
			var _addParam = [];
			var _addParam1 = [];
			
			
			for (var i = 0; i < prodNoSitemNm.length; i++) {
				if(prodNoSitemNm[i].value ==""){
					continue;
				}
				
				_addParam.push({"prodNoSitemNm":prodNoSitemNm[i].value,"prodNoSitemCd":prodNoSitemCd[i].value,"deliveryCnt":deliveryCnt[i].value,"deliveryAmt":deliveryAmt[i].value,"dcRate":dcRate[i].value,"lastDeliverAmt":lastDeliverAmt[i].value});
			}
			
			
			for (var i = 0; i < prodNoSitemNm1.length; i++) {
				if(prodNoSitemNm1[i].value ==""){
					continue;
				}
				
				_addParam1.push({"prodNoSitemNm1":prodNoSitemNm1[i].value,"prodNoSitemCd1":prodNoSitemCd1[i].value,"deliveryCnt1":deliveryCnt1[i].value,"deliveryAmt1":deliveryAmt1[i].value,"dcRate1":dcRate1[i].value,"lastDeliverAmt1":lastDeliverAmt1[i].value});
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
			    data: JSON.stringify({"_addPram":_addParam,"_addPram1":_addParam1,"prps_id":prps_id}),
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
	var temp_cnt = null;
	$(document).on("click","input[id='productInsertLayer']",function() {
		$("#popLayer").modal("show");
		popListObj = this;
	});

	
	function setValueDate(arg1, arg2,arg3){
		
		var obj = popListObj;
		$(obj).parent().parent().children().find("#prodNoSitemNm").val(arg2);
		$(obj).parent().parent().find("#prodNoSitemCd").val(arg1);
		$(obj).parent().parent().parent().find('input[name="caserate_amt"]').val(arg3);   
		$("#popLayer").modal("hide");
	}
	
	// 1.case 9l(기준) 계산
	// 출고수량 / 12
	function case9l_calcul(index, d_cnt) {
		var v_case9l = null;
		v_case9l = Math.ceil(d_cnt.value / 12);
		$('input[name="case9l"]').eq(index).val(v_case9l);
		stdcaserate_calcul();
		var fileValue = $("input[name='caserate_amt']").length;
		console.log("fileValue=" + fileValue);
		var fileData = new Array(fileValue);
		for (var i = 0; i < fileValue; i++) {
			fileData[i] = $("input[name='caserate_amt']")[i].value;

		}
	}
	
	//2.STD caserate 계산
	// 제품caser ate * case(9l) 
	function stdcaserate_calcul(){
		var fileValue = $("input[name='caserate_amt']").length;
		console.log("fileValue=" + fileValue);
		var fileData = new Array(fileValue);
		for (var i = 0; i < fileValue; i++) {
			//fileData[i] = $("input[name='caserate_amt']")[i].value * $("input[name='case9l']")[i].value);
			$("input[name='std_case']")[i].value = $("input[name='caserate_amt']")[i].value * $("input[name='case9l']")[i].value;

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
			<label class="col col-12 col-sm-1" style="padding: 1px 0px;">지원품목수</label>
			<div class="col col-12 col-sm-2" style="padding: 1px 0px;">
					<select name="supplyCnt" class="form-control" id="supplyCnt">
								<option value="1" <c:if test="${fn:length(ProPosalDList2) eq '1'}">selected </c:if>>1</option>
								<option value="2" <c:if test="${fn:length(ProPosalDList2) eq '2'}">selected </c:if>>2</option>
								<option value="3" <c:if test="${fn:length(ProPosalDList2) eq '3'}">selected </c:if>>3</option>
								<option value="4" <c:if test="${fn:length(ProPosalDList2) eq '4'}">selected </c:if>>4</option>
								<option value="5" <c:if test="${fn:length(ProPosalDList2) eq '5'}">selected </c:if><c:if test="${gubun ne 'update'}">selected </c:if>>5</option>
								<option value="6" <c:if test="${fn:length(ProPosalDList2) eq '6'}">selected </c:if>>6</option>
								<option value="7" <c:if test="${fn:length(ProPosalDList2) eq '7'}">selected </c:if>>7</option>
								<option value="8" <c:if test="${fn:length(ProPosalDList2) eq '8'}">selected </c:if>>8</option>
								<option value="9" <c:if test="${fn:length(ProPosalDList2) eq '9'}">selected </c:if>>9</option>
								<option value="10" <c:if test="${fn:length(ProPosalDList2) eq '10'}">selected </c:if>>10</option>
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
			      <th scope="col">제품명</th>
			      <th scope="col">제품CASE RATE</th>
			      <th scope="col">출고수량</th>
			      <th scope="col">CASE(9L)</th>
			      <th scope="col">STD CASE RATE</th>
			      <th scope="col">인센티브 병당가격</th>
			      <th scope="col">인센티브</th>
			      <th scope="col">VS STD</th>
			    </tr>
			  </thead>
			  <tbody id="view1">
			  <c:if test="${gubun ne 'update'}">
			  	<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="" readonly>
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer" onClick="temp(0)"/>
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="">
			  		</td>
			  		<td><input type="number" id="caserate_amt" name="caserate_amt" readonly /></td>
			  		<td><input type="number" id="delivery_cnt" class="form-control" name="delivery_cnt" onkeyup="javascript:case9l_calcul(0,this)"></td>
			  		<td><input type="text" id="case9l" class="form-control" name="case9l" readonly></td>
			  		<td><input type="text" id="std_case" class="form-control" name="std_case" readonly></td>
			  		<td><input type="text" id="unit_incentive_amt" class="form-control" name="unit_incentive_amt" ></td>
			  		<td><input type="text" id="incentive_amt" class="form-control" name="incentive_amt" readonly></td>
			  		<td><input type="text" id="vs_std" class="form-control" name="vs_std" readonly></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="" readonly>
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer" onClick="temp(1)"/>
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="">
			  		</td>
			  		<td><input type="number" id="caserate_amt" name="caserate_amt" readonly /></td>
			  		<td><input type="number" id="delivery_cnt" class="form-control" name="delivery_cnt" onkeyup="javascript:case9l_calcul(1,this)"></td>
			  		<td><input type="text" id="case9l" class="form-control" name="case9l" readonly></td>
			  		<td><input type="text" id="std_case" class="form-control" name="std_case" readonly></td>
			  		<td><input type="text" id="unit_incentive_amt" class="form-control" name="unit_incentive_amt" ></td>
			  		<td><input type="text" id="incentive_amt" class="form-control" name="incentive_amt" readonly></td>
			  		<td><input type="text" id="vs_std" class="form-control" name="vs_std" readonly></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="" readonly>
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer" onClick="temp(2)"/>
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="">
			  		</td>
			  		<td><input type="number" id="caserate_amt" name="caserate_amt" readonly /></td>
			  		<td><input type="number" id="delivery_cnt" class="form-control" name="delivery_cnt" onkeyup="javascript:case9l_calcul(2,this)"></td>
			  		<td><input type="text" id="case9l" class="form-control" name="case9l" readonly></td>
			  		<td><input type="text" id="std_case" class="form-control" name="std_case" readonly></td>
			  		<td><input type="text" id="unit_incentive_amt" class="form-control" name="unit_incentive_amt" ></td>
			  		<td><input type="text" id="incentive_amt" class="form-control" name="incentive_amt" readonly></td>
			  		<td><input type="text" id="vs_std" class="form-control" name="vs_std" readonly></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="" readonly>
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer"/>
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="">
			  		</td>
			  		<td><input type="number" id="caserate_amt" name="caserate_amt" readonly /></td>
			  		<td><input type="number" id="delivery_cnt" class="form-control" name="delivery_cnt" onkeyup="javascript:case9l_calcul(3,this)"></td>
			  		<td><input type="text" id="case9l" class="form-control" name="case9l" readonly></td>
			  		<td><input type="text" id="std_case" class="form-control" name="std_case" readonly></td>
			  		<td><input type="text" id="unit_incentive_amt" class="form-control" name="unit_incentive_amt" ></td>
			  		<td><input type="text" id="incentive_amt" class="form-control" name="incentive_amt" readonly></td>
			  		<td><input type="text" id="vs_std" class="form-control" name="vs_std" readonly></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="" readonly>
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer"/>
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="">
			  		</td>
			  		<td><input type="number" id="caserate_amt" name="caserate_amt" readonly /></td>
			  		<td><input type="number" id="delivery_cnt" class="form-control" name="delivery_cnt" onkeyup="javascript:case9l_calcul(4,this)"></td>
			  		<td><input type="text" id="case9l" class="form-control" name="case9l" readonly></td>
			  		<td><input type="text" id="std_case" class="form-control" name="std_case" readonly></td>
			  		<td><input type="text" id="unit_incentive_amt" class="form-control" name="unit_incentive_amt" ></td>
			  		<td><input type="text" id="incentive_amt" class="form-control" name="incentive_amt" readonly></td>
			  		<td><input type="text" id="vs_std" class="form-control" name="vs_std" readonly></td>
			  	</tr>
			  </c:if>
			  <c:if test="${gubun eq 'update' }">
			  	<c:forEach items="${ProPosalDList1}" var="i" varStatus="status">
					<tr>
			  			<td>
				  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
				  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="${i.PROD_NO_SITEM_NM2}">
				  			</span>
				  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
				  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer"/>
				  			</span>
				  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="${i.PROD_NO_SITEM_NM}">
				  		</td>
				  		<td><input type="number" id="caserate_amt" name="caserate_amt" readonly value="${i.CASERATE_AMT}"/></td>
				  		<td><input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" value="${i.DELIVERY_CNT}"></td>
				  		<td><input type="text" id="deliveryAmt" class="form-control" name="deliveryAmt" value="${i.DELIVERY_AMT}"></td>
				  		<td><input type="text" id="dcRate" class="form-control" name="dcRate" value="${i.DC_RATE}"></td>
				  		<td><input type="text" id="lastDeliverAmt" class="form-control" name="lastDeliverAmt" value="${i.LAST_DELIVER_AMT}"></td>
			  		</tr>
				</c:forEach>
			  </c:if>
			  </tbody>
			</table>
		</div>
		<div class="row" style="padding-top:10px; overflow-x:auto;width:90%;text-align: center; margin: 0 auto;">
			<div class="title"> 지원품목2</div> 
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col"  width="30%">지원품목명</th>
			      <th scope="col"  width="20%">출고수량</th>
			      <th scope="col"  width="20%">출고단가</th>
			      <th scope="col"  width="20%">할인률</th>
			      <th scope="col"  width="10%">최종출고금액</th>
			    </tr>
			  </thead>
			  <tbody id="view2">
			  	 <c:if test="${gubun ne 'update'}">
			  	<tr>
			  		<td>
			  			<input type="text" id="prodNoSitemNm1" class="form-control" name="prodNoSitemNm1" value="">
			  			<input type="hidden" id="prodNoSitemCd1" class="form-control" name="prodNoSitemCd1" value="">
			  		</td>
			  		<td><input type="text" id="deliveryCnt1" class="form-control" name="deliveryCnt1" value=""></td>
			  		<td><input type="text" id="deliveryAmt1" class="form-control" name="deliveryAmt1" value=""></td>
			  		<td><input type="text" id="dcRate1" class="form-control" name="dcRate1" value=""></td>
			  		<td><input type="text" id="lastDeliverAmt1" class="form-control" name="lastDeliverAmt1" value=""></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<input type="text" id="prodNoSitemNm1" class="form-control" name="prodNoSitemNm1" value="">
			  			<input type="hidden" id="prodNoSitemCd1" class="form-control" name="prodNoSitemCd1" value="">
			  		</td>
			  		<td><input type="text" id="deliveryCnt1" class="form-control" name="deliveryCnt1" value=""></td>
			  		<td><input type="text" id="deliveryAmt1" class="form-control" name="deliveryAmt1" value=""></td>
			  		<td><input type="text" id="dcRate1" class="form-control" name="dcRate1" value=""></td>
			  		<td><input type="text" id="lastDeliverAmt1" class="form-control" name="lastDeliverAmt1" value=""></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<input type="text" id="prodNoSitemNm1" class="form-control" name="prodNoSitemNm1" value="">
			  			<input type="hidden" id="prodNoSitemCd1" class="form-control" name="prodNoSitemCd1" value="">
			  		</td>
			  		<td><input type="text" id="deliveryCnt1" class="form-control" name="deliveryCnt1" value=""></td>
			  		<td><input type="text" id="deliveryAmt1" class="form-control" name="deliveryAmt1" value=""></td>
			  		<td><input type="text" id="dcRate1" class="form-control" name="dcRate1" value=""></td>
			  		<td><input type="text" id="lastDeliverAmt1" class="form-control" name="lastDeliverAmt1" value=""></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<input type="text" id="prodNoSitemNm1" class="form-control" name="prodNoSitemNm1" value="">
			  			<input type="hidden" id="prodNoSitemCd1" class="form-control" name="prodNoSitemCd1" value="">
			  		</td>
			  		<td><input type="text" id="deliveryCnt1" class="form-control" name="deliveryCnt1" value=""></td>
			  		<td><input type="text" id="deliveryAmt1" class="form-control" name="deliveryAmt1" value=""></td>
			  		<td><input type="text" id="dcRate1" class="form-control" name="dcRate1" value=""></td>
			  		<td><input type="text" id="lastDeliverAmt1" class="form-control" name="lastDeliverAmt1" value=""></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<input type="text" id="prodNoSitemNm1" class="form-control" name="prodNoSitemNm1" value="">
			  			<input type="hidden" id="prodNoSitemCd1" class="form-control" name="prodNoSitemCd1" value="">
			  		</td>
			  		<td><input type="text" id="deliveryCnt1" class="form-control" name="deliveryCnt1" value=""></td>
			  		<td><input type="text" id="deliveryAmt1" class="form-control" name="deliveryAmt1" value=""></td>
			  		<td><input type="text" id="dcRate1" class="form-control" name="dcRate1" value=""></td>
			  		<td><input type="text" id="lastDeliverAmt1" class="form-control" name="lastDeliverAmt1" value=""></td>
			  	</tr>
			  	</c:if>
			  	 <c:if test="${gubun eq 'update' }">
				  	<c:forEach items="${ProPosalDList2}" var="i" varStatus="status">
						<tr>
					  		<td>
					  			<input type="text" id="prodNoSitemNm1" class="form-control" name="prodNoSitemNm1" value="${i.PROD_NO_SITEM_NM}">
					  			<input type="hidden" id="prodNoSitemCd1" class="form-control" name="prodNoSitemCd1" value="">
					  		</td>
					  		<td><input type="text" id="deliveryCnt1" class="form-control" name="deliveryCnt1" value="${i.DELIVERY_CNT}"></td>
					  		<td><input type="text" id="deliveryAmt1" class="form-control" name="deliveryAmt1" value="${i.DELIVERY_AMT}"></td>
					  		<td><input type="text" id="dcRate1" class="form-control" name="dcRate1" value="${i.DC_RATE}"></td>
					  		<td><input type="text" id="lastDeliverAmt1" class="form-control" name="lastDeliverAmt1" value="${i.LAST_DELIVER_AMT}"></td>
					  	</tr>
					</c:forEach>
				  </c:if>
			  </tbody>
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
