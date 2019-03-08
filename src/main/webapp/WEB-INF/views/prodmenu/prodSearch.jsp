<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<c:forEach items="${prodVendorList}" var="i" varStatus="status">
	<tr>
		<td>${i.BRAND_NM}<input type="hidden" name="_oProdNo" value="${i.PROD_NO}"/><input type="hidden" name="_oBrandId" value="${i.BRAND_ID}"/><input type="hidden" name="_oSubBrandId" value="${i.SUB_BRAND_ID}"/></td> 
		<td>${i.SUB_BRAND_NM}</td>
		<td>${i.PROD_ML_NM}</td>
		<td><input type="number" min="0" name="_oSalePrice" value="" autocomplete="off"/></td>
		<td><input type="text" class="dateRange form-control bg-white" name="_oSaleStaDt" value="" style="width: 90%;display: inline-block;" readonly autocomplete="off"/><i name="dateRangeIcon" class="fas fa-calendar-alt"></i></td>
		<td><input type="text" class="dateRange form-control bg-white" name="_oSaleEndDt" value="" style="width: 90%;display: inline-block;" readonly autocomplete="off"/><i name="dateRangeIcon" class="fas fa-calendar-alt"></i></td>
	</tr>
</c:forEach>
<script>
//조회화면에 추가 하자 
$(function() {
	dataRangeOptions.singleDatePicker =  true;
	dataRangeOptions.autoUpdateInput = false;
	dataRangeOptions.locale.format="YYYYMMDD";
	
	$(".dateRange").daterangepicker(dataRangeOptions);
	$('.dateRange').on('apply.daterangepicker', function(ev, picker) {
		$(this).val(picker.endDate.format('YYYYMMDD'));
	});
	
});
</script>