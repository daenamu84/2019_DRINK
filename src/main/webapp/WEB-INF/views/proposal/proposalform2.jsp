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
		
		
		
		$("#outlet_nm").click(function(){
			$("#popLayer").modal("show");
		});
		
		
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
			
			var url = "/proposalWork";
			
			 $.ajax({      
				    type:"POST",  
				    url:url,      
				    data: JSON.stringify({"prps_nm":prps_nm,"prps_purpose_cd":prps_purpose_cd,"act_plan_cd":act_plan_cd,"prps_str_dt":prps_str_dt,"prps_end_dt":prps_end_dt,"outlet_no":outlet_no,"wholesale_vendor_no":wholesale_vendor_no,"market_divs_cd":market_divs_cd,"vendor_sgmt_divs_cd":vendor_sgmt_divs_cd,"budg_amt":budg_amt,"base_prps_amt":base_prps_amt,"last_prps_amt":last_prps_amt,"caserate_amt":caserate_amt,"prps_cntn":prps_cntn }),
				    dataType:"json",
				    contentType:"application/json;charset=UTF-8",
				    traditional:true,
				    success:function(args){   
				        if(args.returnCode == "0000"){
				        	alert(args.message.replace(/<br>/gi,"\n"));
				        	if(args.retgubun == "insert"){
				        		//location.replace("/memberList");
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
	
 	
	
	</script>
	
	
	<div class="title"> ◈STEP02. PROPOSAL 제품/지원품목 등록</div>
	<div class="container-fluid" >
		<div class="row">
			<div class="col">
				<div class="container-fluid" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<div class="container-fluid" style="padding: 15px;width:90%">제안제품</div>
							<div class="container-fluid border" style="padding: 15px;width:90%">
								<div class="row" style="border-bottom: 1px solid #dee2e6">
								  <div class="col-sm-4">제품명</div>
								  <div class="col-sm-2">출고수량</div>
								  <div class="col-sm-2">출고단가</div>
								  <div class="col-sm-2">할인율</div>
								  <div class="col-sm-2">최종금액</div>
								</div>
								<div class="row">
									<div class="form-group row">
	                                	<div class="col-md-8">
	                                    	<input type="text" id="prps_nm" class="form-control" name="prps_nm" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.PRPS_NM}">
	                                    </div>
	                                </div>
                                </div>
                             </div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
	
