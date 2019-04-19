<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>


<script>
</script>


<div class="container" style="max-width:100%;">
	
	<div class="row" style="padding-top:10px;overflow-x:auto;">	
		<div class="row" style="margin: auto; max-width:100%">
			<div class="col" style="width:150px">도매장명</div>
			<div class="col">
				<input type="text"  id="_wholesale_cd_nm" class="form-control" style="width:150px"/>
			</div>
			<div class="col">
				<input class="btn btn-primary" type="button" id="wholesale_cd_search" value="조회" onClick="seachWholesale();">
			</div>
		</div>
		<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">코드</th>
			      <th scope="col">거래처명</th>
			    </tr>
			  </thead>
			  <tbody id="wholesale">
				<c:forEach items="${WholesaleVendorList}" var="i" varStatus="status">
					<tr>
						<td><a href="javascript:subListView('${i.CMM_CD}','${i.CMM_CD_NM}');"class="text-decoration-none">${i.CMM_CD}</a></td>
						<td><a href="javascript:subListView('${i.CMM_CD}','${i.CMM_CD_NM}');"class="text-decoration-none">${i.CMM_CD_NM}</a></td>
						<td>${i.USE_YN_NM}</td>
					</tr>
				</c:forEach>
				<tr>
	  			<td colspan="2">
	  				<div class="col-xs-3">
					<paging:paging var="skw3" currentPageNo="${paging.page}"
						recordsPerPage="${paging.pageLine}"
						numberOfRecords="${paging.totalCnt}" jsFunc="goPageSearch" />
					${skw3.printBtPaging()}
					</div>
	  			</td>
	  		</tr>
			</tbody>
		</table>
	</div>
</div>
