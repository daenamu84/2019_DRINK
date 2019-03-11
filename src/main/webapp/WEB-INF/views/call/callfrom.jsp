<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<link type="text/css" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />


<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
<script type="text/javascript">
	
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
            //$("#outlet_nm1").val(ui.item.label);
            $("#vendor_no"+id_check).val(ui.item.code);
        }},
	  
	    $('.temp')[0]);
	});


	
	var ajaxFlag = false;
	$(document).on("click","i[name='dateRangeIcon']",function() {
	      $(this).parent().find(".dateRange").click();
	});
	
	var ajaxFlag = false;
	// 한글입력막기 스크립트
	$( function(){
		$("#login_id" ).on("blur keyup", function() {
			$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
		});
	})
	
	function getTeamList() {
		if (ajaxFlag)
			return;
		ajaxFlag = true;
		var deptno = "";
		var gubun = "<%=request.getParameter("gubun")%>";
		
		deptno = $("#deptno option:selected").val();
		
		var empno = '${data.EMP_NO}';
		
		if(empno==""){
			empno = '${emp_no}';
		}
		
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
	
	$(document).on("click", "#callInsert", function() {

		if (ajaxFlag)
			return;
		ajaxFlag = true;
		
		var temp = $("#empno option:selected").val();
		if(temp!=""){
			$("#empno1").val(temp)
		}
		
		var temp1 = $("#empno1").val();
		
		if ($("#empno1").val() == "") {
			alert("팀원을  선택 하세요");
			ajaxFlag = false;
			return;
		}
		
		if ($("#empno option:selected").val() == "") {
			alert("팀원을  선택 하세요");
			ajaxFlag = false;
			return;
		}
		
		var emp_no = $("#empno option:selected").val() ;
		
	 	var scallStaDt = $('input[name=scallStaDt]').val();
		 
		if (scallStaDt == "") {
			alert("날짜를 입력하세요");
			ajaxFlag = false;
			return;
		}
		
		
		var scall_gbn_nm = $("select[name='scall_gbn_nm']");
		var vendor_no = $("input[name='vendor_no']");
		var scall_purpose_cd = $("select[name='scall_purpose_cd']");
		var scall_rslt_cd = $("select[name='scall_rslt_cd']");
		var scall_pfr_nm = $("select[name='scall_pfr_nm']");
		var scall_sale_cntn = $("input[name='scall_sale_cntn']");
		var scall_cprt_cntn = $("input[name='scall_cprt_cntn']");

		var _addParam = [];
		
		
		for (var i = 0; i < vendor_no.length; i++) {
			if(vendor_no[i].value ==""  ){
				continue;
			}
			
			_addParam.push({"scall_gbn_nm":scall_gbn_nm[i].value,"vendor_no":vendor_no[i].value,"scall_purpose_cd":scall_purpose_cd[i].value,"scall_rslt_cd":scall_rslt_cd[i].value,"scall_pfr_nm":scall_pfr_nm[i].value,"scall_sale_cntn":scall_sale_cntn[i].value,"scall_cprt_cntn":scall_cprt_cntn[i].value});
		}
		if(_addParam.length==0){
			alert("거래처를  입력하세요");
			ajaxFlag = false;
			return;
		}
		
		var gubun = $("#gubun").val();
		
		
		
		$.ajax({      
		    type:"POST",  
		    url:"/callInsert",
		    data: JSON.stringify({"_addPram":_addParam,"gubun":gubun,"emp_no":emp_no,"scallStaDt":scallStaDt}),
		    dataType:"json",
		    contentType:"application/json;charset=UTF-8",
		    traditional:true,
		    success:function(args){   
		        if(args.returnCode == "0000"){
		        	alert(args.message.replace(/<br>/gi,"\n"));
		        	location.replace("/callList");
		        	//location.reload();
		        }else{
		        	alert(args.message.replace(/<br>/gi,"\n"));
		        	//location.reload();
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
	
	$(document).on("click", "#callList", function() {
		window.location.href = "/callList";
	});
	
	</script>
	
	
	<div class="container " style="max-width:100%;">
		<div class="row">
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<form name="Form"  method="post">
							<div class="container" style="padding: 15px;">◈  콜 등록 </div>
							<div class="container border" style="padding: 15px;">
								<div class="form-group row">
                                    <label for="deptno" class="col-md-2 col-form-label text-md-left"><font color="red">*</font>팀</label>
                                    <div class="col-md-6">
                                    	<select name="deptno" class="form-control" id="deptno" onchange="getTeamList();">
											<option value="">선택하세요</option>
											<c:forEach items="${deptMngList}" var="a">
											<option value="${a.DEPT_NO}" <c:if test="${a.DEPT_NO eq data.DEPT_NO or a.DEPT_NO eq deptno}">selected</c:if>>${a.TEAMNM} </option>
											</c:forEach>
										</select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="teamno" class="col-md-2 col-form-label text-md-left"><font color="red">*</font> 팀원
                                    	<input type="hidden" name="empno1" id="empno1"/>
                                    	<input type="hidden" name="ext_emp_no" id="ext_emp_no" value="${data.EMP_NO}"/>
                                    </label>
                                    <div class="col-md-6" id="empList">
                                    	
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="vendor_tel_no" class="col-md-2 col-form-label text-md-left"><font color="red">*</font> 날짜 </font></label>
                                    <div class="col-md-6">
                                    	<input type="text" class="dateRange" name="scallStaDt" value="" autocomplete="off"/><i name="dateRangeIcon" class="fas fa-calendar-alt"></i>
                                    </div>
                                </div>
                            </div>
                           <div class="border" style="padding:15px;width:90;margin-top:30px">
								<table class="table-borderless" style="border-spacing: 0 5px;border-collapse: separate;width:100%">
									<thead>
										<tr class="text-md-center">
											<td width="10%">구분</td>
											<td width="10%">거래처</td>
											<td width="10%">방문목적</td>
											<td width="10%">방문결과</td>
											<td width="10%">선호도</td>
											<td width="25%">상담내용</td>
											<td width="25%">협조사항</td>
										</tr>
									</thead>
									<tbody>
										<% for(int i=1; i< 11; i++){ %>
										<tr>
											<td>
												<select name="scall_gbn_nm" class="form-control" id="scall_gbn_nm<%=i%>" >
													<c:forEach items="${scallgbNmList}" var="b">
														<option value="${b.CMM_CD}">${b.CMM_CD_NM} </option>
													</c:forEach>
												</select>
											</td>
											<td>
												<input type="text" class="form-control temp" name="outlet_nm" id="<%=i%>">
												<input type="hidden" class="form-control" name="vendor_no" id="vendor_no<%=i%>">
											</td>
											<td>
												<select name="scall_purpose_cd" class="form-control" id="scall_purpose_cd<%=i%>" >
													<c:forEach items="${scallpurposeCdList}" var="c">
														<option value="${c.CMM_CD}">${c.CMM_CD_NM} </option>
													</c:forEach>
												</select>
											</td>
											<td>
												<select name="scall_rslt_cd" class="form-control" id="scall_rslt_cd<%=i%>" >
												<option value=""></option>
													<c:forEach items="${scallrsltcdList}" var="d">
														<option value="${d.CMM_CD}">${d.CMM_CD_NM} </option>
													</c:forEach>
												</select>
											</td>
											<td>
												<select name="scall_pfr_nm" class="form-control" id="scall_pfr_nm<%=i%>" >
													<c:forEach items="${scallpfrNmList}" var="e">
														<option value="${e.CMM_CD}">${e.CMM_CD_NM} </option>
													</c:forEach>
												</select>
											</td>
											<td><input type="text" class="form-control" name="scall_sale_cntn" id="scall_sale_cntn<%=i%>"></td>
											<td><input type="text" class="form-control" name="scall_cprt_cntn" id="scall_cprt_cntn<%=i%>"></td>
										</tr>
										<%} %>
									</tbody> 
								</table>
								<div class="text-md-right">
								<input type="hidden" name="gubun" value="${gubun}" id="gubun">
								<input class="btn btn-dark" type="button" value="목록" id="callList">
								<input class="btn btn-dark" type="button" value="등록" id="callInsert">
                            	</div>
							</div>
							
                            </form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- modal start  -->	
	<div id="popLayer" class="modal fade" role="dialog" data-backdrop="static">
		<div class="modal-dialog modal-xl">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">도매장 검색</h5>
		        	<a href="#" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
				</div>
				<div class="modal-body" id="subLayer">
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
<!-- modal  end  -->
	</div>
	<script>
	 	<c:forEach items="${memberDeptList}" var="j">
			$("input[name=mng_dept_no][value=${j.DEPT_NO}]").prop("checked",true);
		</c:forEach>
	</script>
	<form name="viewForm" method="post">
		<input type="hidden" name="emp_no"/>
		<input type="hidden" name="gubun"/> 
	</form>

   <script>
    <c:if test="${'N' eq data.WHOLESALE_YN}">
	$("#wholesale_vendor_area").show(); 
	</c:if>
	
	<%if(request.getParameter("gubun") !=null){ %>
	getTeamList();
	<%}%>
	
	<c:if test="${returnCode eq '0000'}">
 		alert("수정 하였습니다.");
	</c:if>
	
	<c:if test="${deptno ne ''}">
		getTeamList();
	</c:if>
	
   </script>
   <script>
//조회화면에 추가 하자 
$(function() {
	dataRangeOptions.singleDatePicker =  true;
	dataRangeOptions.autoUpdateInput = false;
	dataRangeOptions.locale= {format: 'YYYYMMDD'};
	
	$(".dateRange").daterangepicker(dataRangeOptions);
	$('.dateRange').on('apply.daterangepicker', function(ev, picker) {
		$(this).val(picker.endDate.format('YYYYMMDD'));
	});
});

</script>