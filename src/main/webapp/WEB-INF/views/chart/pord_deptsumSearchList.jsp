<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<c:forEach items="${pord_deptsumSearchList}" var="i" varStatus="status">
	<tr>
		<td class="border">${i.BRAND_T_NM}</td>
		<td class="border">${i.Whole_Sales}</td> 
		<td class="border">${i.Mot_1}</td> 
		<td class="border">${i.Mot_2}</td> 
		<td class="border">${i.OFF}</td> 
		<td class="border">${i.Local_1_Busan}</td> 
		<td class="border">${i.Local_2_Deagu}</td> 
	</tr>
</c:forEach>
