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
		
		$("#setp03Insert").click(function(){
			
			
			var prpsdId = $("input[name='prpsdId']");
			
			for(var i=0; i<prpsdId.length; i++){
				var idx = prpsdId[i];
				var planCntObj = $("input[name='planCnt'][data-prpsdid='"+idx.value+"']");
				for(var j = 0; j<planCntObj.length; j++){
					var planIdx = planCntObj[j];
					console.log("palnIdx :: " + planIdx);
					console.log("palnCnt :: " + planIdx.value);
					console.log("palnCnt deliveryCnt :: " + $(planIdx).data("deliverycnt"));
				}
				
			}
			
			
		});
	})
	
	
	
	var ajaxFlag = false;
	
	$(document).ready(function(){
	});
	
</script>
	
	
<div class="">
	<div class="container-fluid">
		<div class="row">			
			<div class="title col col-12  col-sm-5" style="padding: 1px 0px;">◈  STEP2. PROPOSAL 제품/지원목록 출고계획 등록</div> 
		</div>
		
		<div class="row" style="padding: 5px 0px;">
			<table class="table" style="width:90%;margin:0 auto;">
			  <thead>
			    <tr>
			      <th class="border text-center" scope="col" width="60%">제품명(제안수량)</th>
			      <th class="border text-center" scope="col" width="20%">출고월</th>
			      <th class="border text-center" scope="col" width="20%">출고계획수량</th>
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
				  				<input type="text" id="deliDate" class="form-control" name="deliDate" style="margin-bottom:3px;" value="${d}" readonly>
				  			</c:forEach>
				  		</td>
				  		<td class="border">
				  			<c:forEach items="${i.dateList}" var="d">
				  				<input type="number" min="0" id="planCnt" class="form-control" name="planCnt" data-prpsdid="${i.PRPSD_ID}" data-deliverycnt="${i.DELIVERY_CNT}" style="margin-bottom:3px;" value="">
				  			</c:forEach>
				  		</td>
				  	</tr>
				</c:forEach>
			  </tbody>
			 </table>
		</div>
		<div class="row" style="padding: 5px 0px;">
			<div class="col-12 col-sm-9 text-left">
				<input class="btn btn-light" type="button" id="" value="목록으로">
				<input class="btn btn-light" type="button" id="" value="SETP01 수정">
				<input class="btn btn-light" type="button" id="" value="SETP02 수정">
			</div>
			<div class="col-12 col-sm-3 text-RIGHT">
				<input class="btn btn-light" type="button" id="setp03Insert" value="SETP03 등록">
			</div>
		</div>
	</div>
</div>
