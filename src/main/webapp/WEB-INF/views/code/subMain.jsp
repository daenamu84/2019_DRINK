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
				<table class="table-borderless ">
					<thead>
						<tr>
							<td>코드</td>
							<td style="padding-left:20px;">
								<input type="text" class="form-control" maxlength="4" name="cmm_cd" id="cmm_cd">
								<input type="hidden" name="mcmm_cd_grp_id" id="mcmm_cd_grp_id" value="${cmm_cd_grp_id}">
							</td>
							<td style="padding-left:20px;">사용여부</td>
							<td style="padding-left:20px;"><select name="use_yn" class="form-control" id="sub_use_yn">
								<option value="Y">사용</option>
								<option value="N">사용안함</option>
							</select></td>
							<td style="padding-left:20px;">코드명</td>
							<td style="padding-left:20px;"><input type="text" class="form-control" name="cmm_cd_nm" id="cmm_cd_nm"></td>
							<td>
								<input type="hidden" name="deptno" id="deptno"/>
								<input class="btn btn-dark" type="button" value="등록" id="codeSInsert" />
								<input class="btn btn-dark" type="button" value="수정" id="codeSupdate" style="display:none"/>
								<input class="btn btn-dark" type="button" value="취소" id="codeSnew" style="display:none"/>
							</td>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div class="row" style="padding-top:10px;overflow-x:auto;">	
		<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">코드</th>
			      <th scope="col">코드명</th>
			      <th scope="col">사용여부</th>
			    </tr>
			  </thead>
			  <tbody>
				<c:forEach items="${codeSubList}" var="i" varStatus="status">
					<tr>
						<td><a href="javascript:subListView('${cmm_cd_grp_id}','${i.CMM_CD}');"class="text-decoration-none">${i.CMM_CD}</a></td>
						<td><a href="javascript:subListView('${cmm_cd_grp_id}','${i.CMM_CD}');"class="text-decoration-none">${i.CMM_CD_NM}</a></td>
						<td>${i.USE_YN_NM}</td>
					</tr>
				</c:forEach>
			</tbody>
			</table>
	</div>
</div>
