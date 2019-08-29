<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>

<div class="row" style="padding-top: 10px; overflow-x: auto;">
	<table class="table border">
		<tbody>
			<tr>
				<td>거래처</td>
				<td>${data.VENDOR_NM}</td>
				<td>Cell Data</td>
				<td>${data.SCALL_DT}</td>
			</tr>
			<tr>
				<td>팀</td>
				<td>${data.TEAMNM}</td>
				<td>담당자</td>
				<td>${data.EMP_NM}</td>
			</tr>
			<tr>
				<td>방문목적</td>
				<td>
					<select name="scall_purpose_cd_u" class="form-control" id="scall_purpose_cd_u">
						<c:forEach items="${scallpurposeCdList}" var="c">
							<option value="${c.CMM_CD}" <c:if test="${c.CMM_CD eq data.SCALL_PURPOSE_CD}">selected</c:if>>${c.CMM_CD_NM}</option>
						</c:forEach>
					</select>
				</td>
				<td>선호도</td>
				<td>
					<select name="scall_pfr_nm_u" class="form-control" id="scall_pfr_nm_u">
						<c:forEach items="${scallpfrNmList}" var="e">
							<option value="${e.CMM_CD}" <c:if test="${e.CMM_CD eq data.SCALL_PFR_NM}">selected</c:if>>${e.CMM_CD_NM}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>방문결과</td>
				<td colspan="3">
					<select name="scall_rslt_cd_u" class="form-control" id="scall_rslt_cd_u" >
						<option value="">선택</option>
						<c:forEach items="${scallrsltcdList}" var="d">
						<option value="${d.CMM_CD}" <c:if test="${d.CMM_CD eq data.SCALL_RSLT_CD}">selected</c:if>>${d.CMM_CD_NM} </option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>브랜드</td>
				<td colspan="3">
					<select name="scall_brand_id_u" class="form-control" id="scall_brand_id_u" >
						<c:forEach items="${brandList}" var="f">
							<option value="${f.BRAND_ID}"  <c:if test="${f.BRAND_ID eq data.BRAND_ID}">selected</c:if>>${f.BRAND_NM} </option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>상담내용</td>
				<td colspan="3">
					<input type="text" class="form-control" name="scall_sale_cntn_u" id="scall_sale_cntn_u" value="${data.SCALL_SALE_CNTN}"/>
				</td>
			</tr>
			<tr>
				<td>협조사항</td>
				<td colspan="3">
					<input type="text" class="form-control" name="scall_cprt_cntn_u" id="scall_cprt_cntn_u" value="${data.SCALL_CPRT_CNTN}"/>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="hidden" name="scall_no" id="scall_no"  value="${data.SCALL_NO}"/>
					<input class="btn btn-dark" type="button" value="수정" id="callupdate"/>
					<input class="btn btn-dark" type="button" value="삭제" id="callviewdelete"/>
				</td>
			</tr>
		</tbody>
	</table>
</div>