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
	<div class="title"> ◈  PROPOSAL Detail</div> 
	<div class="container-fluid">
		<div class="row" ">			
			<label class="col col-12  col-sm-3" style="padding: 1px 0px;">
					<a class="btn btn-info text-white" style="width: 99%;" href="#defultView">PROPOSAL 기본정보</a>
			</label>
			<label class="col col-12 col-sm-3" style="padding: 1px 0px;">
					<a class="btn btn-info text-white" style="width: 99%;" href="#productView">제품/지원품목</a>
			</label>
			<label class="col col-12 col-sm-3" style="padding: 1px 0px;">
					<a class="btn btn-info text-white" style="width: 99%;" href="#monthView">월별 출고계획</a>
			</label>
			<label class="col col-12 col-sm-3" style="padding: 1px 0px;">
					<a class="btn btn-info text-white" style="width: 99%;" href="#monthActualtView">월별 ACTUAL</a>
			</label>
		</div>
		<div class="row" style="padding-top:10px; overflow-x:auto;">	
			<div id="defultView" style="height:800px;width:100%;background-color:yellow;">
				<div class="container-fluid">
					<div class="row">			
						<label class="col col-12 col-sm-2 bg-light text-center align-middle">제안명</label>
						<div class="col col-12 col-sm-10">
							<p class="text-break text-monospace"> aaaaaaaaaaaa   aaaaaaaaa  a   </p>
						</div>
					</div>
				</div>			
			</div>
			<div id="productView" style="height:800px;width:100%;background-color:green;">
			</div>
			<div id="monthView" style="height:800px;width:100%;background-color:blue;">
			</div>
			<div id="monthActualtView" style="height:800px;width:100%;background-color:red;">
			</div>
		</div>
	</div>

	
</div>