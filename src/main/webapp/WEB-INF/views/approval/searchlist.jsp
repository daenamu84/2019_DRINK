<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>





<c:forEach items="${ApprovalList}" var="f" varStatus="status">
	<tr>
		<td>${f.APPR_DIVS_CD_NM}</td>
		<td>${f.APPR_NM}</td>
		<td>${f.EMP_NM}</td>
		<td>${f.TEAMNM}</td>
		<td>${f.FOR_APPR_DTM_DT}</td>
		<td>${f.APPR_STUS_CD_NM}</td>
	</tr>
</c:forEach>
<tr>
	<td colspan="6">
		<div class="col-xs-3">
			<paging:paging var="skw3" currentPageNo="${paging.page}"
				recordsPerPage="${paging.pageLine}"
				numberOfRecords="${paging.totalCnt}" jsFunc="goPageSub" />
			${skw3.printBtPaging()}
		</div>
	</td>
</tr>
