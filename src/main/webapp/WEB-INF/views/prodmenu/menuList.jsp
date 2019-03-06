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

	$(function() {
		var _pDdataRangeOptions = {};
		_pDdataRangeOptions.locale={
				format:'YYYYMMDD',
				separator: ' - ',
				applyLabel: 'Apply',
				cancelLabel: 'Cancel',
				fromLabel: 'From',
				toLabel: 'To',
				customRangeLabel: 'Custom',
				weekLabel: 'W',
				daysOfWeek: ['일', '월', '화', '수', '목', '금','토'],
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
		};
		_pDdataRangeOptions.singleDatePicker =  true;
		_pDdataRangeOptions.autoUpdateInput = false;
			
		$("._pDateRange").daterangepicker(_pDdataRangeOptions);
		$('._pDateRange').on('apply.daterangepicker', function(ev, picker) {
			$(this).val(picker.endDate.format('YYYYMMDD'));
		});
	});	

	$(document).ready(function(){
	
		$("#vendorPop").click(function(){
			$("#popLayer").modal("show");
		});
		
		$("#vendorSearch").click(function(){
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
			if(_pStaDt =="" || _pStaDt == undefined){
				alert("시작일자를 선택하세요.");
				ajaxFlag=false;
				return;
			}
			var _pEndDt = $("#_pEndDt").val();
			if(_pEndDt =="" || _pEndDt == undefined){
				alert("종료일자를 선택하세요.");
				ajaxFlag=false;
				return;
			}
			$.ajax({      
			    type:"GET",  
			    url:"/vendorSearchPop?="+$("#_sVendorNm").val(),
			    data: {"deptNo":_pDeptNo,"empNo":_pEmpNo,"staDt":_pStaDt,"endDt":_pEndDt},
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
		
		
	});
	
	$(document).on("click","i[name='_pDateRangeIcon']",function() {
	      $(this).parent().find("._pDateRange").click();
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
	
	$(document).on("change","#deptno", _.debounce( function(){
		if(ajaxFlag)return;
		ajaxFlag=true;
		if($(this).val() == ""){
			ajaxFlag=false;
			return;
		}
		$.ajax({      
		    type:"POST",  
		    url:"/Dept_EmpList",      
		    data: {"deptno":$(this).val(),"empno": ""},
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
	</div>
	
	<!-- modal start  -->	
	<div id="popLayer" class="modal fade" role="dialog">
		<div class="modal-dialog modal-xl">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">거래처 조회</h5>
					<a href="#" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
				</div>
				<div class="modal-body">
					<div class="container" style="padding: 5px;">
						<div class="row" style="padding: 5px 0px;">
							<div class="col-sm-2"><span class="align-middle">팀</span></div>
							<div class="col-sm-3">
								<select name="deptno" class="form-control" id="deptno" >
									<option value="">선택하세요</option>
									<c:forEach items="${teamList}" var="c">
									<option value="${c.DEPT_NO}" >${c.TEAMNM} </option>
									</c:forEach>
								</select>
							</div>
							<div class="col-sm-2"><span class="align-middle">팀원</span></div>
							<div class="col-sm-3" id="empList">
							</div>
						</div>
						<div class="row" style="padding: 5px 0px;">
							<div class="col-sm-2"><span class="align-middle">기간</span></div>
							<div class="col-sm-2">
								<input type="text" class="_pDateRange form-control" id="_pStaDt" value="" style="width: 90%;display: inline-block;" autocomplete="off"/><i name="_pDateRangeIcon" class="fas fa-calendar-alt"></i>
							</div>~
							<div class="col-sm-2">
								<input type="text" class="_pDateRange form-control" id="_pEndDt" value="" style="width: 90%;display: inline-block;" autocomplete="off"/><i name="_pDateRangeIcon" class="fas fa-calendar-alt"></i>
							</div>
							<div class="col-sm-4">
								<input class="btn btn-primary" type="button" id="vendorSearch" value="조회">
							</div>
						</div>
					</div>
				</div>					
				<div class="modal-body" id="subLayer">
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
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
<!-- modal  end  -->
	
</div>