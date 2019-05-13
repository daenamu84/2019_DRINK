<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="container-fluid">
	<div class="row"  style="padding: 5px 0px;">			
		<div class="col-sm-3">브랜드</div>
		<div class="col-sm-4">
			: &nbsp;${prodMenuView.BRAND_NM}
			<input type="hidden" name="_uVendorNo" value="${prodMenuView.VENDOR_NO}"/>
			<input type="hidden" name="_uProdNo" value="${prodMenuView.PROD_NO}"/>  
	  </div>
	</div>
	<div class="row"  style="padding: 5px 0px;">			
		<div class="col-sm-3">서브 브랜드</div>
		<div class="col-sm-4">
			: &nbsp;${prodMenuView.SUB_BRAND_NM}
	  </div>
	</div>
	<div class="row"  style="padding: 5px 0px;">			
		<div class="col-sm-3">가격</div>
		<div class="col-sm-4">
			<input type="number" min="0" name="_uSalePrice" value="${prodMenuView.SALE_PRICE}" autocomplete="off"/>
	  </div>
	</div>
	<div class="row"  style="padding: 5px 0px;">	
		<div class="col-sm-3">시작일</div>
		<div class="col-sm-4">
			<input type="text" class="_uDateRange form-control bg-white" name="_uSaleStaDt" value="${fn:substring(prodMenuView.SALE_STA_DT,0,6)}" style="width: 80%;display: inline-block;" readonly autocomplete="off"/><i name="_uDateRangeIcon" class="fas fa-calendar-alt"></i>
		</div>
	</div>
	<div class="row"  style="padding: 5px 0px;">	
		<div class="col-sm-3">종료일</div>
		<div class="col-sm-4">
			<input type="text" class="_uDateRange form-control bg-white" name="_uSaleEndDt" value="${fn:substring(prodMenuView.SALE_END_DT,0,6)}" style="width: 80%;display: inline-block;" readonly autocomplete="off"/><i name="_uDateRangeIcon" class="fas fa-calendar-alt"></i>
		</div>
	</div>
</div>
<script>
//조회화면에 추가 하자 
$(function() {
	/* dataRangeOptions.singleDatePicker =  true;
	dataRangeOptions.autoUpdateInput = false;
	dataRangeOptions.locale.format="YYYYMMDD";
	
	$("._uDateRange").daterangepicker(dataRangeOptions);
	$('._uDateRange').on('apply.daterangepicker', function(ev, picker) {
		$(this).val(picker.endDate.format('YYYYMMDD'));
	}); */
	
	$('._uDateRange').datepicker({
		 startView: 1,
		    minViewMode: 1,
		    maxViewMode: 2,
		    language: "kr",
		    format: "yyyymm",
		    autoclose: true
	     });
	
});
</script>