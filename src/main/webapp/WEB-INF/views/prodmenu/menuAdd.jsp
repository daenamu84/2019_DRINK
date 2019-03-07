<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>


<script>
var ajaxFlag = false;

	$(document).ready(function(){
	
		$("#vendorPop").click(function(){
			$("#popLayer").modal("show");
		});
		
		$("#vendorSearch").click(function(){
			if(ajaxFlag)return;
			ajaxFlag=true;
			$.ajax({      
			    type:"GET",  
			    url:"/vendorSearchPop?vendorNm="+$("#_sVendorNm").val(),      
			    dataType:"html",
			    traditional:true,
			    success:function(args){   
			    	$("#vendorSeachLayer").html(args);
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    }  
			});
		});
		
		$("#prodMenuAdd").click(function(){
			console.log("등록");
			var _oProdNo = $("input[name='prodNo']");
			var _oBrandId = $("input[name='brandId']");
			var _oSubBrandId = $("input[name='subBrandId']");
			var _oSalePrice = $("input[name='salePrice']");
			var _oSaleStdDt = $("input[name='saleStaDt']");
			var _oSaleEndDt = $("input[name='saleEndDt']");
			
			
		});
		
	});
	
	$(document).on("click","i[name='dateRangeIcon']",function() {
	      $(this).parent().find(".dateRange").click();
	});
	 
	function setVendorId(vendorId, vendorNm){
		$("#vendorId").val(vendorId);
		$("#vendorNm").val(vendorNm);
		$("#popLayer").modal("hide");
		if(ajaxFlag)return;
		ajaxFlag=true;
		$.ajax({      
		    type:"GET",  
		    url:"/prodSearch?vendorId="+vendorId,      
		    dataType:"html",
		    traditional:true,
		    success:function(args){   
		    	$("#productList").html(args);
		        ajaxFlag=false;
		    },   
		    error:function(xhr, status, e){  
		        ajaxFlag=false;
		    }  
		});
	}
	
	
</script>

<div class="">
	<div class="title"> ◈  거래처 메뉴</div> 
	<div class="container-fluid">
		<div class="row">			
			<div class="col">
				<div class="container border" style="padding: 5px;">
					<div class="row">
						<div class="col-sm-2"><span class="align-middle">업소</span></div>
						<div class="col-sm-3">
							<input type="text"  name="vendorNm" id="vendorNm" class="form-control" readonly/>
							<input type="hidden" name="vendorId" id="vendorId" class="form-control" />
						</div>
						<div class="col-sm-5">
							<input class="btn btn-primary" type="button" id="vendorPop" value="선택">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px; overflow-x:auto;">	
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">브랜드</th>
			      <th scope="col">서브브랜드</th>
			      <th scope="col">용량</th>
			      <th scope="col">가격(원)</th>
			      <th scope="col">시작일</th>
			      <th scope="col">종료일</th>
			    </tr>
			  </thead>
			  <tbody id="productList">
			  </tbody>
			</table>
		</div>
		<div class="row flex-row-reverse" style="padding-top:10px;">	
			<input class="btn btn-primary float-sm-right" type="button" id="prodMenuAdd" value="등록">
		</div>
	</div>
	
	<!-- modal start  -->	
	<div id="popLayer" class="modal fade" role="dialog">
		<div class="modal-dialog modal-xl">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">거래처 조회</h5>
				</div>
				<div class="modal-body">
					<div class="container" style="padding: 5px;">
						<div class="row">
							<div class="col-sm-2"><span class="align-middle">업소</span></div>
							<div class="col-sm-3">
								<input type="text"  id="_sVendorNm" class="form-control" />
							</div>
							<div class="col-sm-5">
								<input class="btn btn-primary" type="button" id="vendorSearch" value="조회">
							</div>
						</div>
					</div>
				</div>					
				<div class="modal-body" id="subLayer">
				</div>
				<div class="modal-footer">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">거래처 번호</th>
								<th scope="col">거래처명</th>
							</tr>
						</thead>
						<tbody id="vendorSeachLayer">
							<c:forEach items="${vendorList}" var="i" varStatus="status">
								<tr>
									<td><a
										href="javascript:setVendorId('${i.VENDOR_NO}','${i.OUTLET_NM}');" class="text-decoration-none">${i.VENDOR_NO}</a></td>
									<td><a
										href="javascript:setVendorId('${i.VENDOR_NO}','${i.OUTLET_NM}');" class="text-decoration-none">${i.OUTLET_NM}</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
<!-- modal  end  -->
	
</div>