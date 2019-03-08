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
		<td>관리</td>
	</tr>
</c:forEach>
