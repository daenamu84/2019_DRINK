<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<c:forEach items="${prodVendorList}" var="i" varStatus="status">
	<tr>
		<td>${i.VENDOR_NM}</td>
		<td>${i.BRAND_NM}<input type="hidden" name="_oVendorNo" value="${i.VENDOR_NO}"/> <input type="hidden" name="_oProdNo" value="${i.PROD_NO}"/><input type="hidden" name="_oBrandId" value="${i.BRAND_ID}"/><input type="hidden" name="_oSubBrandId" value="${i.SUB_BRAND_ID}"/></td> 
		<td>${i.SUB_BRAND_NM}</td>
		<td>${i.PROD_ML_NM}</td>
		<td>${i.SALE_PRICE}</td>
		<td>
			<c:choose>
			<c:when test="${i.USE_YN eq 'Y'}">진행중</c:when>
			<c:when test="${i.USE_YN eq 'N'}">일시중지</c:when>
			</c:choose>
		</td>
		<td>${i.SALE_STA_DT}</td>
		<td>${i.SALE_END_DT}</td>
		<td>${i.ORCO_BRAND_NM}</td>
		<td><a href="javascript:prodUpdateView('${i.VENDOR_NO}','${i.PROD_NO}');"class="text-decoration-none">수정</a></td>
	</tr>
</c:forEach>
<tr>
	<td colspan="10" style="text-align: center">
		<div>
			<paging:paging var="skw3" currentPageNo="${paging.page}"
				recordsPerPage="${paging.pageLine}"
				numberOfRecords="${paging.totalCnt}" jsFunc="goPage" />
			${skw3.printBtPaging()}
		</div>
	</td>
</tr>
<input type="hidden" id="_pgVendorId" value="${_pgVendorId}">
<input type="hidden" id="_pgStaDt" value="${_pgStaDt}">
<input type="hidden" id="_pgEndDt" value="${_pgEndDt}">
<input type="hidden" id="_pgDeptNo" value="${_pgDeptNo}">
<input type="hidden" id="_pgEmpNo" value="${_pgEmpNo}">
