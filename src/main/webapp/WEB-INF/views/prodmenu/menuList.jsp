<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="${pageContext.request.contextPath}/resources/js/common/bootstrap-datepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common/bootstrap-datepicker.kr.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap-datepicker3.min.css" rel="stylesheet">
<script>
var ajaxFlag = false;

	$(function() {
		/* dataRangeOptions.locale.format="YYYYMM";
		dataRangeOptions.singleDatePicker =  true;
		dataRangeOptions.autoUpdateInput = false;
			
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
		
		if("${scY}"=="Y"){
			$("#vdSearchLayer").modal("show");
		}
		if("${dept_no}"!=""){
			$("#deptno").trigger("change");
		}
	});	

	$(document).ready(function(){
	
		//$("#deptno").val("");
		$("#vendorNm").click(function(){
			$("#vdSearchLayer").modal("show");
		});

		$("#prodInsert").click(function(){
			location.href="/ProdMenuAdd";
		});
		
		$("#prodUpdateBtn").click(function(){
			if(ajaxFlag)return;
			ajaxFlag=true;
			var _uVendorNo = $("input[name='_uVendorNo']");
			var _uProdNo = $("input[name='_uProdNo']");
			var _uSalePrice = $("input[name='_uSalePrice']");
			var _uSaleStaDt = $("input[name='_uSaleStaDt']");
			var _uSaleEndDt = $("input[name='_uSaleEndDt']");
			
			if(_uVendorNo.length < 1 && _uProdNo.length < 1 && _uSalePrice.length < 1 && _uSaleStaDt.length < 1 && _uSaleEndDt.length < 1 ){
				alert("입력 정보는 필수 입니다. \n 다시 시도해주세요.");
				location.reload();
				ajaxFlag=false;
				return;
			}
			
			var _uStaDt = _uSaleStaDt[0].value;
			if(_uStaDt  != ""){
				_uStaDt  = moment(_uStaDt,'YYYYMM').format("YYYYMMDD");
			}
			var _uEndDt = _uSaleEndDt[0].value;
			if(_uEndDt != ""){
				_uEndDt = moment(_uEndDt,'YYYYMM').add(1,"month").add(-1,"day").format("YYYYMMDD");
			}
			
			$.ajax({      
			    type:"POST",  
			    url:"/prodMenuDetailUpdate",
			    data: JSON.stringify({"vendorNo":_uVendorNo[0].value,"prodNo":_uProdNo[0].value,"salePrice":_uSalePrice[0].value,"saleStaDt":_uStaDt,"saleEndDt":_uEndDt}),
			    dataType:"json",
			    contentType:"application/json;charset=UTF-8",
			    traditional:true,
			    success:function(args){   
			        if(args.returnCode == "0000"){
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	location.href="/ProdMenuList";
			        }else{
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	location.href="/ProdMenuList";
			        }
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        if(xhr.status == 403){
			        	alert("로그인이 필요한 메뉴 입니다.");
			        	location.replace("/logIn");
			        }else{
			        	alert("처리중 에러가 발생 하였습니다.");
			        	location.href="/ProdMenuList";
			        }
			        ajaxFlag=false;
			    }   
			});
			
		});
		$("#vendorSearch").click(function(){
			if(ajaxFlag)return;
			ajaxFlag=true;

			location.href="/ProdMenuList?scY=Y&dept_no="+$("#deptno").val()+"&staDt="+$("#_pStaDt").val()+"&endDt="+$("#_pEndDt").val()+"&vendorNm="+$("#_sVendorNm").val();
		
		});
		
		$("#prodSearch").click(function(){
			if(ajaxFlag)return;
			ajaxFlag=true;
			var _pDeptNo = $("#deptno").val();
			if(_pDeptNo =="" || _pDeptNo == undefined){
				alert("팀을 선택하세요.");
				ajaxFlag=false;
				return;
			}
			var _pEmpNo = $("#empno").val();
			if(_pEmpNo =="" || _pEmpNo == undefined){
				alert("팀원을 선택하세요.");
				ajaxFlag=false;
				return;
			}
			var _pStaDt = $("#_pStaDt").val();
			if(_pStaDt  != ""){
				_pStaDt  = moment(_pStaDt,'YYYYMM').format("YYYYMMDD");
			}
			/* 2019.05.12 주석처리
			if(_pStaDt =="" || _pStaDt == undefined){
				alert("시작일자를 선택하세요.");
				ajaxFlag=false;
				return;
			}
			*/
			var _pEndDt = $("#_pEndDt").val();
			if(_pEndDt != ""){
				_pEndDt = moment(_pEndDt,'YYYYMM').add(1,"month").add(-1,"day").format("YYYYMMDD");
			}
			/* 2019.05.12 주석처리
			if(_pEndDt =="" || _pEndDt == undefined){
				alert("종료일자를 선택하세요.");
				ajaxFlag=false;
				return;
			}
			*/
			var _pVendorId = $("#vendorId").val();
			if(_pVendorId =="" || _pVendorId == undefined){
				alert("업소를 검색하세요.");
				ajaxFlag=false;
				return;
			}
			$.ajax({      
			    type:"GET",  
			    url:"/prodSearchList?="+$("#_sVendorNm").val(),
			    data: {"deptNo":_pDeptNo,"empNo":_pEmpNo,"staDt":_pStaDt,"endDt":_pEndDt,"vendorId":_pVendorId},
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
		});
		
		
	});
	
	function getBrandList() {
		if (ajaxFlag)
			return;
		ajaxFlag = true;
		var deptno = "";
		var gubun = "search";
		
		_brandid = $("#brandid option:selected").val();
		
		$.ajax({      
		    type:"GET",  
		    url:"/prodBrandSearchList",
		    data: {"brandID":_brandid},
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
	
	
	$(document).on("click","i[name='_pDateRangeIcon']",function() {
		  $(this).parent().find("._pDateRange").datepicker("show");
	});
	
	$(document).on("click","i[name='_uDateRangeIcon']",function() {
	      $(this).parent().find("._uDateRange").datepicker("show");
	});
	
	function setVendorId(vendorId, vendorNm){
		$("#vendorId").val(vendorId);
		$("#vendorNm").val(vendorNm);
		$("#vdSearchLayer").modal("hide");
	}
	
	$(document).on("change","#deptno", _.debounce( function(){
		if(ajaxFlag)return;
		ajaxFlag=true;
		if($(this).val() == ""){
			$("#empList").empty();
			ajaxFlag=false;
			return;
		}
		$.ajax({      
		    type:"POST",  
		    url:"/Dept_EmpList",      
		    data: {"deptno":$(this).val(),"empno": "${loginSession.dept_no}"},
		    dataType:"html",
		    traditional:true,
		    success:function(args){   
		        $("#empList").empty();
		        $("#empList").html(args);
		        ajaxFlag=false;
		    },   
		    error:function(xhr, status, e){  
		        if(xhr.status == 403){
		        	alert("로그인이 필요한 메뉴 입니다.");
		        	location.replace("/logIn");
		        }else{
		        	alert("처리중 에러가 발생 하였습니다.");
		        	location.reload();
		        }
		        ajaxFlag=false;
		    }  
		});
	},0));
	
	function prodUpdateView(vendorNo, prodNo){
		if(ajaxFlag)return;
		ajaxFlag=true;
		$.ajax({      
		    type:"POST",  
		    url:"/prodUpdateView",      
		    data: {"vendorNo":vendorNo,"prodNo": prodNo},
		    dataType:"html",
		    traditional:true,
		    success:function(args){   
		        $("#subProdUpdateLayer").empty();
		        $("#subProdUpdateLayer").html(args);
		        $("#vProdUpdateLayer").modal("show");
		        ajaxFlag=false;
		    },   
		    error:function(xhr, status, e){  
		        if(xhr.status == 403){
		        	alert("로그인이 필요한 메뉴 입니다.");
		        	location.replace("/logIn");
		        }else{
		        	alert("처리중 에러가 발생 하였습니다.");
		        	location.reload();
		        }
		        ajaxFlag=false;
		    }  
		});
		
	}
	
	
	function goPage(pages, pageLine){
		if(ajaxFlag)return;
		ajaxFlag=true;
		
		var _pStaDt = $("#_pStaDt").val();
		if(_pStaDt  != ""){
			_pStaDt  = moment(_pStaDt,'YYYYMM').format("YYYYMMDD");
		}
		var _pEndDt = $("#_pEndDt").val();
		if(_pEndDt != ""){
			_pEndDt = moment(_pEndDt,'YYYYMM').add(1,"month").add(-1,"day").format("YYYYMMDD");
		}
		
		$.ajax({      
		    type:"GET",  
		    url:"/prodSearchList?="+$("#_sVendorNm").val(),
		    data: {"deptNo":$("#_pgDeptNo").val(),"empNo":$("#_pgEmpNo").val(),"staDt":_pStaDt,"endDt":_pEndDt,"vendorId":$("#_pgVendorId").val(),"page":pages,"pageLine":pageLine},
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
	
	function goBrandPage(pages, pageLine){
		if(ajaxFlag)return;
		ajaxFlag=true;
		
		_brandid = $("#brandid option:selected").val();
		
		$.ajax({      
		    type:"GET",  
		    url:"/prodBrandSearchList",
		    data: {"brandID":_brandid,"page":pages,"pageLine":pageLine},
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
	
	
	function goPopPage(pages, pageLine){
		if(ajaxFlag)return;
		ajaxFlag=true;
		
		location.href="/ProdMenuList?scY=Y&dept_no="+$("#deptno").val()+"&staDt="+$("#_pStaDt").val()+"&endDt="+$("#_pEndDt").val()+"&page="+pages+"&pageLine="+pageLine;
		
	}
</script>

<div class="">
	<div class="title"> ◈   Distribution</div> 
	<div class="container-fluid">
		<div class="row">			
			<div class="col">
				<div class="container border" style="padding: 5px;">
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">팀</span></div>
						<div class="col-12 col-sm-2">
							<select name="deptno" class="form-control" id="deptno">
								<option value="">선택하세요</option>
								<c:forEach items="${teamList}" var="c">
								<option value="${c.DEPT_NO}" <c:if test="${c.DEPT_NO eq dept_no }">selected="selected"</c:if>   >${c.TEAMNM} </option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-sm-2" id="empList">
						</div>
						<div class="col-12 col-sm-2"><span class="align-middle">업소</span></div>
						<div class="col-12 col-sm-4">
							<input type="text"  name="vendorNm" id="vendorNm" class="form-control" readonly autocomplete="off"/>
							<input type="hidden" name="vendorId" id="vendorId" class="form-control" />
						</div>
					</div>
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">기간</span></div>
						<div class="col-12 col-sm-3">
							<input type="text" class="_pDateRange form-control bg-white" id="_pStaDt" value="${fn:substring(staDt,0,6)}" style="width: 90%;display: inline-block;" readonly autocomplete="off"/><i name="_pDateRangeIcon" class="fas fa-calendar-alt"></i>
						</div>
						<div class="col-12 col-sm-1">~</div>
						<div class="col-12 col-sm-3">
							<input type="text" class="_pDateRange form-control bg-white" id="_pEndDt" value="${fn:substring(endDt,0,6)}" style="width: 90%;display: inline-block;" readonly autocomplete="off"/><i name="_pDateRangeIcon" class="fas fa-calendar-alt"></i>
						</div>
					</div>
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">브랜드</span></div>
						<div class="col-12 col-sm-7">
							<select name="brandid" class="form-control" id="brandid"  onchange="getBrandList();">
								<option value="">선택하세요</option>
								<c:forEach items="${brandList}" var="d">
								<option value="${d.BRAND_ID}" >${d.BRAND_NM} </option>
								</c:forEach>
							</select>
							* 브랜드 조회 시 팀 /팀원 /업소/기간  조회 조건은 무시 됩니다.<br>
							* 브랜드 조회 시 해당 브랜드메뉴가 등록된 모든 업소가 조회 됩니다. 
						</div>
						<div class="col-12 col-sm-3">
							<input class="btn btn-primary" type="button" id="prodSearch" value="조회">
							<input class="btn btn-primary" type="button" id="prodInsert" value="등록">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px; overflow-x:auto;">	
			<table class="table">
			  <thead>
			    <tr>
				  <th scope="col">거래처</th>
			      <th scope="col">브랜드</th>
			      <th scope="col">서브브랜드</th>
			      <th scope="col">용량</th>
			      <th scope="col">가격(원)</th>
			      <th scope="col">상태</th>
			      <th scope="col">시작일</th>
			      <th scope="col">종료일</th>
			      <th scope="col">자사메뉴여부</th>
			      <th scope="col">관리</th>
			     </tr>
			  </thead>
			  <tbody id="productList">
			  </tbody>
			</table>
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
								<tr>
						  			<td colspan="11">
						  				<div class="col-xs-3">
										<paging:paging var="skw3" currentPageNo="${paging.page}"
											recordsPerPage="${paging.pageLine}"
											numberOfRecords="${paging.totalCnt}" jsFunc="goPopPage" />
										${skw3.printBtPaging()}
										</div>
						  			</td>
						  		</tr>
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

<!-- modal start  -->	
	<div id="vProdUpdateLayer" class="modal fade" role="dialog">
		<div class="modal-dialog modal-xl">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">거래처 수정</h5>
				</div>
				<div class="modal-body" id="subProdUpdateLayer">
				</div>
				<div class="modal-footer">
					<input class="btn btn-success float-right" type="button" id="prodUpdateBtn" value="수정">
					<input class="btn btn-secondary float-right" type="button" data-dismiss="modal" value="Close">
				</div>
			</div>
		</div>
	</div>
<!-- modal  end  -->
	
</div>