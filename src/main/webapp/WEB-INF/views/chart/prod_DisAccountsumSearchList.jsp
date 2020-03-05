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
		<td class="border">${i.EMP_NM}</td>
		<td class="border">${i.American_Honey}</td>
		<td class="border">${i.Aperol}</td>
		<td class="border">${i.Appleton}</td>
		<td class="border">${i.Averna}</td>
		<td class="border">${i.BB_R}</td>
		<td class="border">${i.Beluga}</td>
		<td class="border">${i.Bulldog}</td>
		<td class="border">${i.Campari}</td>
		<td class="border">${i.Cinzano}</td>
		<td class="border">${i.Cynar}</td>
		<td class="border">${i.Espolon}</td>
		<td class="border">${i.FRANGELICO}</td>
		<td class="border">${i.Glengrant}</td>
		<td class="border">${i.Grand_Marnier}</td>
		<td class="border">${i.Guojiao}</td>
		<td class="border">${i.No_3}</td>
		<td class="border">${i.OMAR}</td>
		<td class="border">${i.Patron}</td>
		<td class="border">${i.Russells}</td>
		<td class="border">${i.SKYY}</td>
		<td class="border">${i.SKYY_Infusions}</td>
		<td class="border">${i.The_Kings_Ginger}</td>
		<td class="border">${i.Wild_Turkey}</td>
		<td class="border">${i.X_rated}</td>
	</tr>
</c:forEach>
