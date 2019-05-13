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
							<input type="text"  name="appTitle" id="appTitle" class="form-control" autocomplete="off"/>
						</div>
						<div class="col-12 col-sm-2">
							<input class="btn btn-primary" style="margin-right:2px;" type="button" id="apprSearch" value="검색">
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
	
</div>