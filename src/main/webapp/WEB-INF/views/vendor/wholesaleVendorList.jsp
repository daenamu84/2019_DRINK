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
		<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">코드</th>
			      <th scope="col">거래처명</th>
			    </tr>
			  </thead>
			  <tbody>
				<c:forEach items="${WholesaleVendorList}" var="i" varStatus="status">
					<tr>
						<td><a href="javascript:subListView('${i.VENDOR_NO}','${i.OUTLET_NM}');"class="text-decoration-none">${i.VENDOR_NO}</a></td>
						<td><a href="javascript:subListView('${i.VENDOR_NO}','${i.OUTLET_NM}');"class="text-decoration-none">${i.OUTLET_NM}</a></td>
						<td>${i.USE_YN_NM}</td>
					</tr>
				</c:forEach>
			</tbody>
			</table>
	</div>
</div>
