<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>



<c:forEach items="${productList}" var="i" varStatus="status">
	<a href="javascript:setValueDate('${i.PROD_NO}','${i.BRAND_NM}_${i.SUB_BRAND_NM}_${i.PROD_ML_NM}','${i.CASERATE_AMT}')">${i.BRAND_NM}_${fn:replace(i.SUB_BRAND_NM, '\\\'', '\'')}_${i.PROD_ML_NM}
	<c:if test="${i.CASERATE_AMT ne null }">_<fmt:formatNumber value="${i.CASERATE_AMT}" pattern="#,###" />원</c:if></a>
	
	


</c:forEach>