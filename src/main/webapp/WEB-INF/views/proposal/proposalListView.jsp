<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<link type="text/css" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />


<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
var nowUrl = "/proPosalList";
	$(document).on("click","i[name='dateRangeIcon']",function() {
	    $(this).parent().find("._pDateRange").click();
	});
	
	//자동완성
	$(function(){

	//  var source = ['난누군가','또여긴어딘가','누가날불러?'];
    // 자동으로 /ajax/auato 주소로 term 이란 파라미터가 전송된다.
    // 응답은 [{label:~~~,value:~~~},{label:~~~,value:~~~}] 형태가 된다.
<%--    $('#term').autocomplete({"source":"<%=cp%>/ajax/auto"}); --%>
	    $('.temp').autocomplete({
	    	"source":function(request,response){
	    		console.log(request);
	           	$.getJSON("/vendorAuto",{"term":request.term},
	                function(result) {
	                	return response($.map(result, function(item){
	                    	var l = item.label.replace(request.term, request.term);
	                        return {label:l, code:item.value, value:item.code};
	                                  //return {label:l, value:item.label};
					}));
	          	});
	    },
	    select: function(event, ui) {
            console.log(ui.item);
            var id_check = $(this).attr("id");
            console.log(id_check);
            //$("#vendor_nm1").val(ui.item.label);
            $("#outlet_no").val(ui.item.code);
        }},
	  
	    $('.temp')[0]);
	});
	var ajaxFlag = false;

	//달력
	$(function() {
		dataRangeOptions.locale.format="YYYYMMDD";
		dataRangeOptions.singleDatePicker =  true;
		dataRangeOptions.autoUpdateInput = false;
			
		$("._pDateRange").daterangepicker(dataRangeOptions);
		$('._pDateRange').on('apply.daterangepicker', function(ev, picker) {
			$(this).val(picker.endDate.format('YYYYMMDD'));
		});
	});		

	$(document).ready(function(){
		//검색
		$("#proposalSearch").click(function(){
			var outlet_no = $("#outlet_no").val();
			var deptno = $("#deptno option:selected").val();
			var empno = $("#empno").val();
			var temp = $("#empno option:selected").val();
			
			 if(typeof temp == "undefined"){
				 temp = "";
			 } 
			var prps_purpose_cd = $("#prps_purpose_cd option:selected").val();
			var act_plan_cd = $("#act_plan_cd option:selected").val();
			var prsp_status = $("#prsp_status option:selected").val();
			 
			var prps_str_dt = $("#prps_str_dt").val();
			var prps_end_dt = $("#prps_end_dt").val();
			
			var market_divs_cd = $("#market_divs_cd option:selected").val();
			var vendor_sgmt_divs_cd = $("#vendor_sgmt_divs_cd option:selected").val();
			
			if(ajaxFlag)return;
			ajaxFlag=true;
			$.ajax({      
			    type:"GET",  
			    url:"/proPosalListSearch?deptno="+deptno+"&empno="+temp+"&outlet_no="+outlet_no+"&prps_str_dt="+prps_str_dt+"&prps_end_dt="+prps_end_dt+"&prps_purpose_cd="+prps_purpose_cd+"&act_plan_cd="+act_plan_cd+"&prsp_status="+prsp_status+"&market_divs_cd="+market_divs_cd+"&vendor_sgmt_divs_cd="+vendor_sgmt_divs_cd,     
			    dataType:"html",
			    traditional:true,
			    success:function(args){   
			    	$("#proposalList").html(args);
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    }  
			});
		});
		
		//등록 
		$("#proposalInsert").click(function(){
			location.href="/proPosalForm";
		});
		
		$("#proposalClean").click(function(){
			
			$("#vendor_nm").val("");
			$("#outlet_no").val("");
			$("#deptno option:eq(0)").prop("selected", true);
			$("#prps_purpose_cd option:eq(0)").prop("selected", true);
			$("#prsp_status option:eq(0)").prop("selected", true);
			$("#prps_str_dt").val("");
			$("#prps_end_dt").val("");
			
		});
	});
	
	
	
	function getTeamList() {
		if (ajaxFlag)
			return;
		ajaxFlag = true;
		var deptno = "";
		var gubun = "search";
		
		deptno = $("#deptno option:selected").val();
		
		$.ajax({
			type : "POST",
			url : "/Dept_EmpList",
			data : {
				"deptno" : deptno,
				"gubun" : gubun,
				"empno" : '${data.EMP_NO}'
			},
			dataType : "html",
			traditional : true,
			success : function(args) {
				$("#empList").empty();
				$("#empList").html(args);
				ajaxFlag = false;
			},
			error : function(xhr, status, e) {
				if (xhr.status == 403) {
					alert("로그인이 필요한 메뉴 입니다.");
					location.replace("/logIn");
				} else {
					alert("처리중 에러가 발생 하였습니다.");
					location.reload();
				}
				ajaxFlag = false;
			}
		});
	}
	
	function setView(prps_id, gubun){
		document.viewForm.prps_id.value=prps_id;
		document.viewForm.gubun.value=gubun;
		
		document.viewForm.action="/proPosalView";
		document.viewForm.submit();
	}
	
	function getSegment() {
		if (ajaxFlag)
			return;
		ajaxFlag = true;
		var market_divs_cd = "";
		
		market_divs_cd = $("#market_divs_cd option:selected").val();
		var gubun="list";
		$.ajax({
			type : "POST",
			url : "/VendorSegList",
			data : {"market_divs_cd" : market_divs_cd, "gubun" : gubun},
			dataType : "html",
			traditional : true,
			success : function(args) {
				$("#segList").empty();
				$("#segList").html(args);
				ajaxFlag = false;
			},
			error : function(xhr, status, e) {
				if (xhr.status == 403) {
					alert("로그인이 필요한 메뉴 입니다.");
					location.replace("/logIn");
				} else {
					alert("처리중 에러가 발생 하였습니다.");
					location.reload();
				}
				ajaxFlag = false;
			}
		});
	}
	
	
</script>

<div class="">
	<div class="title"> ◈  PROPOSAL</div> 
	<div class="container-fluid">
		<div class="row">			
			<div class="col">
				<div class="container border" style="padding: 5px;">
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">거래처명</span></div>
						<div class="col-12 col-sm-2">
							<input type="text" class="form-control temp" name="vendor_nm" id="vendor_nm">
							<input type="hidden" class="form-control" name="outlet_no" id="outlet_no">
						</div>
						<div class="col-12 col-sm-2"><span class="align-middle">팀</span></div>
						<div class="col-12 col-sm-2">
							<select name="deptno" class="form-control" id="deptno" onchange="getTeamList();">
								<option value="ALL">전체</option>
								<c:forEach items="${deptList}" var="a">
									<option value="${a.DEPT_NO}">${a.TEAMNM} </option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-sm-2"><span class="align-middle">담당자</span></div>
						<div class="col-12 col-sm-2" id="empList">
							
						</div>
					</div>
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2">엑티비티계획</div>
						<div class="col-12 col-sm-2">
							<select class="custom-select" name="act_plan_cd" id="act_plan_cd">
									<option value="ALL">전체</option>
									<c:forEach items="${cd00022List}" var="b">
										<option value="${b.CMM_CD}">${b.CMM_CD_NM} </option>
									</c:forEach>
						  </select>
						</div>
						<div class="col-12 col-sm-2">제안상태</div>
						<div class="col-12 col-sm-2">
							<select class="custom-select" name="prsp_status" id="prsp_status">
								<option value="ALL">전체</option>
								<c:forEach items="${cd00020List}" var="b">
									<option value="${b.CMM_CD}">${b.CMM_CD_NM}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2">Market</div>
						<div class="col-12 col-sm-2">
							<select name="market_divs_cd" class="form-control" id="market_divs_cd"  onchange="getSegment();">
								<option value="ALL">전체</option>
								<c:forEach items="${marketMap}" var="b">
									<option value="${b.CMM_CD}">${b.CMM_CD_NM} </option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-sm-2">Segmentation</div>
						<div class="col-12 col-sm-2" id="segList">
							<select name="vendor_sgmt_divs_cd" class="form-control" id="vendor_sgmt_divs_cd">
						  		<option value="ALL">전체</option>
							</select>
						</div>
					</div>
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">기간</span></div>
						<div class="col-12 col-sm-3">
							<input type="text" class="_pDateRange form-control bg-white" id="prps_str_dt" value="" style="width: 90%;display: inline-block;" readonly autocomplete="off"/><i name="dateRangeIcon" class="fas fa-calendar-alt"></i>
						</div>
						<div class="col-12 col-sm-1">~</div>
						<div class="col-12 col-sm-3">
							<input type="text" class="_pDateRange form-control bg-white" id="prps_end_dt" value="" style="width: 90%;display: inline-block;" readonly autocomplete="off"/><i name="dateRangeIcon" class="fas fa-calendar-alt"></i>
						</div>
					</div>
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-6 text-left">
							<input class="btn btn-primary" type="button" id="proposalInsert" value="PROPOSAL 등록">
						</div>
						<div class="col-12 col-sm-6 text-right">
							<input class="btn btn-primary" type="button" id="proposalClean" value="초기화">
							<input class="btn btn-primary" type="button" id="proposalSearch" value="조회">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px; overflow-x:auto;">	
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">제안ID</th>
			      <th scope="col">담당팀</th>
			      <th scope="col">담당자</th>
			      <th scope="col">제안기간</th>
			      <th scope="col">제안명</th>
			      <th scope="col">거래처명</th>
			      <th scope="col">엑티비티계획</th>
			      <th scope="col">제안상태</th>
			    </tr>
			  </thead>
			  <tbody id="proposalList">
					<c:forEach items="${ProPosalList}" var="i" varStatus="status">
						<tr>
							<td><a href="javascript:setView('${i.PRPS_ID}','update')">${i.PRPS_ID}</a> </td>
							<td>${i.TEAMNM}</td>
							<td>${i.EMP_NM}</td>
							<td>${i.PRPS_STR_DT}~${i.PRPS_END_DT}</td>
							<td><a href="javascript:setView('${i.PRPS_ID}','update')">${i.PRPS_NM}</a></td>
							<td>${i.VD_NM}</td>
							<td>${i.ACT_PLAN_CD_NM}</td>
							<td>${i.PRPS_STUS_CD_NM}</td>							
						</tr>
					</c:forEach>
					<tr>
						<td colspan="9">
							<div class="col-xs-3">
								<paging:paging var="skw3" currentPageNo="${paging.page}"
									recordsPerPage="${paging.pageLine}"
									numberOfRecords="${paging.totalCnt}" jsFunc="goPage" />
								${skw3.printBtPaging()}
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<form name="viewForm" method="post">
	<input type="hidden" name="prps_id" /> 
	<input type="hidden" name="gubun" />
</form>

<script>
		function goPage(pages, pageLine) {
			var url = nowUrl;
			if (url.indexOf('?') > -1) {
				url += "&";
			} else {
				url += "?";
			}
			url += "page=" + pages + "&pageLine=" + pageLine + "&deptno="
					+ $("#deptno option:selected").val();
			location.href = url;
		}
		
		function goPageSub(pages, pageLine) {
			var outlet_no = $("#outlet_no").val();
			var deptno = $("#deptno option:selected").val();
			var empno = $("#empno").val();
			var temp = $("#empno option:selected").val();
			
			 if(typeof temp == "undefined"){
				 temp = "";
			 } 
			var prps_purpose_cd = $("#prps_purpose_cd option:selected").val();
			var act_plan_cd = $("#act_plan_cd option:selected").val();
			var prsp_status = $("#prsp_status option:selected").val();
			 
			var prps_str_dt = $("#prps_str_dt").val();
			var prps_end_dt = $("#prps_end_dt").val();
			
			var market_divs_cd = $("#market_divs_cd option:selected").val();
			var vendor_sgmt_divs_cd = $("#vendor_sgmt_divs_cd option:selected").val();
			
			if(ajaxFlag)return;
			ajaxFlag=true;
			$.ajax({      
			    type:"GET",  
			    url:"/proPosalListSearch?deptno="+deptno+"&empno="+temp+"&outlet_no="+outlet_no+"&prps_str_dt="+prps_str_dt+"&prps_end_dt="+prps_end_dt+"&prps_purpose_cd="+prps_purpose_cd+"&act_plan_cd="+act_plan_cd+"&prsp_status="+prsp_status+"&market_divs_cd="+market_divs_cd+"&vendor_sgmt_divs_cd="+vendor_sgmt_divs_cd+"&page=" + pages + "&pageLine=" + pageLine,     
			    dataType:"html",
			    traditional:true,
			    success:function(args){   
			    	$("#proposalList").html(args);
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    }  
			});
		}
	</script>
