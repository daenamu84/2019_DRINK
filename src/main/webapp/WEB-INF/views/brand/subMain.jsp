<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>


<script>
</script>


<div class="container" style="max-width:100%;">
	<div class="row">
		<div class="col">
			<div class="container border" style="padding: 5px;">
				<div class="row">
					<input type="hidden" id="masterBrandId" value="${masterBrandId}">
					<div class="col-sm-2">서브 코드</div>
					<div class="col-sm-2">
						<input type="text" class="form-control"  id="subBrandId"/>
					</div>
					<div class="col-sm-2">서브 브랜드명</div>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="subBrandNm" />
					</div>
				</div>
				<div class="row">
					<div class="col-sm-2">주류유형코드</div>
					<div class="col-sm-2">
						<select class="custom-select" id="liqKdCd">
							<c:forEach items="${liqKdCdList}" var="i" varStatus="status">
								<option value="${i.CMM_CD}">${i.CMM_CD_NM}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-sm-2">STCASE코드</div>
					<div class="col-sm-3">
						<select class="custom-select" id="stcaseCd">
							<c:forEach items="${stcaseCdList}" var="i" varStatus="status">
								<option value="${i.CMM_CD}">${i.CMM_CD_NM}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-2">사용</div>
					<div class="col-sm-2">
						<select class="custom-select" id="subUseYn">
							<option value="Y" selected>Y</option>
							<option value="N">N</option>
						</select>
					</div>
					<div class="col-sm-2">순위</div>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="subSortOrd"/>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-3">
						<input class="btn btn-primary" type="button" id="brandSInsert" value="등록/수정">
						<input class="btn btn-primary" type="button" id="brandSClean" value="초기화">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row" style="padding-top:10px;overflow-x:auto;">	
		<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">코드</th>
			      <th scope="col">서브브랜드명</th>
			      <th scope="col">주류유형코드</th>
			      <th scope="col">사용</th>
			      <th scope="col">STCASE코드</th>
			      <th scope="col">순위</th>
			    </tr>
			  </thead>
			  <tbody>
				<c:forEach items="${brandSubList}" var="i" varStatus="status">
					<tr>
						<td><a href="javascript:subListView('${masterBrandId}','${i.SUB_BRAND_ID}');"class="text-decoration-none">${i.SUB_BRAND_ID}</a></td>
						<td><a href="javascript:subListView('${masterBrandId}','${i.SUB_BRAND_ID}');"class="text-decoration-none">${i.SUB_BRAND_NM}</a></td>
						<td>${i.LIQ_KD_NM}</td>
						<td>${i.USE_YN}</td>
						<td>${i.STCASE_NM}</td>
						<td>${i.SORT_ORD}</td>
					</tr>
				</c:forEach>

			</tbody>
			</table>
	</div>
</div>
