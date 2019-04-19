<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
	<script type="text/javascript">
		var ajaxFlag = false;
		// 한글입력막기 스크립트
		$( function(){
			$("#login_id" ).on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			});
		})
		
		$(document).ready(function(){
			$("#vendorNm").click(function(){
				$("#vdSearchLayer").modal("show");
			});
			
			$("#legderSearch").click(function(){
				if(ajaxFlag)return;
				ajaxFlag=true;
				var vendor_no = $("#vendorId").val();
				
				if(vendor_no == ""){
					alert("거래처명을 선택하세요.");
					ajaxFlag=false;
					return;
				}
				$.ajax({      
				    type:"GET",  
				    url:"/vendorLedgerSearch",
				    data: {"vendor_no":vendor_no},
				    dataType:"html",
				    traditional:true,
				    success:function(args){   
				    	$("#searchView").html(args);
				        ajaxFlag=false;
				    },   
				    error:function(xhr, status, e){  
				        ajaxFlag=false;
				    }  
				});
			});
		});
		
		function setVendorId(vendorId, vendorNm){
			$("#vendorId").val(vendorId);
			$("#vendorNm").val(vendorNm);
			$("#vdSearchLayer").modal("hide");
		}

	</script>
<div class="">	
	<div class="title"> ◈  거래처원장</div> 
	<div class="container-fluid">
		<div class="row">
			<div class="col">
				<div class="container-fluid border" style="padding: 5px;">
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">거래처명</span></div>
						<div class="col-12 col-sm-2">
							<input type="text"  name="vendorNm" id="vendorNm" class="form-control" readonly value="${vendor_nm}" autocomplete="off"/>
							<input type="hidden" name="vendorId" id="vendorId" class="form-control" value="${vendor_no}"/>
						</div>
						<div class="col-12 col-sm-1"><span class="align-middle">기간</span></div>
						<div class="col-12 col-sm-2">
							<input type="text" class="_pDateRange form-control bg-white" id="_pStaDt" value="" style="width: 90%;display: inline-block;" readonly autocomplete="off"/><i name="_pDateRangeIcon" class="fas fa-calendar-alt"></i>
						</div>
						<div class="col-12 col-sm-1">~</div>
						<div class="col-12 col-sm-2">
							<input type="text" class="_pDateRange form-control bg-white" id="_pEndDt" value="" style="width: 90%;display: inline-block;" readonly autocomplete="off"/><i name="_pDateRangeIcon" class="fas fa-calendar-alt"></i>
						</div>
					</div>
					<div class="row text-right" style="padding: 5px 0px;">
						<div class="col-12 col-sm-12">
							<input class="btn btn-primary" type="button" id="legderSearch" value="검색">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="searchView">
		</div>
	</div>

<!-- modal start  -->	
<div id="vdSearchLayer" class="modal fade" role="dialog">
	<div class="modal-dialog modal-xl">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">거래처 조회</h5>
				<a href="#" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
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
			<div class="modal-body" >
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
									href="javascript:setVendorId('${i.VENDOR_NO}','${i.VENDOR_NM}');" class="text-decoration-none">${i.VENDOR_NO}</a></td>
								<td><a
									href="javascript:setVendorId('${i.VENDOR_NO}','${i.VENDOR_NM}');" class="text-decoration-none">${i.VENDOR_NM}</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<input class="btn btn-secondary float-right" type="button" data-dismiss="modal" value="Close">
			</div>
		</div>
	</div>
</div>
<!-- modal  end  -->
  </div>