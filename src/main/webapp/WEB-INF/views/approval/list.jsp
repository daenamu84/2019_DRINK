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
	});

	$(document).ready(function() {
		//등록 
		$("#apprSend").click(function() {
			location.href = "/ApprovalSend";
		});

		$("#apprSearch").click(function() {
			
			
			var _appr_nm = $("#appr_nm").val();
			var appr_divs_cd = $("#appr_divs_cd option:selected").val();
			
			if (ajaxFlag)
				return;
			ajaxFlag = true;
			$.ajax({
				type : "GET",
				url : "/ApprovalSearchList?appr_divs_cd=" + appr_divs_cd+"&appr_nm=" + _appr_nm,
				dataType : "html",
				traditional : true,
				success : function(args) {
					$("#approvalList").html(args);
					ajaxFlag = false;
				},
				error : function(xhr, status, e) {
					ajaxFlag = false;
				}
			});

		});
	});
	
	function goPage(pages, pageLine) {
		var url = "/ApprovalList";
		if (url.indexOf('?') > -1) {
			url += "&";
		} else {
			url += "?";
		}
		url += "page=" + pages + "&pageLine=" + pageLine;
		location.href = url;
	}
	
	function goPageSub(pages, pageLine) {
		
		var _appr_nm = $("#appr_nm").val();
		var appr_divs_cd = $("#appr_divs_cd option:selected").val();
		
		if(ajaxFlag)return;
		ajaxFlag=true;
		$.ajax({      
		    type:"GET",  
		    url : "/ApprovalSearchList?appr_divs_cd=" + appr_divs_cd+"&appr_nm=" + _appr_nm+"&page=" + pages + "&pageLine=" + pageLine,
		    dataType:"html",
		    traditional:true,
		    success:function(args){   
		    	$("#approvalList").html(args);
		        ajaxFlag=false;
		    },   
		    error:function(xhr, status, e){  
		        ajaxFlag=false;
		    }  
		});
	}
	
	function approvalView(appr_no, gubun){
		document.viewForm.appr_no.value=appr_no;
		document.viewForm.gubun.value=gubun;
		
		document.viewForm.action="/ApprovalView";
		document.viewForm.submit();
	}
</script>

<div class="">
	<div class="title"> ◈  전자결재함</div> 
	<div class="container-fluid">
		<div class="row">			
			<div class="col">
				<div class="container border" style="padding: 5px;">
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">결재구분</span></div>
						<div class="col-12 col-sm-2">
							<select class="custom-select" name="appr_divs_cd" id="appr_divs_cd">
								<option value="ALL">전체</option>
								<c:forEach items="${C00026}" var="a">
									<option value="${a.CMM_CD}">${a.CMM_CD_NM}</option>
								</c:forEach>
							</select>
						
						</div>
						<div class="col-12 col-sm-2"><span class="align-middle">기안명</span></div>
						<div class="col-12 col-sm-4">
							<input type="text"  name="appr_nm" id="appr_nm" class="form-control" autocomplete="off"/>
						</div>
						<div class="col-12 col-sm-2">
							<input class="btn btn-primary" style="margin-right:2px;" type="button" id="apprSearch" value="검색">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px; ">
			<div class="col-12">
				<input class="btn btn-primary  float-right" style="margin-right:2px;" type="button" id="apprSend" value="결재 올리기">
			</div>
		</div>
		<div class="row" style="padding-top:10px; overflow-x:auto;">	
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">결재구분</th>
			      <th scope="col">기안명</th>
			      <th scope="col">기안자</th>
			      <th scope="col">팀</th>
			      <th scope="col">기안일자</th>
			      <th scope="col">결재상태</th>
			    </tr>
			  </thead>
			  <tbody id="approvalList">
					<c:forEach items="${ApprovalList}" var="f" varStatus="status">
						<tr>
							<td>${f.APPR_DIVS_CD_NM}</td>
							<td><a href="javascript:approvalView('${f.APPR_NO}','update')">${f.APPR_NM}</a></td>
							<td>${f.EMP_NM}</td>
							<td>${f.TEAMNM}</td>
							<td>${f.FOR_APPR_DTM_DT}</td>
							<td>${f.APPR_STUS_CD_NM}</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="6">
							<div class="col-xs-3">
								<paging:paging var="skw3" currentPageNo="${paging.page}"
									recordsPerPage="${paging.pageLine}"
									numberOfRecords="${paging.totalCnt}" jsFunc="goPage" />
								${skw3.printBtPaging()}
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<form name="viewForm" method="post">
		<input type="hidden" name="appr_no"/>
		<input type="hidden" name="gubun"/> 
	</form>

</div>