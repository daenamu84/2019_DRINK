<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>

<style>
.reserve_date{margin-top:50px; margin-bottom:50px;}
.reserve_date:after{display:block; content:''; clear:both;}
.reserve_date > div{width:100%; box-sizing:border-box; float:left;}
.reserve_date .reserve_left{padding-right:15px;}
.reserve_date .reserve_right{padding-top:41px;}
.reserve_date .calendar{position:relative;text-align:center;}
.reserve_date .calendar .calendar_date span{font-size:24px; color:#222; font-weight:bold;}
.reserve_date .calendar .calendar_date a{font-size:0; position:absolute; width:26px; height:26px; display:block; top:1px;}
.reserve_date .calendar .calendar_date a.prev{background:url(/images/sub/calendar_left.png) left center no-repeat;left:110px;}
.reserve_date .calendar .calendar_date a.next{background:url(/images/sub/calendar_right.png) left center no-repeat;right:110px;}
.reserve_date .calendar table{margin-top:15px; border-collapse:collapse; border-spacing:0; table-layout:fixed; border-top:1px solid #414141;  width:100%;}
.reserve_date .calendar table tr th{text-align:center; color:#222; font-size:16px; font-weight:bold; padding:20px 0; border-bottom:1px solid #343a40 ;}
.reserve_date .calendar table tr td{font-size:16px; text-align:center; color:#aaa; padding:25px 0;}
.reserve_date .calendar table tr td b{display:block; font-size:14px; color:#2337d2;}
.reserve_date .calendar table tr td span{display:inline-block; width:50px; height:50px; line-height:50px;}
.reserve_date .calendar table tr td span.impossible{background:url(/images/sub/impossible.png) left center no-repeat;}
.reserve_date .calendar table tr td span.deadline{background:url(/images/sub/deadline.png) left center no-repeat;}
.reserve_date .calendar table tr td span.possible{background:url(/images/sub/possible.png) left center no-repeat; color:#666;}
.reserve_date .calendar table tr td span.date_select{background:url(/images/sub/reserve_select.png) left center no-repeat; color:#fff;}
.reserve_date .calendar table tr:last-child{border-bottom:1px solid #ddd;}
.reserve_date .calendar table tr td{font-size:14px; padding:0px 0;}
.reserve_date .calendar table tr td b{font-size:13px;}
.reserve_date .calendar table tr td span{width:40px; height:40px; line-height:40px;}
.reserve_date .calendar table tr td span.impossible{background-size:40px;}
.reserve_date .calendar table tr td span.deadline{background-size:40px;}
.reserve_date .calendar table tr td span.possible{background-size:40px;}
.reserve_date .calendar table tr td span.date_select{background-size:40px;}
</style>
<script src="${pageContext.request.contextPath}/resources/js/common/bootstrap-datepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common/bootstrap-datepicker.kr.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap/bootstrap-datepicker3.min.css" rel="stylesheet">
<script>
var ajaxFlag = false;

	$(function() {
		/* dataRangeOptions.locale.format="YYYYMM";
		dataRangeOptions.singleDatePicker =  true;
		dataRangeOptions.autoUpdateInput = true;
			
		$("._pDateRange").daterangepicker(dataRangeOptions);
		$('._pDateRange').on('apply.daterangepicker', function(ev, picker) {
			$(this).val(picker.endDate.format('YYYYMM'));
		}); */
		
		$('._pDateRange').datepicker({
			 startView: 1,
			    minViewMode: 1,
			    maxViewMode: 2,
			    language: "kr",
			    format: "yyyymm",
			    autoclose: true
		     });
		
		$("i[name='_pDateRangeIcon']").click(function (){
			$('._pDateRange').datepicker("show");
		}); 
	});
	
	$(document).ready(function(){
		$("#deptno").trigger("change");
		

		$("#prodSearch").click(function (){
			if (ajaxFlag)
				return;
			ajaxFlag = true;
			
			var deptNo = $("#deptno").val();
			if(deptNo =="" || deptNo == undefined){
				alert("팀을 선택하세요");
				ajaxFlag = false;
				return;
			}
			var empNo = $("#empno").val();
			if(empNo =="" || empNo == undefined){
				alert("팀원을 선택하세요");
				ajaxFlag = false;
				return;
			}
			var _pStaDt = $("#_pStaDt").val();
			if(_pStaDt =="" || _pStaDt == undefined){
				alert("월을 선택하세요");
				ajaxFlag = false;
				return;
			}
			
			$.ajax({
				type : "POST",
				url : "/callCalendarView",
				data : {
					"deptNo" : deptNo,
					"empNo" : empNo,
					"_pStaDt" : _pStaDt
				},
				dataType : "html",
				traditional : true,
				success : function(args) {
					$("#viewCalendar").empty();
					$("#viewCalendar").html(args);
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
		});
	});
	
	function getTeamList() {
		if (ajaxFlag)
			return;
		ajaxFlag = true;
		var deptno = "";
		var gubun = "search";
		
		deptno = $("#deptno option:selected").val();
		
		var empno = '${emp_no}';
		
		$.ajax({
			type : "POST",
			url : "/Dept_EmpList",
			data : {
				"deptno" : deptno,
				"gubun" : gubun,
				"empno" : empno
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
	
function callView(scall_no){
		
		var _scall_no = scall_no;
		
		if(ajaxFlag)return;
		ajaxFlag=true;
		$("#subLayer").empty();
		$("#popLayer").modal("show");
		
		$.ajax({      
		    type:"GET",  
		    url:"/callView?scall_no="+scall_no,      
		    dataType:"html",
		    traditional:true,
		    success:function(args){   
		    	$("#subLayer").html(args);
		        ajaxFlag=false;
		    },   
		    error:function(xhr, status, e){  
		        ajaxFlag=false;
		    }  
		});
		
	}
	
$(document).on("click","#callupdate", function(){
	if (ajaxFlag)
		return;
	ajaxFlag = true;
	
	var scall_no  			= $("#scall_no").val();
	var scall_purpose_cd_u 	= $("#scall_purpose_cd_u option:selected").val();
	var scall_pfr_nm_u		= $("#scall_pfr_nm_u option:selected").val();
	var scall_rslt_cd_u		= $("#scall_rslt_cd_u option:selected").val();
	var scall_sale_cntn_u = $("#scall_sale_cntn_u").val();
	var scall_cprt_cntn_u = $("#scall_cprt_cntn_u").val();
	
	$.ajax({      
	    type:"POST",  
	    url:"/callUpdate",      
	    data: JSON.stringify({"scall_no":scall_no,"scall_purpose_cd_u":scall_purpose_cd_u,"scall_pfr_nm_u":scall_pfr_nm_u,"scall_rslt_cd_u":scall_rslt_cd_u,"scall_sale_cntn_u" :scall_sale_cntn_u,"scall_cprt_cntn_u" :scall_cprt_cntn_u  }),
	    dataType:"json",
	    contentType:"application/json;charset=UTF-8",
	    traditional:true,
	    success:function(args){   
	        if(args.returnCode == "0000"){
	        	alert(args.message.replace(/<br>/gi,"\n"));
	        	//location.reload();
	        	$("#popLayer").modal("hide");
	        }else{
	        	alert(args.message.replace(/<br>/gi,"\n"));
	        	//location.reload();
	        	$("#popLayer").modal("hide");
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

$(document).on("click","#callviewdelete", function(){
	if (ajaxFlag)
		return;
	ajaxFlag = true;
	
	var scall_no  			= $("#scall_no").val();
	$.ajax({      
	    type:"POST",  
	    url:"/callviewdelete",      
	    data: JSON.stringify({"scall_no":scall_no }),
	    dataType:"json",
	    contentType:"application/json;charset=UTF-8",
	    traditional:true,
	    success:function(args){   
	        if(args.returnCode == "0000"){
	        	alert(args.message.replace(/<br>/gi,"\n"));
	        	//location.reload();
	        	$("#popLayer").modal("hide");
	        }else{
	        	alert(args.message.replace(/<br>/gi,"\n"));
	        	//location.reload();
	        	$("#popLayer").modal("hide");
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
	
function passCallList(){
	
	location.href="/callList";
//	location.href="/callList?scallStaDt=&scallEndDt=";
}
	
</script>

<div class="">
	<div class="title"> ◈  Call Calendar</div> 
	<div class="container-fluid">
		<div class="row">			
			<div class="col">
				<div class="container border" style="padding: 5px;">
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">팀</span></div>
						<div class="col-12 col-sm-2">
							<select name="deptno" class="form-control" id="deptno" onchange="getTeamList();">
								<c:forEach items="${deptMngList}" var="a">
								<option value="${a.DEPT_NO}" <c:if test="${a.DEPT_NO eq data.DEPT_NO or a.DEPT_NO eq deptno}">selected</c:if>>${a.TEAMNM} </option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-sm-2"><span class="align-middle"><font color="red">*</font> 팀원</span></div>
						<div class="col-12 col-sm-6">
                             <div class="col-md-6" id="empList">
                             </div>
						</div>
					</div>
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">월</span></div>
						<div class="col-12 col-sm-3">
							<input type="text" class="_pDateRange form-control bg-white" id="_pStaDt" value="" style="width: 90%;display: inline-block;" readonly autocomplete="off"/><i name="_pDateRangeIcon" class="fas fa-calendar-alt"></i>
						</div>
						<div class="col-12 col-sm-7">
							<input class="btn btn-primary" type="button" id="prodSearch" value="조회">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px; overflow-x:auto;">	
			<div class="reserve_date">
				<div class="reserve_left" style="min-width:1024px;">
					<div class="calendar" id="viewCalendar">
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="popLayer" class="modal fade" role="dialog" >
		<div class="modal-dialog modal-xl" style="max-width: 1540px">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-body" id="subLayer">
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	
</div>