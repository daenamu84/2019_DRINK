<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<c:forEach items="${vendorList}" var="i" varStatus="status">
	<tr>
		<td><a
			href="javascript:setVendorId('${i.VENDOR_NO}','${i.VENDOR_NM}','${i.MARKET_DIVS_CD}','${i.VENDOR_SGMT_DIVS_CD},'${i.MARKGET_NM}','${i.SGMT_NM}');" class="text-decoration-none">${i.VENDOR_NO}</a></td>
		<td><a
			href="javascript:setVendorId('${i.VENDOR_NO}','${i.VENDOR_NM}','${i.MARKET_DIVS_CD}','${i.VENDOR_SGMT_DIVS_CD}','${i.MARKGET_NM}','${i.SGMT_NM}');" class="text-decoration-none">${i.VENDOR_NM}</a></td>
	</tr>
</c:forEach>

