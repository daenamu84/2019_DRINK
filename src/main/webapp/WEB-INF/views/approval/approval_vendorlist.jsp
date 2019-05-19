<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>

	<script type="text/javascript">
	
	
	</script>
	
	<div class="container" style="max-width:100%;">
		<div class="row">
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row" style="padding-top:20px;">
						<div class="col-12 col-sm-2"><span class="align-middle">거래처</span></div>
						<div class="col-12 col-sm-4">
							<input type="text" class="form-control " name="vendor_nm" id="vendor_nm" value="${vendor_nm}">
						</div>
						<div class="col-12 col-sm-2"><input class="btn btn-dark" type="button" value="검색" id="vendorSearch" onClick="vendorSearch()"/></div>
					</div>
					<div class="row" style="padding-top:20px;">	
						<table class="table">
						  <thead>
						    <tr>
						      <th scope="col">거래처명 </th>
						      <th scope="col">관리팀</th>
						      <th scope="col">담당자</th>
						      <th scope="col">Market</th>
						      <th scope="col">Segmentation</th>
						    </tr>
						  </thead>
						  <tbody id="vendorSeachLayer">
						  	<c:forEach items="${vendorList}" var="f" varStatus="status">	
						  		<tr>
									<td><a href="javascript:Set_Appr_ref_nm('${f.VENDOR_NO}','${f.VENDOR_NM}')">${f.VENDOR_NM}</a></td>
									<td>${f.TEAMNM}</td>
									<td>${f.EMP_NM}</td>
									<td>${f.MARKGET_NM}</td>
									<td>${f.SGMT_NM}
									<input type="hidden" name="_apporval_doc" id="_apporval_doc" value="${apporval_doc}"/>
									</td>
								</tr>
						  	</c:forEach>
						  		<tr>
						  			<td colspan="5">
						  				<div class="col-xs-3">
										<paging:paging var="skw3" currentPageNo="${paging.page}"
											recordsPerPage="${paging.pageLine}"
											numberOfRecords="${paging.totalCnt}" jsFunc="goApp_docPage" />
										${skw3.printBtPaging()}
										</div>
						  			</td>
						  		</tr>
						  </tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	