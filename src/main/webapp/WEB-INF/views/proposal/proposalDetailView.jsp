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
		<div class="row">			
			<div class="col">
				<div class="btn-group" role="group" aria-label="...">
					<div class="btn btn-info col-sm-3">PROPOSAL 기본정보</div>
					<div class="btn btn-info col-sm-3">제품/지원품목</div>
					<div class="btn btn-info col-sm-3">월별 출고계획</div>
					<div class="btn btn-info col-sm-3">월별 ACTURL</div>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px; overflow-x:auto;">	
		</div>
	</div>

	
</div>