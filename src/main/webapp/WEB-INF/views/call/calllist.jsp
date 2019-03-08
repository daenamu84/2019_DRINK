<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>

	<script type="text/javascript">
	
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
			
			var outlet_nm = $("#outlet_nm").val();
			var scallStaDt = $("#scallStaDt").val();
			var scallEndDt = $("#scallEndDt").val();
			var scall_gbn_nm = $("#scall_gbn_nm option:selected").val();
			var scall_rslt_cd = $("#scall_rslt_cd option:selected").val();
			
			if(ajaxFlag)return;
			ajaxFlag=true;
			$.ajax({      
			    type:"GET",  
			    url:"/callSearch?deptno="+deptno+"&empno="+temp+"&outlet_nm="+outlet_nm+"&scallStaDt="+scallStaDt+"&scallEndDt="+scallEndDt+"&scall_gbn_nm="+scall_gbn_nm
			    +"&scall_rslt_cd="+scall_rslt_cd,
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
									<table class="table-borderless ">
										<thead>
											<tr>
												<td style="padding-left:20px;">팀</td>
												<td style="padding-left:20px;" colspan="2">
													<select name="deptno" class="form-control" id="deptno" onchange="getTeamList();">
														<option value="ALL">전체</option>
														<c:forEach items="${deptList}" var="a">
															<option value="${a.DEPT_NO}">${a.TEAMNM} </option>
														</c:forEach>
													</select>
													<input type="hidden" name="empno1" id="empno1"/>
												</td>
												<td style="padding-left:20px;">팀원</td>
												<td style="padding-left:20px;"  id="empList">
													
												</td>
												<td style="padding-left:20px;">거래처</td>
												<td style="padding-left:20px;"><input type="text" class="form-control" name="outlet_nm" id="outlet_nm"></td>
											</tr>
											<tr>
												<td style="padding-left:20px;">기간</td>
												<td style="padding-left:20px;">
													<input type="text" class="dateRange" name="scallStaDt" id="scallStaDt" value="" autocomplete="off"/><i name="dateRangeIcon" class="fas fa-calendar-alt"></i>~
												</td>
												<td>	
													<input type="text" class="dateRange" name="scallEndDt" id="scallEndDt" value="" autocomplete="off"/><i name="dateRangeIcon" class="fas fa-calendar-alt"></i>
												</td>
												<td style="padding-left:20px;">구분</td>
												<td style="padding-left:20px;">
													<select name="scall_gbn_nm" class="form-control" id="scall_gbn_nm">
														<option value="ALL">전체</option>
														<c:forEach items="${scallgbNmList}" var="c">
															<option value="${c.CMM_CD}">${c.CMM_CD_NM} </option>
														</c:forEach>
													</select>
												</td>
												<td style="padding-left:20px;">콜 방문결과</td>
												<td style="padding-left:20px;">
													<select name="scall_rslt_cd" class="form-control" id="scall_rslt_cd">
														<option value="ALL">전체</option>
														<c:forEach items="${scallrsltcdList}" var="d">
															<option value="${d.CMM_CD}">${d.CMM_CD_NM} </option>
														</c:forEach>
													</select>
												</td>
											</tr>
											<tr>
												<td style="padding-left:20px;" colspan="7" class="text-right">
													<input class="btn btn-dark" type="button" value="삭제" id="calldelete"/>
													<input class="btn btn-dark" type="button" value="검색" id="callSearch"/>
													<input class="btn btn-dark" type="button" value="등록" id="callForm"/>
													<input class="btn btn-dark" type="button" value="엑셀다운로드" id="downloadCallExcel"/>
												</td>
											</tr>
										</thead>
									</table>
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
									<td>${i.OUTLET_NM}</td>
									<td>${i.TEAMNM}</td>
									<td>${i.EMP_NM}</td>
									<td>${i.SCALL_PURPOSE_CD_NM}</td>
									<td>${i.SCALL_PFR_NM}</td>
								</tr>
							</c:forEach>
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