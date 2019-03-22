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
		dataRangeOptions.locale.format="YYYYMMDD";
		dataRangeOptions.singleDatePicker =  true;
		dataRangeOptions.autoUpdateInput = true;
			
		$("._pDateRange").daterangepicker(dataRangeOptions);
		$('._pDateRange').on('apply.daterangepicker', function(ev, picker) {
			$(this).val(picker.endDate.format('YYYYMMDD'));
		});
		
		$('#_pStaDt').data('daterangepicker').setStartDate(moment().add(-30,'days').format("YYYYMMDD"));
		$('#_pStaDt').data('daterangepicker').setEndDate(moment().add(-30,'days').format("YYYYMMDD"));
	});		

	$(document).ready(function(){
		$("#proposalSearch").click(function(){
			if(ajaxFlag)return;
			ajaxFlag=true;
			$.ajax({      
			    type:"GET",  
			    url:"/proPosalListSearch",      
			    dataType:"html",
			    traditional:true,
			    success:function(args){   
			    	$("#proposalList").html(args);
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    }  
			});
		});
	});
	
</script>

<div class="">
	<div class="title"> ◈  PROPOSAL</div> 
	<div class="container-fluid">
		<div class="row">			
			<div class="col">
				<div class="container border" style="padding: 5px;">
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">거래처명</span></div>
						<div class="col-12 col-sm-2">
							<input type="text" class="form-control temp" name="outlet_nm" id="outlet_nm">
						</div>
						<div class="col-12 col-sm-2"><span class="align-middle">팀</span></div>
						<div class="col-12 col-sm-2">
							<select name="dept_no" class="form-control" id="dept_no">
								<option value="ALL">전체</option>
								<c:forEach items="${teamList}" var="a">
									<option value="${a.DEPT_NO}">${a.TEAMNM} </option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-sm-2"><span class="align-middle">담당자</span></div>
						<div class="col-12 col-sm-2">
							<input type="text" class="form-control" name="emp_nm" id="emp_nm">
						</div>
					</div>
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2">제안목적</div>
						<div class="col-12 col-sm-2">
							<select class="custom-select" name="prps_purpose_cd" id="prps_purpose_cd">
									<c:forEach items="${cd00021List}" var="a">
									<option value="${a.CMM_CD}">${a.CMM_CD_NM} </option>
									</c:forEach>
						  </select>
						</div>
						<div class="col-12 col-sm-2">엑티비티계획</div>
						<div class="col-12 col-sm-2">
							<select class="custom-select" name="act_plan_cd" id="act_plan_cd">
									<c:forEach items="${cd00022List}" var="b">
										<option value="${b.CMM_CD}">${b.CMM_CD_NM} </option>
									</c:forEach>
						  </select>
						</div>
						<div class="col-12 col-sm-2">제안상태</div>
						<div class="col-12 col-sm-2">
							<select class="custom-select" name="prsp_status" id="prsp_status">
									<c:forEach items="${cd00020List}" var="b">
										<option value="${b.CMM_CD}">${b.CMM_CD_NM} </option>
									</c:forEach>
						  </select>
						</div>
					</div>
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">기간</span></div>
						<div class="col-12 col-sm-3">
							<input type="text" class="_pDateRange form-control bg-white" id="_pStaDt" value="" style="width: 90%;display: inline-block;" readonly autocomplete="off"/><i name="_pDateRangeIcon" class="fas fa-calendar-alt"></i>
						</div>
						<div class="col-12 col-sm-1">~</div>
						<div class="col-12 col-sm-3">
							<input type="text" class="_pDateRange form-control bg-white" id="_pEndDt" value="" style="width: 90%;display: inline-block;" readonly autocomplete="off"/><i name="_pDateRangeIcon" class="fas fa-calendar-alt"></i>
						</div>
					</div>
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-6 text-left">
							<input class="btn btn-primary" type="button" id="proposalInsert" value="PROPOSAL 등록">
						</div>
						<div class="col-12 col-sm-6 text-right">
							<input class="btn btn-primary" type="button" id="proposalSearch" value="조회">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px; overflow-x:auto;">	
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">제안ID</th>
			      <th scope="col">담당팀</th>
			      <th scope="col">담당자</th>
			      <th scope="col">제안기간</th>
			      <th scope="col">제안명</th>
			      <th scope="col">거래처명</th>
			      <th scope="col">제안목적</th>
			      <th scope="col">엑티비티계획</th>
			      <th scope="col">제안상태</th>
			    </tr>
			  </thead>
			  <tbody id="proposalList">
			  </tbody>
			</table>
		</div>
	</div>

	
</div>