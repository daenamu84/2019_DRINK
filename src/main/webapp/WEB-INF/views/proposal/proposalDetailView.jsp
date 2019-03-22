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
		$("#goToTop").click(function(){
			$( 'html, body' ).animate( { scrollTop : 0 }, 400 );
			
		});
	
	});
	
</script>

<div class="">
	<div class="title"> ◈  PROPOSAL Detail</div> 
	<div class="container-fluid">
		<div class="row">			
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
		<div class="row" style="overflow-x:auto;">	
			<div id="defultView" style="width:100%;padding:10px 0px;">
				<div class="title">PROPOSAL 기본정보</div> 
				<div class="container-fluid">
					<div class="row">			
						<label class="col col-12 col-sm-2 bg-light text-center align-middle">제안명</label>
						<div class="col col-12 col-sm-10">
							<p class="text-break text-monospace"> aaaaaaaaaaaa   aaaaaaaaa  a   </p>
						</div>
					</div>
				</div>
				<button type="button" name="goToTop" class="btn btn-secondary btn-sm float-right">TOP</button>			
			</div>
			<div id="productView" style="width:100%;padding:10px 0px;">
				<div class="title">STEP02. PROPOSAL 제품/지원품목</div> 
				<div class="container-fluid">
					<div class="row">			
					</div>
				</div>
				<button type="button" name="goToTop" class="btn btn-secondary btn-sm float-right">TOP</button>		
			</div>
			<div id="monthView" style="width:100%;padding:10px 0px;">
				<div class="title">STEP03. PROPOSAL 제품/지원품목 출고계획 등록</div> 
				<div class="container-fluid">
					<div class="row">			
					</div>
				</div>
				<button type="button" name="goToTop" class="btn btn-secondary btn-sm float-right">TOP</button>	
			</div>
			<div id="monthActualtView" style="width:100%;padding:10px 0px;">
				<div class="title">PROPOSAL 제품/지원품목 ACTUAL 등록</div> 
				<div class="container-fluid">
					<div class="row">			
					</div>
				</div>
				<button type="button" name="goToTop" class="btn btn-secondary btn-sm float-right">TOP</button>	
			</div>
		</div>
		<div class="row" style="padding: 5px 0px;">
			<div class="col-12 col-sm-6 text-left">
				<input class="btn btn-light" type="button" id="" value="목록으로">
			</div>
		</div>
	</div>

	
</div>