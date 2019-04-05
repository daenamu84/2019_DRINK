<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<select name="vendor_area_cd" class="form-control  " id="vendor_area_cd" style="width:150px">
	<option value="">선택하세요</option>
	<c:forEach items="${vendorareacdMap}" var="b">
		<option value="${b.CMM_CD}" <c:if test="${b.CMM_CD eq VENDOR_AREA_CD}">selected</c:if>>${b.CMM_CD_NM}</option>
	</c:forEach>
</select>