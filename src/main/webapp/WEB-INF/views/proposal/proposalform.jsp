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
		
		$('.summernote').summernote({
			height: 400,
			toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    ['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['color', ['color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']]
			  ]
			
		});
		
		$(document).on("click","i[name='dateRangeIcon']",function() {
		      $(this).parent().find(".dateRange").click();
		});
		
		$("#outlet_nm").click(function(){
			$("#popLayer").modal("show");
		});
		
		$("#proPosalList").click(function(){
			location.href="/proPosalList";
		});
		
		
		$("#proPosalView").click(function(){
			document.viewForm.action="/proPosalView";
			document.viewForm.submit();
		});
		
		
		
		function  goStep02(prps_id){
			$("#prps_id").val(prps_id);
			document.insert02.action = "/proPosalForm02";
			document.insert02.submit();
		}
		
		$("#saveWork").click(function(){			
			if(ajaxFlag)return;
			
			var prps_nm = $("#prps_nm").val();
			if(prps_nm==""){
				alert("제안명을 입력하세요");
				ajaxFlag = false;
				return;
			}
			
			
			if ($("#prps_purpose_cd option:selected").val() == "") {
				alert("제안목적을  선택 하세요");
				ajaxFlag = false;
				return;
			}
			
			var prps_purpose_cd = $("#prps_purpose_cd option:selected").val() ;
			
			
			var prps_stus_cd = "";
			<c:if test="${loginSession.emp_grd_cd ne '0001'}">
			prps_stus_cd = $("#prps_stus_cd").val();
			</c:if>
			<c:if test="${loginSession.emp_grd_cd eq '0001'}">
			prps_stus_cd = $("#prps_stus_cd option:selected").val() ;
			</c:if>
			
			
			if ($("#act_plan_cd option:selected").val() == "") {
				alert("액티비티계획을  선택 하세요");
				ajaxFlag = false;
				return;
			}
			
			var act_plan_cd = $("#act_plan_cd option:selected").val() ;
			
			var prps_str_dt = $('input[name=prps_str_dt]').val();
			if (prps_str_dt == "") {
				alert("프로모션시작일자을  입력하세요");
				ajaxFlag = false;
				return;
			}
			
			var prps_end_dt = $('input[name=prps_end_dt]').val();
			if (prps_end_dt == "") {
				alert("프로모션종료일자을  입력하세요");
				ajaxFlag = false;
				return;
			}
			
			var outlet_no = $('input[name=outlet_no]').val();
			if (outlet_no == "") {
				alert("거래처를   입력하세요");
				ajaxFlag = false;
				return;
			}
			
			var outlet_no = $("#outlet_no").val();
			var wholesale_vendor_no = $("#wholesale_vendor_no").val();
			var market_divs_cd = $("#market_divs_cd").val();
			var vendor_sgmt_divs_cd = $("#vendor_sgmt_divs_cd").val();
			
			var budg_amt = $("#budg_amt").val();
			var base_prps_amt = $("#base_prps_amt").val();
			var last_prps_amt = $("#last_prps_amt").val();
			if (last_prps_amt == "") {
				alert("최종제안금액  입력하세요");
				ajaxFlag = false;
				return;
			}
			
			var caserate_amt = $("#caserate_amt").val();
			
			$('textarea[name="prps_cntn"]').html($('.summernote').summernote("code"));
			
			var prps_cntn = $('textarea[name="prps_cntn"]').html();
			
			var gubun = $("#gubun").val();

			var url = "";
			if (gubun == "") {
				url = "/proposalWork";
			}else{
				url = "/proposalUpdate";
			}
			
			var prps_id = $("#prps_id").val();
			
			 $.ajax({      
				    type:"POST",  
				    url:url,      
				    data: JSON.stringify({"prps_id":prps_id, "prps_stus_cd":prps_stus_cd, "prps_nm":prps_nm,"prps_purpose_cd":prps_purpose_cd,"act_plan_cd":act_plan_cd,"prps_str_dt":prps_str_dt,"prps_end_dt":prps_end_dt,"outlet_no":outlet_no,"wholesale_vendor_no":wholesale_vendor_no,"market_divs_cd":market_divs_cd,"vendor_sgmt_divs_cd":vendor_sgmt_divs_cd,"budg_amt":budg_amt,"base_prps_amt":base_prps_amt,"last_prps_amt":last_prps_amt,"caserate_amt":caserate_amt,"prps_cntn":prps_cntn }),
				    dataType:"json",
				    contentType:"application/json;charset=UTF-8",
				    traditional:true,
				    success:function(args){   
				        if(args.returnCode == "0000"){
				        	alert(args.message.replace(/<br>/gi,"\n"));
				        	if(args.retgubun == "insert"){
				        		goStep02(args.prps_id);
				        		//location.replace("/proPosalForm02");
				        	}else if(args.retgubun == "update"){
				        		goStep02(prps_id);
				        		//document.viewForm.action="/proPosalView#defultView";
				    			//document.viewForm.submit();
				        		
				        	}else{
				        		//alert(0);
				        		//ViewMember(emp_no,args.retgubun);	
				        	}
				        }else{
				        	alert(args.message.replace(/<br>/gi,"\n"));
				        	if(args.retgubun == "insert"){
				        		location.replace("/memberList");
				        	}else{
				        		//alert(1);
				        		//ViewMember(emp_no,args.retgubun);	
				        	}
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
		
		
		
		
	});
	
 	function setVendorId(outlet_no, outlet_nm, wholesale_vendor_no,market_divs_cd,vendor_sgmt_divs_cd){
		$("#outlet_no").val(outlet_no);
		$("#outlet_nm").val(outlet_nm);
		$("#wholesale_vendor_no").val(wholesale_vendor_no);
		$("#market_divs_cd").val(market_divs_cd);
		$("#vendor_sgmt_divs_cd").val(vendor_sgmt_divs_cd);
		$("#popLayer").modal("hide");

	}
	
	</script>
	
	
	<div class="title"> ◈ STEP01. PROPOSAL 기본정보</div>
	<div class="container-fluid" >
		<div class="row">
			<div class="col">
				<div class="container-fluid" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<div class="container-fluid border" style="padding: 15px;">
								<form name="Form"   method="post">
                                 <div class="form-group row">
                                 	
	                                    <label for="prps_nm" class="col-md-2 col-form-label text-md-left">제안명</label>
	                                    <div class="col-md-4">
	                                    	<input type="text" id="prps_nm" class="form-control" name="prps_nm"   value="${data.PRPS_NM}">
	                                    </div>
                                        <label for="prps_nm" class="col-md-2 col-form-label text-md-left">결제상태</label>
	                                    <div class="col-md-4">
										<c:if test="${loginSession.emp_grd_cd ne '0001'}">
											<input type="hidden" id="prps_stus_cd" class="form-control" name="prps_stus_cd" value="${data.PRPS_STUS_CD}">
											${data.PRPS_STUS_CD_NM}
										</c:if>
										<c:if test="${loginSession.emp_grd_cd eq '0001'}">
											<select name="prps_stus_cd" class="form-control" id="prps_stus_cd">
												<option value="">선택하세요</option>
												<c:forEach items="${p_stusList}" var="a">
													<option value="${a.CMM_CD}"
														<c:if test="${a.CMM_CD eq data.PRPS_STUS_CD}">selected</c:if>>${a.CMM_CD_NM}
													</option>
												</c:forEach>
											</select>
										</c:if>
									</div>
                                	
                                </div>
                                <div class="form-group row">
                                    <label for="prps_purpose_cd" class="col-md-2 col-form-label text-md-left">제안목적</label>
                                    <div class="col-md-4">
                                    	<select name="prps_purpose_cd" class="form-control" id="prps_purpose_cd">
                                    		<option value="">선택하세요</option>
											<c:forEach items="${p_purposeList}" var="a">
											<option value="${a.CMM_CD}" <c:if test="${a.CMM_CD eq data.PRPS_PURPOSE_CD}">selected</c:if>>${a.CMM_CD_NM} </option>
											</c:forEach>
										</select>
                                    </div>
                                    <label for="act_plan_cd" class="col-md-2 col-form-label text-md-left">액티비티계획</label>
                                    <div class="col-md-4">
                                    	<select name="act_plan_cd" class="form-control" id="act_plan_cd">
                                    		<option value="">선택하세요</option>
											<c:forEach items="${p_activityList}" var="b">
											<option value="${b.CMM_CD}" <c:if test="${b.CMM_CD eq data.ACT_PLAN_CD}">selected</c:if>>${b.CMM_CD_NM} </option>
											</c:forEach>
										</select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="prps_purpose_cd" class="col-md-2 col-form-label text-md-left">제안기간</label>
                                    <div class="col-md-4">
                                    	<div style="float:left"><input type="text" class="dateRange" name="prps_str_dt" id="prps_str_dt" value="${data.PRPS_STR_DT}" autocomplete="off"/><i name="dateRangeIcon" class="fas fa-calendar-alt"></i>~</div>
                                    	<div ><input type="text" class="dateRange" name="prps_end_dt" id="prps_end_dt" value="${data.PRPS_END_DT}" autocomplete="off"/><i name="dateRangeIcon" class="fas fa-calendar-alt"></i></div>
                                    </div>
                                    <label for="act_plan_cd" class="col-md-2 col-form-label text-md-left">거래처</label>
                                    <div class="col-md-4">
                                    	<input type="text" id="outlet_nm" class="form-control" name="outlet_nm" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.VD_NM}">
                                    	<input type="hidden" id="outlet_no"  name="outlet_no" value="${data.OUTLET_NO}"/>
                                    	<input type="hidden" id="wholesale_vendor_no"  name="wholesale_vendor_no" value="${data.WHOLESALE_VENDOR_NO}"/>
                                    	<input type="hidden" id="market_divs_cd"  name="market_divs_cd" value="${data.MARKET_DIVS_CD}"/>
                                    	<input type="hidden" id="vendor_sgmt_divs_cd"  name="vendor_sgmt_divs_cd" value="${data.VENDOR_SGMT_DIVS_CD}"/>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="prps_purpose_cd" class="col-md-2 col-form-label text-md-left">예산금액</label>
                                    <div class="col-md-4">
                                    	<input type="text" id="budg_amt" class="form-control" name="budg_amt"   value="${data.BUDG_AMT}">
                                    </div>
                                    <label for="act_plan_cd" class="col-md-2 col-form-label text-md-left">제안금액</label>
                                    <div class="col-md-4">
                                    	<input type="text" id="base_prps_amt" class="form-control" name="base_prps_amt"  value="${data.BASE_PRPS_AMT}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="prps_purpose_cd" class="col-md-2 col-form-label text-md-left">최종금액</label>
                                    <div class="col-md-4">
                                    	<input type="text" id="last_prps_amt" class="form-control" name="last_prps_amt"   value="${data.LAST_PRPS_AMT}">
                                    </div>
                                    <label for="act_plan_cd" class="col-md-2 col-form-label text-md-left">CASERATE</label>
                                    <div class="col-md-4">
                                    	<input type="text" id="caserate_amt" class="form-control" name="caserate_amt"   value="${data.CASERATE_AMT}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-md-12">
                                    	<textarea name="prps_cntn" class="summernote">${data.PRPS_CNTN}</textarea>
                                    </div>
                                </div>
                                <div class="text-md-left">
										<c:if test="${gubun ne 'update'}">
										<input class="btn btn-dark" type="button" value="목록" id="proPosalList">
										</c:if>
										<c:if test="${gubun eq 'update' }">
										<input class="btn btn-dark" type="button" value="목록" id="proPosalView" >
										</c:if>
                                </div>
								<div class="text-md-right">
										<input type="hidden" name="gubun" id="gubun" value="${gubun}">
										<c:if test="${gubun ne 'update'}">
										<input class="btn btn-dark" type="button" value="STEP02 등록" id="saveWork">
										</c:if>
										<c:if test="${gubun eq 'update' }">
										<input class="btn btn-dark" type="button" value="STEP01 수정" id="saveWork">
										</c:if>
                                </div>
								</form>
                             </div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- modal start  -->	
	<div id="popLayer" class="modal fade" role="dialog">
		<div class="modal-dialog modal-xl">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">거래처 조회</h5>
					<a href="#" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
				</div>
				<div class="modal-body">
					<div class="container" style="padding: 5px;">
						<div class="row">
							<div class="col-sm-2"><span class="align-middle">업소</span></div>
							<div class="col-sm-3">
								<input type="text"  id="_sVendorNm" class="form-control" />
							</div>
							<div class="col-sm-5">
								<input class="btn btn-primary" type="button" id="vendorSearch" value="조회">
							</div>
						</div>
					</div>
				</div>					
				<div class="modal-body" id="subLayer">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">거래처 번호</th>
								<th scope="col">거래처명</th>
							</tr>
						</thead>
						<tbody id="vendorSeachLayer">
							<c:forEach items="${vendorList}" var="i" varStatus="status">
								<tr>
									<td><a
										href="javascript:setVendorId('${i.VENDOR_NO}','${i.OUTLET_NM}','${i.WHOLESALE_VENDOR_NO}','${i.MARKET_DIVS_CD}','${i.VENDOR_SGMT_DIVS_CD}');" class="text-decoration-none">${i.VENDOR_NO}</a></td>
									<td><a
										href="javascript:setVendorId('${i.VENDOR_NO}','${i.OUTLET_NM}','${i.WHOLESALE_VENDOR_NO}','${i.MARKET_DIVS_CD}','${i.VENDOR_SGMT_DIVS_CD}');" class="text-decoration-none">${i.OUTLET_NM}</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<input class="btn btn-secondary float-right" type="button" data-dismiss="modal" value="Close">
				</div>
			</div>
		</div>
	</div>
<!-- modal  end  -->
	</div>
	

    <script>
//조회화면에 추가 하자 
$(function() {
	dataRangeOptions.singleDatePicker =  true;
	dataRangeOptions.autoUpdateInput = false;
	dataRangeOptions.locale.format = 'YYYYMMDD';
	
	$(".dateRange").daterangepicker(dataRangeOptions);
	$('.dateRange').on('apply.daterangepicker', function(ev, picker) {
		$(this).val(picker.endDate.format('YYYYMMDD'));
	});
	
});
</script>

<form name="insert02" method="post">
	<input type="hidden" name="prps_id" id="prps_id" value="${data.PRPS_ID}"/>
	<input type="hidden" name="gubun" value="${gubun}"/>
</form>

<form name="viewForm" method="post">
	<input type="hidden" name="prps_id"  value="${data.PRPS_ID}"/> 
	<input type="hidden" name="gubun" value="${gubun}"/>
</form>