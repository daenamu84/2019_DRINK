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

	$(document).ready(function(){
	
		
	});
	
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
							<select name="deptno" class="form-control" id="deptno">
								<option value="">선택하세요</option>
								<c:forEach items="${teamList}" var="c">
								<option value="${c.DEPT_NO}" <c:if test="${c.DEPT_NO eq dept_no }">selected="selected"</c:if>   >${c.TEAMNM} </option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-sm-2"><span class="align-middle">기안명</span></div>
						<div class="col-12 col-sm-4">
							<input type="text"  name="vendorNm" id="vendorNm" class="form-control" readonly autocomplete="off"/>
							<input type="hidden" name="vendorId" id="vendorId" class="form-control" />
						</div>
						<div class="col-12 col-sm-2">
							<input class="btn btn-primary" style="margin-right:2px;" type="button" id="prodSearch" value="조회">
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
			      <th scope="col">결재구분</th>
			      <th scope="col">기안명</th>
			      <th scope="col">기안자</th>
			      <th scope="col">팀</th>
			      <th scope="col">기안일자</th>
			      <th scope="col">결재상태</th>
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