<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<script src="${pageContext.request.contextPath}/resources/js/common/bootstrap-datepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common/bootstrap-datepicker.kr.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap-datepicker3.min.css" rel="stylesheet">
	<script type="text/javascript">
	var ajaxFlag = false;
	$(function() {
		/* dataRangeOptions.locale.format="YYYYMM";
		dataRangeOptions.singleDatePicker =  true;
		dataRangeOptions.autoUpdateInput = true;
			
		$("._pDateRange").daterangepicker(dataRangeOptions);
		$('._pDateRange').on('apply.daterangepicker', function(ev, picker) {
			$(this).val(picker.endDate.format('YYYYMM'));
		}); */
		
		$('._pDateRange').datepicker({
			 startView: 1,
			    minViewMode: 1,
			    maxViewMode: 2,
			    language: "kr",
			    format: "yyyymm",
			    autoclose: true
		     });
		
		$("i[name='_pDateRangeIcon']").click(function (){
			$('._pDateRange').datepicker("show");
		}); 
	});
	
	$(document).ready(function(){
		$("#deptno").trigger("change");
		
		$("#downloadprod_SumExcel").click(function (e) {
			$("#downloadprod_Sum").table2excel({
	            name: "chart06",
	            filename: "chart06",
	            fileext: ".xls"
	        });
		});

		$("#prodSearch").click(function (){
			if (ajaxFlag)
				return;
			ajaxFlag = true;
			
			var _pStaDt = $("#_pStaDt").val();
			if(_pStaDt =="" || _pStaDt == undefined){
				alert("월을 선택하세요");
				ajaxFlag = false;
				return;
			}
			
			$.ajax({
				type:"GET",  
			    url:"/prod_DistrubutionSearchList",
			    data: {"staDt":_pStaDt},
			    dataType:"html",
			    traditional:true,
			    success:function(args){   
			    	$("#product_listLayer").html(args);
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    } 
			});
		});
	});
	</script>
	<div class="title"> ◈   Distrubution..</div>
	<div class="container" style="max-width:100%;">
		<div class="row">
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<div class="container border" style="padding: 5px;">
								<div class="row" style="padding: 5px 0px;">
									<div class="col-12 col-sm-2"><span class="align-middle"></span></div>
									<div class="col-12 col-sm-3">
										<input type="text" class="_pDateRange form-control bg-white" id="_pStaDt" value="" style="width: 90%;display: inline-block;" readonly autocomplete="off"/><i name="_pDateRangeIcon" class="fas fa-calendar-alt"></i>
									</div>
									<div class="col-12 col-sm-7">
										<input class="btn btn-primary" type="button" id="prodSearch" value="조회">
										<input class="btn btn-dark" type="button" value="엑셀다운로드" id="downloadprod_SumExcel">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row table-responsive text-center" style="padding-top:10px;" >	
						<table class="table" id="downloadprod_Sum">
						  <thead>
						    <tr>
						      <th scope="col"></th>
						      <th scope="col"></th>
						      <th scope="col"></th>
						      <c:forEach items="${BrandList}" var="i" varStatus="status">
						      <th scope="col">${i.BRAND_NM}</th>
						      </c:forEach>
						    </tr>
						  </thead>
						  <tbody id="product_listLayer">
						    
						  </tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<form name="viewForm" method="post">
		<input type="hidden" name="emp_no"/>
		<input type="hidden" name="gubun"/> 
	</form>

<script>
function goPage(pages, pageLine) {
	
	if($("#deptno option:selected").val()!='ALL'){
		if(ajaxFlag)return;
		
		var deptno = $("#deptno option:selected").val();;
		var empno = $("#empno").val();
		
		
		$.ajax({
			type:"GET",  
		    url:"/memberSearch?deptno="+deptno+"&page=" + pages + "&pageLine=" + pageLine,
		    type:"GET",  
		    dataType:"html",
		    traditional:true,
		    success:function(args){   
		    	$("#memberSearchLayer").html(args);
		        ajaxFlag=false;
		    },   
		    error:function(xhr, status, e){  
		        ajaxFlag=false;
		    }  
		});
	}else{
		var url = nowUrl;
		if(url.indexOf('?')  >-1){url += "&";}else{url +="?";}
	    url += "page=" + pages + "&pageLine=" + pageLine+ "&deptno="+$("#deptno option:selected").val();
	    location.href = url;
	}
	
	
}
</script>
   