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
		
		
		//목록
		$("#proposalList").click(function(){
			location.href="/proPosalList";
		});
		
		
		$("#proPosalForm01_List").click(function(){
			document.viewForm.action="/proPosalForm";
			document.viewForm.submit();
		});
		
		$("#proPosalForm02_List").click(function(){
			document.viewForm.action="/proPosalForm02";
			document.viewForm.submit();
		});
		
		
		function  goStepDetail(prps_id){
			$("#prps_id").val(prps_id);
			document.viewForm.action = "/proPosalView#monthView";
			document.viewForm.submit();
		}
		
		$("#setp03Insert").click(function(){
			if (ajaxFlag)
				return;
			ajaxFlag = true;
			
			var prpsdId = $("input[name='prpsdId']");
			var _addParam = [];
			
			for(var i=0; i<prpsdId.length; i++){
				var idx = prpsdId[i];
				var planCntObj = $("input[name='planCnt'][data-prpsdid='"+idx.value+"']");
				var tCnt = 0;
				var sumCnt = 0;
				for(var j = 0; j<planCntObj.length; j++){
					var planIdx = planCntObj[j];
					if(!Number(planIdx.value) ){
						alert("숫자만 입력 가능 합니다.");
						ajaxFlag=false;
						return;
					}
					if(Number(planIdx.value) < 1){
						alert("출고계획수량은 0이상 입력 해야 합니다.");
						ajaxFlag=false;
						return;
					}
					tCnt = $(planIdx).data("deliverycnt");
					sumCnt = Number(sumCnt) + Number(planIdx.value);
					_addParam.push({"prpsId":$("input[name='prpsId']")[i].value,"prodSitemDivsCd":$("input[name='prodSitemDivsCd']")[i].value,"prodNoSitemNm":$("input[name='prodNoSitemNm']")[i].value,"deliDate":$("input[name='deliDate']")[j].value,"planCnt":planIdx.value});
				}
			
				if(tCnt ==0 && sumCnt == 0 ){
					alert("데이터에 에러가 발생 하였습니다.");
					ajaxFlag=false;
					return;
				}
			}
			
			var prps_id = $("#prps_id").val();
			
			var gubun = $("#gubun").val();
			
			var url = "";
			if (gubun == "") {
				url = "/proposalWork3";
			}else{
				url = "/proposalUpdate3";
				alert("수정 시 기존 데이터 (출고계획/실출고 수량) 는\n삭제 됩니다.");
			}
			
			$.ajax({      
			    type:"POST",  
			    url:url,
			    data: JSON.stringify({"_addPram":_addParam}),
			    dataType:"json",
			    contentType:"application/json;charset=UTF-8",
			    traditional:true,
			    success:function(args){   
			        if(args.returnCode == "0000"){
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	if(args.retgubun == "insert"){
			        		goStepDetail(prps_id);
			        	}else if(args.retgubun == "update"){
			        		goStepDetail(prps_id);
			        	}else{
			        		//alert(0);
			        		
			        	}
			        }else{
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	location.replace("/proPosalList")
			        }
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        if(xhr.status == 403){
			        	alert("로그인이 필요한 메뉴 입니다.");
			        	location.replace("/logIn");
			        }else{
			        	alert("처리중 에러가 발생 하였습니다.");
			        	location.reload();
			        }
			        ajaxFlag=false;
			    }   
			});
			
			
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
			      <th class="border text-center" scope="col" width="60%">제품명(제안수량)</th>
			      <th class="border text-center" scope="col" width="20%">출고월</th>
			      <th class="border text-center" scope="col" width="20%">CASE 출고계획수량</th>
			    </tr>
			  </thead>
			  <tbody>
		  		<c:forEach items="${listStep03}" var="i" varStatus="status">
				  	<tr>
				  		<td class="border">
				  			<c:if test="${i.PROD_SITEM_DIVS_CD eq '01'}">
							    <span>${i.BRAND_NM}&nbsp;${i.SUB_BRAND_NM}&nbsp;${i.PROD_ML_NM}&nbsp;(수량 ${i.CASE9L})</span>
							</c:if>
							<c:if test="${i.PROD_SITEM_DIVS_CD eq '02'}">
							    <span>${i.PROD_NO_SITEM_NM} (수량 ${i.DELIVERY_CNT})</span>
							</c:if>
				  			<input type="hidden" id="prpsdId"name="prpsdId" value="${i.PRPSD_ID}">
				  			<input type="hidden" id="prpsId"name="prpsId" value="${i.PRPS_ID}">
				  			<input type="hidden" id="prodSitemDivsCd"name="prodSitemDivsCd" value="${i.PROD_SITEM_DIVS_CD}">
				  			<input type="hidden" id="prodNoSitemNm"name="prodNoSitemNm" value="${i.PROD_NO_SITEM_NM}">
				  			<input type="hidden" id="deliveryCnt"name="deliveryCnt" value="${i.DELIVERY_CNT}">
				  		</td>
				  		<td class="border">
				  			<c:forEach items="${i.dateList}" var="d">
				  				<input type="text" id="deliDate" class="form-control" name="deliDate" style="margin-bottom:3px;" value="${d.deliDate}" readonly>
				  			</c:forEach>
				  		</td>
				  		<td class="border">
				  			<c:forEach items="${i.dateList}" var="d">
				  				<input type="number" min="0" id="planCnt" class="form-control" name="planCnt" data-prpsdid="${i.PRPSD_ID}" data-deliverycnt="${i.DELIVERY_CNT}" style="margin-bottom:3px;" value="${d.PLAN_DELIVERY_CNT}">
				  			</c:forEach>
				  		</td>
				  	</tr>
				</c:forEach>
			  </tbody>
			 </table>
		</div>
		<div class="row" style="padding: 5px 0px;">
			<div class="col-12 col-sm-9 text-left">
				<input class="btn btn-light" type="button" id="proposalList" value="목록">
				<input class="btn btn-light" type="button" id="proPosalForm01_List" value="STEP01 수정">
				<input class="btn btn-light" type="button" id="proPosalForm02_List" value="STEP02 수정">
			</div>
			<div class="col-12 col-sm-3 text-RIGHT">
				<input type="hidden" name="gubun" id="gubun" value="${gubun}">
				<c:if test="${gubun ne 'update'}">
					<input class="btn btn-light" type="button" id="setp03Insert" value="SETP03 등록">
				</c:if>
				<c:if test="${gubun eq 'update' }">
					<input class="btn btn-light" type="button" id="setp03Insert" value="SETP03 수정">
				</c:if>
			</div>
		</div>
	</div>
</div>

<form name="viewForm" method="post">
	<input type="hidden" name="prps_id" id="prps_id"  value="${prps_id}"/> 
	<input type="hidden" name="gubun" value="${gubun}"/>
</form>
