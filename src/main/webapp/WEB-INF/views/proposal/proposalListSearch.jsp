<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<c:forEach items="${ProPosalList}" var="i" varStatus="status">
	<tr>
		<td>${i.PRPS_ID}</td>
		<td>${i.TEAMNM}</td>
		<td>${i.EMP_NM}</td>
		<td>${i.PRPS_STR_DT}~${i.PRPS_END_DT}</td>
		<td><a href="javascript:setView('${i.PRPS_ID}','update')">${i.PRPS_NM}</a></td>
		<td>${i.VD_NM}</td>
		<td>${i.ACT_PLAN_CD_NM}</td>
		<td>${i.PRPS_STUS_CD_NM}</td>
	</tr>
</c:forEach>

<tr>
	<td colspan="9">
		<div class="col-xs-3">
			<paging:paging var="skw3" currentPageNo="${paging.page}"
				recordsPerPage="${paging.pageLine}"
				numberOfRecords="${paging.totalCnt}" jsFunc="goPageSub" />
			${skw3.printBtPaging()}
		</div>
	</td>
</tr>
