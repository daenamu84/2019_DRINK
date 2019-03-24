<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<script>
var ajaxFlag = false;

	$(function() {
	});		

	$(document).ready(function(){
		$("#goToTop").click(function(){
			$( 'html, body' ).animate( { scrollTop : 0 }, 400 );
			
		});
		
		$('.summernote').summernote({
			height: 400,
			toolbar: []
			
		});
		$('.summernote').summernote('disable');
	});
	
	function viewStep(prps_id, step, gubun){
		document.viewForm.prps_id.value=prps_id;
		document.viewForm.gubun.value=gubun;
		if(step=='01'){
			document.viewForm.action="/proPosalForm";
		}else if(step=='02'){
			document.viewForm.action="/proPosalForm02";	
		}
		document.viewForm.submit();
	}
	
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
			<div id="defultView" style="padding-top:10px; overflow-x:auto; width:90%; margin: 0 auto;">
				<div class="title"><b>1.PROPOSAL 기본정보</b></div> 
				<div class="container-fluid border">
					<div class="row" style="padding-top:10px">			
						<div class="col col-12 col-sm-10">
							<div class="form-group row">
								<label for="prps_nm"
									class="col-md-2 col-form-label text-md-left">제안명</label>
								<div class="col-md-8">
									<input type="text" id="prps_nm" class="form-control"
										name="prps_nm" value="${data.PRPS_NM}" readonly>
								</div>
							</div>
							<div class="form-group row">
								<label for="prps_purpose_cd"
									class="col-md-2 col-form-label text-md-left">제안목적</label>
								<div class="col-md-4">
									<input type="text" id="prps_purpose_nm" class="form-control"
										name="prps_purpose_nm" value="${data.PRPS_PURPOSE_CD_NM}"
										readonly>
								</div>
								<label for="act_plan_cd"
									class="col-md-2 col-form-label text-md-left">액티비티계획</label>
								<div class="col-md-4">
									<input type="text" id="act_plan_cd_nm" class="form-control"
										name="act_plan_cd_nm" value="${data.ACT_PLAN_CD_NM}" readonly>
								</div>
							</div>
							<div class="form-group row">
								<label for="prps_purpose_cd"
									class="col-md-2 col-form-label text-md-left">제안기간</label>
								<div class="col-md-4">
									<input type="text" class="form-control" name="prps_str_dt"
										value="${data.PRPS_STR_DT1}" readonly />~ <input type="text"
										class="form-control" name="prps_end_dt"
										value="${data.PRPS_END_DT1}" readonly />
								</div>
								<label for="act_plan_cd"
									class="col-md-2 col-form-label text-md-left">거래처</label>
								<div class="col-md-4">
									<input type="text" id="outlet_nm" class="form-control"
										name="outlet_nm" readonly value="${data.VD_NM}">
								</div>
							</div>
							<div class="form-group row">
								<label for="prps_purpose_cd"
									class="col-md-2 col-form-label text-md-left">예산금액</label>
								<div class="col-md-4">
									<input type="text" id="budg_amt" class="form-control"
										name="budg_amt" readonly value="${data.BUDG_AMT}">
								</div>
								<label for="act_plan_cd"
									class="col-md-2 col-form-label text-md-left">제안금액</label>
								<div class="col-md-4">
									<input type="text" id="base_prps_amt" class="form-control"
										name="base_prps_amt" readonly value="${data.BASE_PRPS_AMT}">
								</div>
							</div>
							<div class="form-group row">
								<label for="prps_purpose_cd"
									class="col-md-2 col-form-label text-md-left">최종금액</label>
								<div class="col-md-4">
									<input type="text" id="last_prps_amt" class="form-control"
										name="last_prps_amt" readonly value="${data.LAST_PRPS_AMT}">
								</div>
								<label for="act_plan_cd"
									class="col-md-2 col-form-label text-md-left">CASERATE</label>
								<div class="col-md-4">
									<input type="text" id="caserate_amt" class="form-control"
										name="caserate_amt" readonly value="${data.CASERATE_AMT}">
								</div>
							</div>
							<div class="form-group row">
							<label for="act_plan_cd"
									class="col-md-2 col-form-label text-md-left">제안내역</label>
								<div class="col-md-12">
								<textarea name="prps_cntn" class="summernote">${data.PRPS_CNTN}</textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="float-right">
					<c:if test="${'0001' eq data.PRPS_STUS_CD}">
					<input type="button" class="btn btn-secondary btn-sm" value="수정" onClick="viewStep('${data.PRPS_ID}','01','update')"/>
					</c:if>
					<button type="button" name="goToTop" class="btn btn-secondary btn-sm">TOP</button>
				</div>
			</div>
			<div id="productView" style="padding:10px 0px; overflow-x:auto; width:90%; margin: 0 auto;">
				<div class="title"><b>STEP02. PROPOSAL 제품/지원품목</b></div> 
				<div class="container-fluid border">
					<div class="row" style="padding-top:10px; overflow-x:auto; width:90%;text-align: center; margin: 0 auto;" >
						<table class="table">
						  <thead>
						    <tr>
						      <th scope="col" width="20%">제품명</th>
						      <th scope="col" width="10%">구분</th>
						      <th scope="col" width="15%">출고수량</th>
						      <th scope="col" width="20%">출고단가</th>
						      <th scope="col" width="15%">할인률</th>
						      <th scope="col" width="20%">최종출고금액</th>
						    </tr>
						  </thead>
						  <tbody id="view1">
								<c:forEach items="${ProPosalDList}" var="i" varStatus="status">
									<tr>
										<td>${i.PROD_NO_SITEM_NM}</td>
										<td>${i.PROD_SITEM_DIVS_NM}</td>
										<td>${i.DELIVERY_CNT}</td>
										<td>${i.DELIVERY_AMT}</td>
										<td>${i.DC_RATE}</td>
										<td>${i.LAST_DELIVER_AMT}</td>
								</tr>
								</c:forEach>
						  </tbody>
						</table>
					</div>
				</div>
				<div class="float-right">
				<c:if test="${'0001' eq data.PRPS_STUS_CD}">
					<input type="button" class="btn btn-secondary btn-sm" value="수정" onClick="viewStep('${data.PRPS_ID}','02','update')"/>
					</c:if>
				<button type="button" name="goToTop" class="btn btn-secondary btn-sm float-right">TOP</button>
				</div>		
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

<form name="viewForm" method="post">
	<input type="hidden" name="prps_id"/>
	<input type="hidden" name="gubun"/> 
</form>