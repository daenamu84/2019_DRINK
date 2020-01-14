<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>

	<script type="text/javascript">
	var nowUrl = "/callList";
	var ajaxFlag = false;
	$(document).on("click","i[name='dateRangeIcon']",function() {
	      $(this).parent().find(".dateRange").click();
	});
	
	
	$(document).on("click","#callupdate", function(){
		if (ajaxFlag)
			return;
		ajaxFlag = true;
		
		var scall_no  			= $("#scall_no").val();
		var scall_purpose_cd_u 	= $("#scall_purpose_cd_u option:selected").val();
		var scall_pfr_nm_u		= $("#scall_pfr_nm_u option:selected").val();
		var scall_rslt_cd_u		= $("#scall_rslt_cd_u option:selected").val();
		var scall_brand_id_u	= $("#scall_brand_id_u option:selected").val();
		var scall_sale_cntn_u = $("#scall_sale_cntn_u").val();
		var scall_cprt_cntn_u = $("#scall_cprt_cntn_u").val();
		
		$.ajax({      
		    type:"POST",  
		    url:"/callUpdate",      
		    data: JSON.stringify({"scall_no":scall_no,"scall_purpose_cd_u":scall_purpose_cd_u,"scall_pfr_nm_u":scall_pfr_nm_u,"scall_rslt_cd_u":scall_rslt_cd_u,"scall_sale_cntn_u" :scall_sale_cntn_u,"scall_cprt_cntn_u" :scall_cprt_cntn_u,"scall_brand_id_u":scall_brand_id_u }),
		    dataType:"json",
		    contentType:"application/json;charset=UTF-8",
		    traditional:true,
		    success:function(args){   
		        if(args.returnCode == "0000"){
		        	alert(args.message.replace(/<br>/gi,"\n"));
		        	location.reload();
		        	
		        }else{
		        	alert(args.message.replace(/<br>/gi,"\n"));
		        	location.reload();
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
		        	location.reload();
		        	
		        }else{
		        	alert(args.message.replace(/<br>/gi,"\n"));
		        	location.reload();
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
	
	$(document).ready(function(){
		
		$("#downloadCallExcel").click(function(){
			alert("작업중입니다.")
		});
		
		
		$("#calldelete").click(function(){
			
			var checkdelete = $("input[name='checkdelete']");
		
			var _addParam = [];
			
			
			for (var i = 0; i < checkdelete.length; i++) {
				if(!checkdelete[i].checked){
					continue;
				}
				
				_addParam.push({"scall_no":checkdelete[i].value});
			}
			if(_addParam.length==0){
				alert("삭제할 걸 선택 하세요");
				ajaxFlag = false;
				return;
			}
			
			$.ajax({      
			    type:"POST",  
			    url:"/callDelete",
			    data: JSON.stringify({"_addPram":_addParam}),
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
		
		
		
		$("#callSearch").click(function(){
			
			var deptno = $("#deptno option:selected").val();
			var empno = $("#empno").val();
			
			var temp = $("#empno option:selected").val();
			
			 if(typeof temp == "undefined"){
				 temp = "";
			 } 
			
			var vendor_nm = $("#vendor_nm").val();
			var scallStaDt = $("#scallStaDt").val();
			var scallEndDt = $("#scallEndDt").val();
			var scall_gbn_nm = $("#scall_gbn_nm option:selected").val();
			var scall_rslt_cd = $("#scall_rslt_cd option:selected").val();
			var scall_purpose_cd 	= $("#scall_purpose_cd option:selected").val();
			
			
			if(ajaxFlag)return;
			ajaxFlag=true;
			$.ajax({      
			    type:"GET",  
			    url:"/callSearch?deptno="+deptno+"&empno="+temp+"&vendor_nm="+vendor_nm+"&scallStaDt="+scallStaDt+"&scallEndDt="+scallEndDt+"&scall_gbn_nm="+scall_gbn_nm
			    +"&scall_rslt_cd="+scall_rslt_cd +"&scall_purpose_cd="+scall_purpose_cd,
			    dataType:"html",
			    traditional:true,
			    success:function(args){   
			    	$("#callSeachLayer").html(args);
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    }  
			});
			
			
		});
		
		
		$("#callForm").click(function(){
			location.replace("/callForm");
		});
	});
	 
	function getTeamList() {
		if (ajaxFlag)
			return;
		ajaxFlag = true;
		var deptno = "";
		var gubun = "<%=request.getParameter("gubun")%>";
		
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
	</script>
	<div class="title"> ◈  Sales Call</div>
	<div class="container" style="max-width:100%;">
		<div class="row">
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<div class="container border" style="padding: 5px;">
								<form name="Frm" method="post">
								<div class="row"style="padding-left:20px;">
										<div class="col-sm-1 my-auto">팀</div>
										<div class="col-sm-2">
											<select name="deptno" class="form-control" id="deptno" onchange="getTeamList();">
												<option value="ALL">전체</option>
												<c:forEach items="${deptList}" var="a">
													<option value="${a.DEPT_NO}">${a.TEAMNM} </option>
												</c:forEach>
											</select>
											<input type="hidden" name="empno1" id="empno1"/>
										</div>
										<div class="col-sm-1 my-auto">팀원</div>
										<div class="col-sm-2"  id="empList"></div>
										<div class="col-sm-1 my-auto">거래처</div>
										<div class="col-sm-2">
											<input type="text" class="form-control" name="vendor_nm" id="vendor_nm">
										</div>
								</div>
								<div class="row"style="padding-left:20px;margin-top:10px">
									<div class="col-sm-1 my-auto">기간</div>
									<div class="col-sm-5">
										<span> <input type="text" class="dateRange"
											name="scallStaDt" id="scallStaDt" value="" autocomplete="off" readonly/>
											~
										</span> <span><input type="text" class="dateRange"
											name="scallEndDt" id="scallEndDt" value="" autocomplete="off" readonly/></span>
									</div>
									<div class="col-sm-1 my-auto">구분</div>
									<div class="col-sm-2">
										<select name="scall_gbn_nm" class="form-control" id="scall_gbn_nm">
											<option value="ALL">전체</option>
											<c:forEach items="${scallgbNmList}" var="c">
												<option value="${c.CMM_CD}">${c.CMM_CD_NM} </option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="row"style="padding-left:20px;margin-top:10px">
									<div class="col-sm-1 my-auto">방문목적</div>
									<div class="col-sm-2">
										<select name="scall_purpose_cd" class="form-control" id="scall_purpose_cd">
											<option value="ALL">전체</option>
											<c:forEach items="${scallpurposeCdList}" var="e">
												<option value="${e.CMM_CD}">${e.CMM_CD_NM} </option>
											</c:forEach>
										</select>
									</div>
									<div class="col-sm-1 my-auto">방문결과</div>
									<div class="col-sm-2">
										<select name="scall_rslt_cd" class="form-control" id="scall_rslt_cd">
											<option value="ALL">전체</option>
											<c:forEach items="${scallrsltcdList}" var="d">
												<option value="${d.CMM_CD}">${d.CMM_CD_NM} </option>
											</c:forEach>
										</select>
									</div>
									<div class="col-sm-5">
										<input class="btn btn-dark" type="button" value="삭제" id="calldelete"/>
										<input class="btn btn-dark" type="button" value="검색" id="callSearch"/>
										<input class="btn btn-dark" type="button" value="등록" id="callForm"/>
										<!-- input class="btn btn-dark" type="button" value="엑셀다운로드" id="downloadCallExcel"/-->
									</div>
								</div>
								</form>
							</div>
						</div>
					</div>
					<div class="row" style="padding-top:10px;">	
						<table class="table">
						  <thead>
						    <tr>
						      <th scope="col">선택</th>
						      <th scope="col">구분</th>
						      <th scope="col">CallDate</th>
						      <th scope="col">거래처(지역명)</th>
						      <th scope="col">팀</th>
						      <th scope="col">담당자</th>
						      <th scope="col">방문목적</th>
						      <th scope="col">선호도</th>
						    </tr>
						  </thead>
						  <tbody  id="callSeachLayer">	
						    <c:forEach items="${CallList}" var="i" varStatus="status">
								<tr>
									<td><input type="checkbox" name="checkdelete" value="${i.SCALL_NO}"></td>
									<td><a href="javascript:callView('${i.SCALL_NO}')">${i.SCALL_GBN_NM_M}</a></td>
									<td>${i.SCALL_DT}</td>
									<td>${i.VENDOR_NM}</td>
									<td>${i.TEAMNM}</td>
									<td>${i.EMP_NM}</td>
									<td>${i.SCALL_PURPOSE_CD_NM}</td>
									<td>${i.SCALL_PFR_NM}</td>
								</tr>
							</c:forEach>
								<tr>
									<td colspan="8">
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
		</div>
		<!-- modal start  -->	
		
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
			
			var deptno = $("#deptno option:selected").val();
			var empno = $("#empno").val();
			
			var temp = $("#empno option:selected").val();
			
			 if(typeof temp == "undefined"){
				 temp = "";
			 } 
			
			var vendor_nm = $("#vendor_nm").val();
			var scallStaDt = $("#scallStaDt").val();
			var scallEndDt = $("#scallEndDt").val();
			var scall_gbn_nm = $("#scall_gbn_nm option:selected").val();
			var scall_rslt_cd = $("#scall_rslt_cd option:selected").val();
			var scall_purpose_cd 	= $("#scall_purpose_cd option:selected").val();
			
			if(ajaxFlag)return;
			ajaxFlag=true;
			$.ajax({      
			    type:"GET",  
			    url:"/callSearch?deptno="+deptno+"&empno="+temp+"&vendor_nm="+vendor_nm+"&scallStaDt="+scallStaDt+"&scallEndDt="+scallEndDt+"&scall_gbn_nm="+scall_gbn_nm
			    +"&scall_rslt_cd="+scall_rslt_cd+"&scall_purpose_cd="+scall_purpose_cd+"&page=" + pages + "&pageLine=" + pageLine,
			    dataType:"html",
			    traditional:true,
			    success:function(args){   
			    	$("#callSeachLayer").html(args);
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    }  
			});
		}
	</script>