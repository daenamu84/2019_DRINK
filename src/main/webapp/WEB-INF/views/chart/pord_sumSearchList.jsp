<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<c:forEach items="${pord_sumSearchList}" var="i" varStatus="status">
	<tr>
		<td class="border">${i.BRAND_T_NM}</td>
		<td class="border">${i.alex.lee}</td> 
		<td class="border">${i.sabrina.ryu}</td> 
		<td class="border">${i.ws.shim}</td> 
		<td class="border">${i.jw.jang}</td> 
		<td class="border">${i.herry.lee}</td> 
		<td class="border">${i.brian.park}</td> 
		<td class="border">${i.bk.hwang}</td> 
		<td class="border">${i.jh.yoon}</td> 
		<td class="border">${i.s.han}</td> 
		<td class="border">${i.sw.seo}</td> 
		<td class="border">${i.jw.seo}</td> 
		<td class="border">${i.js.bae}</td> 
		<td class="border">${i.hy.shin}</td> 
		<td class="border">${i.sunny.lim}</td> 
		<td class="border">${i.emma.choi}</td> 
		<td class="border">${i.kyungeun.jun}</td> 
		<td class="border">${i.hj.ryu}</td> 
		<td class="border">${i.jp.lee}</td>  
		
	</tr>
</c:forEach>
