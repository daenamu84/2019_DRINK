<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>


<div class="row" style="padding-top: 20px;">
	<div class="col-12 col-sm-2">
		<span class="align-middle">거래처</span>
	</div>
	<div class="col-12 col-sm-4">
		<input type="text" class="form-control " name="vendor_nm" id="vendor_nm" value="${vendor_nm}">
	</div>
	<div class="col-12 col-sm-2">
		<input class="btn btn-dark" type="button" value="검색" id="vendorSearch" onClick="vendorSearch()" />
	</div>
</div>
<div class="row" style="padding-top: 10px; overflow-x: auto;">
	<table class="table">
		<thead>
			<tr>
				<th scope="col">담당자</th>
				<th scope="col">제안기간</th>
				<th scope="col">제안명</th>
				<th scope="col">거래처명</th>
				<th scope="col">엑티비티계획</th>
				<th scope="col">제안상태</th>
			</tr>
		</thead>
		<tbody id="proposalList">
			<c:forEach items="${ProPosalList}" var="i" varStatus="status">
				<tr>
					<td>${i.EMP_NM}</td>
					<td>${i.PRPS_STR_DT}~${i.PRPS_END_DT}</td>
					<td><a href="javascript:Set_Appr_ref_nm('${i.PRPS_ID}','${i.PRPS_NM}')">${i.PRPS_NM}</a></td>
					<td>${i.VD_NM}</td>
					<td>${i.ACT_PLAN_CD_NM}</td>
					<td>${i.PRPS_STUS_CD_NM}
						<input type="hidden" name="_apporval_doc" id="_apporval_doc" value="${apporval_doc}"/>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="6">
					<div class="col-xs-3">
						<paging:paging var="skw3" currentPageNo="${paging.page}"
							recordsPerPage="${paging.pageLine}"
							numberOfRecords="${paging.totalCnt}" jsFunc="goApp_docPage1" />
						${skw3.printBtPaging()}
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</div>

