<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.js"></script>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
var ajaxFlag = false;

	$(function() {
	});		

	$(document).ready(function(){
		$("button[name='goToTop']").click(function(){
			$( 'html, body' ).animate( { scrollTop : 0 }, 400 );
			
		});
		
		$('.summernote').summernote({
			height: 400,
			toolbar: []
			
		});
		$('.summernote').summernote('disable');
		
		$("#proPosalList").click(function(){
			location.href="/proPosalList";
		});
		
		$("#proPosalDelete").click(function(){
			
			var prps_id = $("#d_prps_id").val()
			$.ajax({      
			    type:"POST",  
			    url:"/proPosalDelete",
			    
			    data: JSON.stringify({"appr_no":prps_id}),
			    dataType:"json",
			    contentType:"application/json;charset=UTF-8",
			    traditional:true,
			    success:function(args){   
			    	
			    	console.log("args="+args);
			    	if(args.returnCode == "0000"){
			    		alert(args.message.replace(/<br>/gi,"\n"));
			    		location.replace("/proPosalList");
			    	}
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    }  
			});
		});
		
	});
	
	function viewStep(prps_id, step, gubun){
		document.viewForm.prps_id.value=prps_id;
		document.viewForm.gubun.value=gubun;
		if(step=='01'){
			document.viewForm.action="/proPosalForm";
		}else if(step=='02'){
			document.viewForm.action="/proPosalForm02";	
		}else if(step=='03'){
			document.viewForm.action="/proPosalForm03";	
		}else if(step=='04'){
			document.viewForm.action="/proPosalForm04";	
		}
		document.viewForm.submit();
	}
	
</script>

<div class="">
	<div class="title"> ◈  PROPOSAL Detail</div> 
	<div class="container-fluid">
		<div class="row">			
			<label class="col col-12  col-sm-3" style="padding: 1px 0px;">
					<a class="btn btn-info text-white" style="width: 99%;" href="#defultView">PROPOSAL 기본정보</a>
			</label>
			<label class="col col-12 col-sm-3" style="padding: 1px 0px;">
					<a class="btn btn-info text-white" style="width: 99%;" href="#productView">제품/지원품목</a>
			</label>
			<label class="col col-12 col-sm-3" style="padding: 1px 0px;">
					<a class="btn btn-info text-white" style="width: 99%;" href="#monthView">월별 출고계획</a>
			</label>
			<label class="col col-12 col-sm-3" style="padding: 1px 0px;">
					<a class="btn btn-info text-white" style="width: 99%;" href="#monthActualtView">월별 ACTUAL</a>
			</label>
		</div>
		<div class="row" style="overflow-x:auto;">	
			<div id="defultView" style="padding-top:10px; overflow-x:auto; width:90%; margin: 0 auto;">
				<div class="title"><b>1.PROPOSAL 기본정보</b></div> 
				<div class="container-fluid border">
					<div class="row" style="padding-top:10px">			
						<div class="col col-12 col-sm-10">
							<div class="form-group row">
								<label for="prps_nm"
									class="col-md-2 col-form-label text-md-left">제안명</label>
								<div class="col-md-4">
									<input type="text" id="prps_nm" class="form-control"
										name="prps_nm" value="${data.PRPS_NM}" readonly>
								</div>
								<label for="prps_nm"
									class="col-md-2 col-form-label text-md-left">결재상태</label>
								<div class="col-md-4">
									<input type="text" id="prps_nm" class="form-control"
										name="prps_nm" value="${data.PRPS_STUS_CD_NM}" readonly>
								</div>
								
							</div>
							<div class="form-group row">
								<label for="prps_purpose_cd"
									class="col-md-2 col-form-label text-md-left">제안목적</label>
								<div class="col-md-4">
									<input type="text" id="prps_purpose_nm" class="form-control"
										name="prps_purpose_nm" value="${data.PRPS_PURPOSE_CD_NM}"
										readonly>
								</div>
								<label for="act_plan_cd"
									class="col-md-2 col-form-label text-md-left">액티비티계획</label>
								<div class="col-md-4">
									<input type="text" id="act_plan_cd_nm" class="form-control"
										name="act_plan_cd_nm" value="${data.ACT_PLAN_CD_NM}" readonly>
								</div>
							</div>
							<div class="form-group row">
								<label for="prps_purpose_cd"
									class="col-md-2 col-form-label text-md-left">제안기간</label>
								<div class="col-md-4">
									<input type="text" class="form-control" name="prps_str_dt"
										value="${data.PRPS_STR_DT1}" readonly />~ <input type="text"
										class="form-control" name="prps_end_dt"
										value="${data.PRPS_END_DT1}" readonly />
								</div>
								<label for="act_plan_cd"
									class="col-md-2 col-form-label text-md-left">거래처</label>
								<div class="col-md-4">
									<input type="text" id="vendor_nm" class="form-control"
										name="vendor_nm" readonly value="${data.VD_NM}">
								</div>
							</div>
							<div class="form-group row">
								<label for="prps_purpose_cd"
									class="col-md-2 col-form-label text-md-left">광고비 예산</label>
								<div class="col-md-4">
									<input type="text" id="budg_amt" class="form-control"
										name="budg_amt" readonly value="${data.BUDG_AMT}">
								</div>
								<label for="act_plan_cd"
									class="col-md-2 col-form-label text-md-left">제안 광고비</label>
								<div class="col-md-4">
									<input type="text" id="base_prps_amt" class="form-control"
										name="base_prps_amt" readonly value="${data.BASE_PRPS_AMT}">
								</div>
							</div>
							<div class="form-group row">
								<label for="prps_purpose_cd"
									class="col-md-2 col-form-label text-md-left">최종 광고비</label>
								<div class="col-md-4">
									<input type="text" id="last_prps_amt" class="form-control"
										name="last_prps_amt" readonly value="${data.LAST_PRPS_AMT}">
								</div>
								<label for="act_plan_cd"
									class="col-md-2 col-form-label text-md-left">케이스 별 광고비</label>
								<div class="col-md-4">
									<input type="text" id="caserate_amt" class="form-control"
										name="caserate_amt" readonly value="${data.CASERATE_AMT}">
								</div>
							</div>
							<div class="form-group row">
							<label for="act_plan_cd"
									class="col-md-2 col-form-label text-md-left">제안내역</label>
								<div class="col-md-12">
								<textarea name="prps_cntn" class="summernote">${data.PRPS_CNTN}</textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="float-right">
					<c:if test="${'0001' eq data.PRPS_STUS_CD}">
					<input type="button" class="btn btn-secondary btn-sm" value="수정" onClick="viewStep('${data.PRPS_ID}','01','update')"/>
					</c:if>
					<button type="button" name="goToTop" id="goToTop" class="btn btn-secondary btn-sm">TOP</button>
				</div>
			</div>
			<div id="productView" style="padding:10px 0px; overflow-x:auto; width:90%; margin: 0 auto;">
				<div class="title"><b>STEP02. PROPOSAL 제품/지원품목</b></div> 
				<div class="container-fluid border">
					<div class="row" style="padding-top:10px; overflow-x:auto; width:90%;text-align: center; margin: 0 auto;" >
						인센티브
						<table class="table border">
						  <thead>
						    <tr>
						      <th scope="col" style="width:auto">제품명</th>
						      <th scope="col" width="10%">기본 광고단가</th>
						      <th scope="col" width="7%">출고수량</th>
						      <th scope="col" width="5%">CASE(9L)</th>
						      <th scope="col" width="20%">병당 광고비</th>
						      <th scope="col" width="10%">인센티브</th>
						      <th scope="col" width="10%">케이스 별 <br>광고비</th>
						      <th scope="col" width="10%">추가 상승분</th>
						    </tr>
						  </thead>
						  <tbody>
								<c:forEach items="${ProPosalIList}" var="i" varStatus="status">
									<tr>
										<td>${i.PROD_NO_SITEM_NM2}</td>
										<td><fmt:formatNumber value="${i.STD_CASE_RATE}" pattern="#,###" />원</td>
										<td>${i.DELIVERY_CNT}</td>
										<td><fmt:formatNumber value="${i.CASE9L}"/></td>
										<td><fmt:formatNumber value="${i.UNIT_INCENTIVE_AMT}" pattern="#,###" />원</td>
										<td><fmt:formatNumber value="${i.INCENTIVE_AMT}" pattern="#,###" />원</td>
										<td><fmt:formatNumber value="${i.CASE_RATE}" pattern="#,###" />원</td>
										<td><fmt:formatNumber value="${i.VS_STD}" pattern="#,###" />원</td>
									</tr>
								</c:forEach>
						  </tbody>
						</table>
						
						<table class="table border">
							<tr>
								<th scope="col" style="width: auto">SUBTOTAL</th>
								<th scope="col" width="10%"><fmt:formatNumber value="${ProPosalISum.STD_CASE_RATE}" pattern="#,###" />원</th>
								<th scope="col" width="7%">${ProPosalISum.DELIVERY_CNT}</th>
								<th scope="col" width="6%"><fmt:formatNumber value="${ProPosalISum.CASE9L}" /></th>
								<th scope="col" width="20%"><fmt:formatNumber value="${ProPosalISum.UNIT_INCENTIVE_AMT}" pattern="#,###" />원</th>
								<th scope="col" width="10%"><fmt:formatNumber value="${ProPosalISum.INCENTIVE_AMT}" pattern="#,###" />원</th>
								<th scope="col" width="10%"><fmt:formatNumber value="${ProPosalISum.CASE_RATE}" pattern="#,###" />원</th>
								<th scope="col" width="10%"><fmt:formatNumber value="${ProPosalISum.VS_STD}" pattern="#,###" />원</th>
							</tr>
						</table><br/>
						A&P
						<table class="table border">
						  <thead>
						    <tr>
						      <th scope="col"  style="width:auto;">품목명</th>
						      <th scope="col"  width="10%">개당 금액</th>
						      <th scope="col"  width="7%">수량</th>
						      <th scope="col"  width="10%">총금액</th>
						      <th scope="col"  width="7%">CASE(9L)</th>
						      <th scope="col"  width="10%">총 광고비</th>
						      <th scope="col"  width="10%">케이스 별<br> 광고비</th>
						      <th scope="col"  width="10%">광고비 차액</th>
						      <th scope="col"  width="13%">REMARK</th>
						    </tr>
						  </thead>
						  <tbody>
						  		<c:set var="aTotIncentiveAmt"  value="0" ></c:set>
						  		<c:forEach items="${ProPosalIList}" var="i" varStatus="status">
						  			<c:set var="aNpSize"  value="0" ></c:set>
						  			<c:set var="aRowspan"  value="0" ></c:set>
						  			<tr>
								  		<td colspan="9" class="text-left">${i.PROD_NO_SITEM_NM2}
								  		</td>
								  	</tr>
									<c:forEach items="${ProPosalAList}" var="j" varStatus="status">
										<c:if test="${i.PRPSD_ID eq j.UP_PRPSD_ID}">
										<tr>
											<td>${j.PROD_NO_SITEM_NM}</td>
											<td><fmt:formatNumber value="${j.UNIT_INCENTIVE_AMT}" pattern="#,###" />원</td>
											<td>${j.DELIVERY_CNT}</td>
											<c:if test="${aNpSize eq 0}">
											<c:forEach items="${ProPosalAList}" var="x" varStatus="xStatus">
												<c:if test="${i.PRPSD_ID eq x.UP_PRPSD_ID}">
													<c:set var="aRowspan"  value="${aRowspan+1}" ></c:set>
												</c:if>
											</c:forEach>
											<c:set var="aTotIncentiveAmt"  value="${aTotIncentiveAmt+j.INCENTIVE_AMT}" ></c:set>
											<td rowspan="${aRowspan}"  class="align-middle"><fmt:formatNumber value="${j.INCENTIVE_AMT}"  pattern="#,###" />원</td>
											<td rowspan="${aRowspan}"  class="align-middle"><fmt:formatNumber value="${j.CASE9L}"  /></td>
											<td rowspan="${aRowspan}"  class="align-middle"><fmt:formatNumber value="${i.INCENTIVE_AMT}"  pattern="#,###" />원</td>
											<td rowspan="${aRowspan}"  class="align-middle"><fmt:formatNumber value="${j.CASE_RATE}"  pattern="#,###" />원</td>
											<td rowspan="${aRowspan}"  class="align-middle"><fmt:formatNumber value="${j.VS_STD}"  pattern="#,###" />원</td>
											</c:if>
											<td>${j.RMK_CNTN}</td>
										</tr>
										<c:set var="aNpSize"  value="${aNpSize+1}" ></c:set>
										</c:if>
									</c:forEach>
								</c:forEach>
						  </tbody>
						</table>
						<table class="table border">
							<tr>
								<th scope="col" style="width: auto">SUBTOTAL</th>
								<th scope="col" width="10%"><fmt:formatNumber value="${ProPosalASum.UNIT_INCENTIVE_AMT}" pattern="#,###" />원</th>
								<th scope="col" width="7%">${ProPosalASum.DELIVERY_CNT}</th>
								<th scope="col" width="10%"><fmt:formatNumber value="${aTotIncentiveAmt}" />원</th>
								<th scope="col" width="7%">&nbsp;</th>
								<th scope="col"  width="10%">&nbsp;</th>
						        <th scope="col"  width="10%">&nbsp;</th>
						        <th scope="col"  width="10%">&nbsp;</th>
						        <th scope="col"  width="13%">&nbsp;</th>
							</tr>
						</table>
						<table class="table border">
						  <thead>
						    <tr>
						      <th scope="col"  width="30%">TTL AMOUNT</th>
						      <th scope="col"  width="10%">VOLUME</th>
						      <th scope="col"  width="10%">총 광고비</th>
						      <th scope="col"  width="20%">기타 광고비</th>
						      <th scope="col"  width="30%">AVERAGE</th>
						    </tr>
						  </thead>
						  <tbody>
								<tr>
									<td>TOTAL</td>
									<td>${ProPosalTTLSum.CASE9L}</td>
									<td><fmt:formatNumber value="${ProPosalTTLSum.INCENTIVE_AMT}"  pattern="#,###" />원</td>
									<td><fmt:formatNumber value="${aTotIncentiveAmt}"  pattern="#,###" />원</td>
									<td><fmt:formatNumber value="${(ProPosalTTLSum.INCENTIVE_AMT + aTotIncentiveAmt) / ProPosalTTLSum.CASE9L}"  pattern="#,###" />원</td>
								</tr>
						  </tbody>
						</table>
					</div>
				</div>
				<div class="float-right">
				<c:if test="${'0001' eq data.PRPS_STUS_CD}">
					<input type="button" class="btn btn-secondary btn-sm" value="수정" onClick="viewStep('${data.PRPS_ID}','02','update')"/>
				</c:if>
				<button type="button" name="goToTop" id="goToTop" class="btn btn-secondary btn-sm float-right">TOP</button>
				</div>		
			</div>
			<div id="monthView" style="padding:10px 0px; overflow-x:auto; width:90%; margin: 0 auto;">
				<div class="title"><b>STEP03. PROPOSAL 예상 출고 계획 등록</b></div> 
				<div class="container-fluid border">
					<div class="row" style="padding: 5px 0px;">
						<table class="table" style="width:90%;margin:0 auto;">
						  <thead>
						    <tr>
						      <th class="border text-center" scope="col" width="60%">제품명(제안수량)</th>
						      <th class="border text-center" scope="col" width="20%">출고월</th>
						      <th class="border text-center" scope="col" width="20%">CASE 출고계획수량</th>
						    </tr>
						  </thead>
						  <tbody>
					  		<c:forEach items="${listStep03}" var="i" varStatus="status">
							  	<tr>
							  		<td class="border">
							  			<c:if test="${i.PROD_SITEM_DIVS_CD eq '01'}">
										    <span>${i.BRAND_NM}&nbsp;${i.SUB_BRAND_NM}&nbsp;${i.PROD_ML_NM}&nbsp;(수량 ${i.CASE9L})</span>
										</c:if>
										<c:if test="${i.PROD_SITEM_DIVS_CD eq '02'}">
										    <span>${i.PROD_NO_SITEM_NM} (수량 ${i.DELIVERY_CNT})</span>
										</c:if>
							  			<input type="hidden" id="prpsdId"name="prpsdId" value="${i.PRPSD_ID}">
							  			<input type="hidden" id="prpsId"name="prpsId" value="${i.PRPS_ID}">
							  			<input type="hidden" id="prodSitemDivsCd"name="prodSitemDivsCd" value="${i.PROD_SITEM_DIVS_CD}">
							  			<input type="hidden" id="prodNoSitemNm"name="prodNoSitemNm" value="${i.PROD_NO_SITEM_NM}">
							  			<input type="hidden" id="deliveryCnt"name="deliveryCnt" value="${i.DELIVERY_CNT}">
							  		</td>
							  		<td class="border">
							  			<c:forEach items="${i.dateList}" var="d">
							  				<input type="text" id="deliDate" class="form-control" name="deliDate" style="margin-bottom:3px;" value="${d.deliDate}" readonly>
							  			</c:forEach>
							  		</td>
							  		<td class="border">
							  			<c:forEach items="${i.dateList}" var="d">
							  				<input type="number" min="0" id="planCnt" class="form-control" name="planCnt" data-prpsdid="${i.PRPSD_ID}" data-deliverycnt="${i.DELIVERY_CNT}" style="margin-bottom:3px;" readonly value="${d.PLAN_DELIVERY_CNT}">
							  			</c:forEach>
							  		</td>
							  	</tr>
							</c:forEach>
						  </tbody>
						 </table>
					</div>			
				</div>
				<div class="float-right">
					<c:if test="${'0001' eq data.PRPS_STUS_CD}">
						<input type="button" class="btn btn-secondary btn-sm" value="수정" onClick="viewStep('${data.PRPS_ID}','03','update')"/>
					</c:if>
					<button type="button" name="goToTop" id="goToTop"  class="btn btn-secondary btn-sm float-right">TOP</button>
				</div>	
			</div>
			<div id="monthActualtView" style="padding:10px 0px; overflow-x:auto; width:90%; margin: 0 auto;">
				<div class="title">PROPOSAL 인센티브 ACTUAL 등록</div> 
				<div class="container-fluid border">
					<div class="row" style="padding: 5px 0px;">
						<table class="table" style="width:90%;margin:0 auto;">
						  <thead>
						    <tr>
						      <th class="border text-center" scope="col" width="40%">제품명(제안수량)</th>
						      <th class="border text-center" scope="col" width="15%">출고월</th>
						      <th class="border text-center" scope="col" width="15%">CASE 출고계획수량</th>
						      <th class="border text-center" scope="col" width="15%">실출고수량</th>
						      <th class="border text-center" scope="col" width="15%">비고</th>
						    </tr>
						  </thead>
						  <tbody>
					  		<c:forEach items="${listStep03}" var="i" varStatus="status">
							  	<tr>
							  		<td class="border">
							  			<c:if test="${i.PROD_SITEM_DIVS_CD eq '01'}">
										    <span>${i.BRAND_NM}&nbsp;${i.SUB_BRAND_NM}&nbsp;${i.PROD_ML_NM}&nbsp;(수량 ${i.DELIVERY_CNT})</span>
										</c:if>
										<c:if test="${i.PROD_SITEM_DIVS_CD eq '02'}">
										    <span>${i.PROD_NO_SITEM_NM} (수량 ${i.DELIVERY_CNT})</span>
										</c:if>
							  			<input type="hidden" id="prpsdId"name="prpsdId" value="${i.PRPSD_ID}">
							  			<input type="hidden" id="prpsId"name="prpsId" value="${i.PRPS_ID}">
							  			<input type="hidden" id="prodSitemDivsCd"name="prodSitemDivsCd" value="${i.PROD_SITEM_DIVS_CD}">
							  			<input type="hidden" id="prodNoSitemNm"name="prodNoSitemNm" value="${i.PROD_NO_SITEM_NM}">
							  			<input type="hidden" id="deliveryCnt"name="deliveryCnt" value="${i.DELIVERY_CNT}">
							  		</td>
							  		<td class="border">
							  			<c:forEach items="${i.dateList}" var="d">
							  				<input type="text" id="deliDate" class="form-control" name="deliDate" style="margin-bottom:3px;" value="${d.deliDate}" readonly>
							  			</c:forEach>
							  		</td>
							  		<td class="border">
							  		<% int i = 0; %>
							  			<c:forEach items="${i.dateList}" var="d">
							  				<input type="number" min="0" id="planCnt" class="form-control" name="planCnt" data-prpsdid="${i.PRPSD_ID}" data-deliverycnt="${i.DELIVERY_CNT}" style="margin-bottom:3px;" readonly value="${d.PLAN_DELIVERY_CNT}">
							  				
							  			</c:forEach>
							  		</td>
							  		<td class="border">
							  			<c:forEach items="${i.dateList}" var="d">
							  				<input type="number" min="0" id="planCnt" class="form-control" name="planCnt" data-prpsdid="${i.PRPSD_ID}" data-deliverycnt="${i.DELIVERY_CNT}" style="margin-bottom:3px;" readonly value="${d.REAL_DELIVERY_CNT}">
							  			</c:forEach>
							  		</td>
							  		<td class="border">
							  			<c:forEach items="${i.dateList}" var="d">
							  				<input type="text" min="0" id="planCnt" class="form-control" name="planCnt"  style="margin-bottom:3px;" readonly value="${d.REAL_DELIVERY_CNTN}">
							  			</c:forEach>
							  		</td>
							  	</tr>
							</c:forEach>
						  </tbody>
						 </table>
					</div>	
				</div>
				<div class="float-right">
					<c:if test="${'0001' eq data.PRPS_STUS_CD}">
					<c:if test="${'0' ne d_cnt}">
						<input type="button" class="btn btn-secondary btn-sm" value="수정" onClick="viewStep('${data.PRPS_ID}','04','')"/>
					</c:if>
					</c:if>
					<button type="button" name="goToTop" id="goToTop"  class="btn btn-secondary btn-sm float-right">TOP</button>
				</div>	
				
			</div>
		</div>
		<div class="row" style="padding: 5px 0px;">
			<div class="col-12 col-sm-6 text-left">
				<input class="btn btn-light" type="button" id="proPosalList" value="목록으로">
				<c:if test="${'1' ne delete_check}">
				<input type="hidden" name="d_prps_id" id="d_prps_id" value="${prps_id}"/>
				<input class="btn btn-light" type="button" id="proPosalDelete" value="삭제">
				</c:if>
			</div>
		</div>
	</div>
</div>

<form name="viewForm" method="post">
	<input type="hidden" name="prps_id"/>
	<input type="hidden" name="gubun"/> 
</form>