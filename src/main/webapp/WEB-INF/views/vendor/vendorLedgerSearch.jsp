<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<div class="row" style="overflow-x:auto;overflow-y: hidden;padding: 0 15px;margin-top: 15px;">
		<table class="table" style="width:100%;">
		  <thead style="display:none;">
		    <tr>
		      <th scope="col" class="border-0"> </th>
		      <th scope="col" class="border-0"> </th>
		      <th scope="col" class="border-0"> </th>
		      <th scope="col" class="border-0"> </th>
		      <th scope="col" class="border-0"> </th>
		      <th scope="col" class="border-0"> </th>
		    </tr>
		  </thead>
		  <tbody>
		  	<tr>
		  		<td class="border">거래처명</td>
		  		<td class="border">${vendorView.VENDOR_NM}</td>
		  		<td class="border">관리팀</td>
		  		<td class="border">${vendorView.DEPT_NM}</td>
		  		<td class="border">관리담당자</td>
		  		<td class="border">${vendorView.EMP_NM}</td>
		  	</tr>
		  	<tr>
		  		<td class="border">전화번호</td>
		  		<td class="border">${vendorView.VENDOR_TEL_NO}</td>
		  		<td class="border">사업자등록번호</td>
		  		<td class="border">${vendorView.VENDOR_BRNO}</td>
		  		<td class="border">주민등록번호</td>
		  		<td class="border">${vendorView.VENDOR_RRNO}</td>
		  	</tr>
		  	<tr>
		  		<td class="border">홈페이지주소</td>
		  		<td class="border">${vendorView.VENDOR_URL}</td>
		  		<td class="border">Market</td>
		  		<td class="border">${vendorView.MARKET_DIVS_CD_NM}</td>
		  		<td class="border">Segmentation</td>
		  		<td class="border">${vendorView.VENDOR_SGMT_DIVS_CD_NM}</td>
		  	</tr>
		  	<tr>
		  		<td class="border">도매장명</td>
		  		<td class="border" colspan="3">${vendorView.WHOLESALE_VENDOR_NM}</td>
		  		<td class="border"></td>
		  		<td class="border"></td>
		  	</tr>
		  	<tr>
		  		<td class="border">우편번호</td>
		  		<td class="border" colspan="3">${vendorView.VENDOR_ZIP_NO}</td>
		  		<td class="border">거래처상태</td>
		  		<td class="border">${vendorView.VENDOR_STAT_CD_NM}</td>
		  	</tr>
		  	<tr>
		  		<td class="border">주소</td>
		  		<td class="border" colspan="5">${vendorView.VENDOR_ADDR}</td>
		  	</tr>
		  </tbody>
		</table>
</div>
<div class="row" style="overflow-x:auto;overflow-y: hidden;padding: 0 15px;margin-top: 15px;">
	<div class="title">인센티브 ACTUAL 리스트 </div> 
	<table class="table table-bordered" style="width:100%;">
	  <thead >
	    <tr class="">
	       	 <th class="border text-center" scope="col" width="40%">제품명(제안수량)</th>
		     <th class="border text-center" scope="col" width="15%">출고월</th>
		     <th class="border text-center" scope="col" width="15%">BTL(병) 출고계획수량</th>
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
<div class="row" style="overflow-x:auto;overflow-y: hidden;padding: 0 15px;margin-top: 15px;">
	<div class="title">콜 리스트 (총 ${VenderCalltotalCnt }회)</div> 
	<table class="table table-bordered table-dark"" style="width:100%;">
	  <thead >
	    <tr class="">
	      <th scope="col">날짜 </th>
	      <th scope="col">목적</th>
	      <th scope="col">결과</th>
	      <th scope="col">리포트</th>
	    </tr>
	  </thead>
	  <tbody>
		  <c:forEach items="${vendorCallList}" var="i" varStatus="status">
		  	<tr class="bg-white text-body">
		  		<td >${i.SCALL_DT }</td>
		  		<td >${i.SCALL_PURPOSE_CD_NM }</td>
		  		<td >${i.SCALL_RSLT_CD_NM }</td>
		  		<td ></td>   
		  	</tr>
		  </c:forEach>
	  </tbody>
	</table>
</div>