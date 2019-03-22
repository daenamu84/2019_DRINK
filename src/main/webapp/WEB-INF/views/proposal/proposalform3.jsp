<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
	
	<script type="text/javascript">
	
	// 한글입력막기 스크립트
	$( function(){
		$("#login_id" ).on("blur keyup", function() {
			$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
		});
	})
	
	
	
	var ajaxFlag = false;
	
	$(document).ready(function(){
	});
	
</script>
	
	
<div class="">
	<div class="container-fluid">
		<div class="row">			
			<div class="title col col-12  col-sm-5" style="padding: 1px 0px;">◈  STEP2. PROPOSAL 제품/지원목록 출고계획 등록</div> 
		</div>
		
		<div class="row" style="padding: 5px 0px;">
			<table class="table" style="width:90%;margin:0 auto;">
			  <thead>
			    <tr>
			      <th class="border border-bottom-0 text-center" scope="col" width="60%">제품명(제안수량)</th>
			      <th class="border border-bottom-0 text-center" scope="col" width="20%">출고월</th>
			      <th class="border border-bottom-0 text-center" scope="col" width="20%">출고계획수량</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<tr>
			  		<td class="border">
			  			<span>campari 750 ( 수량 100)</span>
			  		</td>
			  		<td class="border">
			  			<input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" style="margin-bottom:3px;" value="">
			  			<input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" style="margin-bottom:3px;" value="">
			  			<input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" style="margin-bottom:3px;" value="">
			  			<input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" style="margin-bottom:3px;" value="">
			  		</td>
			  		<td class="border">
			  			<input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" style="margin-bottom:3px;" value="">
			  			<input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" style="margin-bottom:3px;" value="">
			  			<input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" style="margin-bottom:3px;" value="">
			  			<input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" style="margin-bottom:3px;" value="">
			  		</td>
			  	</tr>
			  	<tr>
			  		<td class="border">
			  			<span>campari 750 ( 수량 100)</span>
			  		</td>
			  		<td class="border">
			  			<input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" style="margin-bottom:3px;" value="">
			  		</td>
			  		<td class="border">
			  			<input type="text" id="deliveryCnt" class="form-control" name="deliveryCnt" style="margin-bottom:3px;" value="">
			  		</td>
			  	</tr>
			  </tbody>
			 </table>
		</div>
		<div class="row" style="padding: 5px 0px;">
			<div class="col-12 col-sm-9 text-left">
				<input class="btn btn-light" type="button" id="" value="목록으로">
				<input class="btn btn-light" type="button" id="" value="SETP01 수정">
				<input class="btn btn-light" type="button" id="" value="SETP02 수정">
			</div>
			<div class="col-12 col-sm-3 text-RIGHT">
				<input class="btn btn-light" type="button" id="" value="SETP03 등록">
			</div>
		</div>
	</div>
</div>
