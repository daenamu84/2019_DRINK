<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>


<c:forEach items="${productList}" var="i" varStatus="status">
	<tr>
		<td><a href="javascript:productDetail('${i.PROD_NO}');"class="text-decoration-none">${i.PROD_NO}</a></td>
		<td>${i.BRAND_NM}</td>
		<td>${i.SUB_BRAND_NM}</td>
		<td><a href="javascript:productDetail('${i.PROD_NO}');"class="text-decoration-none">${i.PROD_ML_NM}</a></td>
		<td>${i.LIQ_KD_NM}</td>
		<td>${i.ORCO_BRAND_NM}</td>
		<td>${i.USE_YN}</td>
	</tr>
</c:forEach>
<tr>
	<td colspan="7" style="text-align: center">
		<div>
			<paging:paging var="skw3" currentPageNo="${paging.page}"
				recordsPerPage="${paging.pageLine}"
				numberOfRecords="${paging.totalCnt}" jsFunc="goPage" />
			${skw3.printBtPaging()}
		</div>
	</td>
</tr>
<input type="hidden" id="_pBrandId" value="${_pBrandId}">