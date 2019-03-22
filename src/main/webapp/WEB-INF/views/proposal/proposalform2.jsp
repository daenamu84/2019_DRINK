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
		
		$("#outlet_nm").click(function(){
			$("#popLayer").modal("show");
		});
		
		
		$("#saveWork").click(function(){			
			if(ajaxFlag)return;
			
			var prps_nm = $("#prps_nm").val();
			if(prps_nm==""){
				alert("제안명을 입력하세요");
				ajaxFlag = false;
				return;
			}
			
			if ($("#prps_purpose_cd option:selected").val() == "") {
				alert("제안목적을  선택 하세요");
				ajaxFlag = false;
				return;
			}
			
			var prps_purpose_cd = $("#prps_purpose_cd option:selected").val() ;
			
			if ($("#act_plan_cd option:selected").val() == "") {
				alert("액티비티계획을  선택 하세요");
				ajaxFlag = false;
				return;
			}
			
			var act_plan_cd = $("#act_plan_cd option:selected").val() ;
			
			var prps_str_dt = $('input[name=prps_str_dt]').val();
			if (prps_str_dt == "") {
				alert("프로모션시작일자을  입력하세요");
				ajaxFlag = false;
				return;
			}
			
			var prps_end_dt = $('input[name=prps_end_dt]').val();
			if (prps_end_dt == "") {
				alert("프로모션종료일자을  입력하세요");
				ajaxFlag = false;
				return;
			}
			
			var outlet_no = $('input[name=outlet_no]').val();
			if (outlet_no == "") {
				alert("거래처를   입력하세요");
				ajaxFlag = false;
				return;
			}
			
			var outlet_no = $("#outlet_no").val();
			var wholesale_vendor_no = $("#wholesale_vendor_no").val();
			var market_divs_cd = $("#market_divs_cd").val();
			var vendor_sgmt_divs_cd = $("#vendor_sgmt_divs_cd").val();
			
			var budg_amt = $("#budg_amt").val();
			var base_prps_amt = $("#base_prps_amt").val();
			var last_prps_amt = $("#last_prps_amt").val();
			if (last_prps_amt == "") {
				alert("최종제안금액  입력하세요");
				ajaxFlag = false;
				return;
			}
			
			var caserate_amt = $("#caserate_amt").val();
			
			$('textarea[name="prps_cntn"]').html($('.summernote').summernote("code"));
			
			var prps_cntn = $('textarea[name="prps_cntn"]').html();
			
			var url = "/proposalWork";
			
			 $.ajax({      
				    type:"POST",  
				    url:url,      
				    data: JSON.stringify({"prps_nm":prps_nm,"prps_purpose_cd":prps_purpose_cd,"act_plan_cd":act_plan_cd,"prps_str_dt":prps_str_dt,"prps_end_dt":prps_end_dt,"outlet_no":outlet_no,"wholesale_vendor_no":wholesale_vendor_no,"market_divs_cd":market_divs_cd,"vendor_sgmt_divs_cd":vendor_sgmt_divs_cd,"budg_amt":budg_amt,"base_prps_amt":base_prps_amt,"last_prps_amt":last_prps_amt,"caserate_amt":caserate_amt,"prps_cntn":prps_cntn }),
				    dataType:"json",
				    contentType:"application/json;charset=UTF-8",
				    traditional:true,
				    success:function(args){   
				        if(args.returnCode == "0000"){
				        	alert(args.message.replace(/<br>/gi,"\n"));
				        	if(args.retgubun == "insert"){
				        		//location.replace("/memberList");
				        	}else{
				        		//alert(0);
				        		//ViewMember(emp_no,args.retgubun);	
				        	}
				        }else{
				        	alert(args.message.replace(/<br>/gi,"\n"));
				        	if(args.retgubun == "insert"){
				        		location.replace("/memberList");
				        	}else{
				        		//alert(1);
				        		//ViewMember(emp_no,args.retgubun);	
				        	}
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
		//$("#popLayer").modal("show");
		console.log("1");
		popListObj = this;
	});

	function setValueDate(arg1, arg2){
		var obj = popListObj
		$(obj).parent().parent().children().find("#prodNoSitemNm").val(arg1);
		$(obj).parent().parent().children().find("#prodNoSitemCd").val(arg1);
	}
</script>
	
	
<div class="">
	<div class="container-fluid">
		<div class="row">			
			<div class="title col col-12  col-sm-5" style="padding: 1px 0px;">◈  STEP2. PROPOSAL 제품/지원목록 등록</div> 
			<label class="col col-12 col-sm-1" style="padding: 1px 0px;">제안제품수</label>
			<div class="col col-12 col-sm-2" style="padding: 1px 0px;">
					<select name="productCnt" class="form-control" id="productCnt">
								<option value="1" >1</option>
								<option value="2" >2</option>
								<option value="3" >3</option>
								<option value="4" >4</option>
								<option value="5" selected>5</option>
								<option value="6" >6</option>
								<option value="7" >7</option>
								<option value="8" >8</option>
								<option value="9" >9</option>
								<option value="10" >10</option>
					</select>
			</div>
			<label class="col col-12 col-sm-1" style="padding: 1px 0px;">지원품목수</label>
			<div class="col col-12 col-sm-2" style="padding: 1px 0px;">
					<select name="supplyCnt" class="form-control" id="supplyCnt">
								<option value="1" >1</option>
								<option value="2" >2</option>
								<option value="3" >3</option>
								<option value="4" >4</option>
								<option value="5" selected>5</option>
								<option value="6" >6</option>
								<option value="7" >7</option>
								<option value="8" >8</option>
								<option value="9" >9</option>
								<option value="10" >10</option>
					</select>
			</div>
			<div class="col col-12 col-sm-1" style="padding: 1px 0px;">
					<input class="btn btn-primary" type="button" id="cntUpdate" value="변경">
			</div>
		</div>
		<div class="row" style="padding-top:10px; overflow-x:auto; width:90%;text-align: center; margin: 0 auto;" >
			<div class="title"> 제안제품</div> 
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col" width="30%">제품명</th>
			      <th scope="col" width="20%">출고수량</th>
			      <th scope="col" width="20%">출고단가</th>
			      <th scope="col" width="20%">할인률</th>
			      <th scope="col" width="10%">최종출고금액</th>
			    </tr>
			  </thead>
			  <tbody id="view1">
			  	<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="">
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer"/>
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="">
			  		</td>
			  		<td><input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" value=""></td>
			  		<td><input type="text" id="deliveryAmt" class="form-control" name="deliveryAmt" value=""></td>
			  		<td><input type="text" id="dcRate" class="form-control" name="dcRate" value=""></td>
			  		<td><input type="text" id="lastDeliverAmt" class="form-control" name="lastDeliverAmt" value=""></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="">
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer"/>
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="">
			  		</td>
			  		<td><input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" value=""></td>
			  		<td><input type="text" id="deliveryAmt" class="form-control" name="deliveryAmt" value=""></td>
			  		<td><input type="text" id="dcRate" class="form-control" name="dcRate" value=""></td>
			  		<td><input type="text" id="lastDeliverAmt" class="form-control" name="lastDeliverAmt" value=""></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="">
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer"/>
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="">
			  		</td>
			  		<td><input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" value=""></td>
			  		<td><input type="text" id="deliveryAmt" class="form-control" name="deliveryAmt" value=""></td>
			  		<td><input type="text" id="dcRate" class="form-control" name="dcRate" value=""></td>
			  		<td><input type="text" id="lastDeliverAmt" class="form-control" name="lastDeliverAmt" value=""></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="">
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer"/>
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="">
			  		</td>
			  		<td><input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" value=""></td>
			  		<td><input type="text" id="deliveryAmt" class="form-control" name="deliveryAmt" value=""></td>
			  		<td><input type="text" id="dcRate" class="form-control" name="dcRate" value=""></td>
			  		<td><input type="text" id="lastDeliverAmt" class="form-control" name="lastDeliverAmt" value=""></td>
			  	</tr>
			  	<tr>
			  		<td>
			  			<span class="col-12 col-md-9 float-left" style="padding:0px;">
			  			<input type="text" id="prodNoSitemNm" class="form-control float-right" name="prodNoSitemNm" value="">
			  			</span>
			  			<span class="col-12 col-md-3 float-left" style="padding:0px;">
			  			<input class="btn btn-dark" type="button" value="검색" id="productInsertLayer"/>
			  			</span>
			  			<input type="hidden" id="prodNoSitemCd" class="form-control" name="prodNoSitemCd" value="">
			  		</td>
			  		<td><input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" value=""></td>
			  		<td><input type="text" id="deliveryAmt" class="form-control" name="deliveryAmt" value=""></td>
			  		<td><input type="text" id="dcRate" class="form-control" name="dcRate" value=""></td>
			  		<td><input type="text" id="lastDeliverAmt" class="form-control" name="lastDeliverAmt" value=""></td>
			  	</tr>
			  </tbody>
			</table>
		</div>
		<div class="row" style="padding-top:10px; overflow-x:auto;width:90%;text-align: center; margin: 0 auto;">
			<div class="title"> 지원품목2</div> 
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">지원품목명</th>
			      <th scope="col">출고수량</th>
			      <th scope="col">출고단가</th>
			      <th scope="col">할인률</th>
			      <th scope="col">최종출고금액</th>
			    </tr>
			  </thead>
			  <tbody id="view2">
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
			  </tbody>
			</table>
		</div>
		<div class="row" style="padding: 5px 0px;">
			<div class="col-12 col-sm-6 text-left">
				<input class="btn btn-light" type="button" id="" value="목록">
				<input class="btn btn-light" type="button" id="" value="STEP01 수정">
			</div>
			<div class="col-12 col-sm-6 text-right">
				<input class="btn btn-primary" type="button" id="proposalSearch" value="STEP03 등록">
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
							<div class="col-sm-3">브랜드</div>
							<div class="col-sm-3">
								<select class="custom-select" id="iBrandId">
									<c:forEach var="i" items="${mBrandCd}" varStatus="status">
										<option value="${i.BRAND_ID}">${i.BRAND_NM}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-3">서브 브랜드</div>
							<div class="col-sm-3">
								<select class="custom-select" id="iSubBrandId">
								</select>
							</div>
						</div>

					</div>
				</div>
				<div class="modal-footer">
					<input class="btn btn-secondary float-right" type="button"
						data-dismiss="modal" value="Close">
				</div>
			</div>
		</div>
	</div>
	<!-- modal  end  -->	
</div>
