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
		  		<td class="border">${vendorView.OUTLET_NM}</td>
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
		  		<td class="border">도매장여부</td>
		  		<td class="border">${vendorView.WHOLESALE_YN}</td>
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
	<div class="title">프로포셜 리스트 (총 ${ProposaltotalCnt}회)</div> 
	<table class="table table-bordered table-dark"" style="width:100%;">
	  <thead >
	    <tr class="">
	      <th scope="col">프로포셜 </th>
	      <th scope="col">담당팀</th>
	      <th scope="col">담당자</th>
	      <th scope="col">제안기간</th>
	      <th scope="col">제안명</th>
	      <th scope="col">거래처</th>
	      <th scope="col">제안목적</th>
	      <th scope="col">액티비티계획</th>
	    </tr>
	  </thead>
	  <tbody>
	  	<c:forEach items="${vendorProposalList}" var="i" varStatus="status">
		  	<tr class="bg-white text-body">
		  		<td >${i.PRPS_ID }</td>
		  		<td >${i.TEAMNM }</td>
		  		<td >${i.EMP_NM }</td>
		  		<td >${i.PRPS_STR_DT }~${i.PRPS_END_DT }</td>
		  		<td >${i.PRPS_NM }</td>
		  		<td >${i.VD_NM }</td>
		  		<td >${i.PRPS_PURPOSE_CD_NM }</td>
		  		<td >${i.ACT_PLAN_CD_NM }</td>
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