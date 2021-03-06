<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>

	<script type="text/javascript">
	var nowUrl = "/memberList";
	var ajaxFlag = false;
	
	$(document).ready(function(){
		
		$("#memberSearch").click(function(){
			if(ajaxFlag)return;
			
			var deptno = $("#deptno option:selected").val();;
			var empno = $("#empno").val();
			
			
			$.ajax({
				type:"GET",  
			    url:"/memberSearch?deptno="+$("#deptno").val()+"&empno="+$("#empno").val(),
			    type:"GET",  
			    dataType:"html",
			    traditional:true,
			    success:function(args){   
			    	$("#memberSearchLayer").html(args);
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    }  
			});
		});
		
		$("#memberForm").click(function(){
			location.replace("/memberForm");
		});
	});
	
	function memberView(emp_no, gubun){
		document.viewForm.emp_no.value=emp_no;
		document.viewForm.gubun.value=gubun;
		
		document.viewForm.action="/memberView";
		document.viewForm.submit();
	}
	
	function showEmpList(){
		deptno = $("#deptno option:selected").val();
		
		if(deptno!="ALL"){
			if(ajaxFlag)return;
			ajaxFlag=true;
			$.ajax({      
			    type:"GET",  
			    url:"/EmpSearchPop?deptno="+deptno,      
			    dataType:"html",
			    traditional:true,
			    success:function(args){   
			    	$("#EmpListLayer").html(args);
			    	$("#EmpListNM").show();
					$("#EmpListLayer").show();
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    }  
			});
			
		}else{
			
			$("#EmpListNM").hide();
			$("#EmpListLayer").hide();
		}
	}
	</script>
	<div class="title"> ◈  사원관리</div>
	<div class="container" style="max-width:100%;">
		<div class="row">
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<div class="container border" style="padding: 5px;">
								<div class="row"style="padding-left:20px;">
									<div class="col-sm-3  my-auto" style="text-align:center">팀</div>
									<div class="col-sm-4">
										<select name="deptno" class="form-control" id="deptno" onchange="showEmpList()">
												<option value="ALL">전체</option>
												<c:forEach items="${deptMMList}" var="i">
													<option value="${i.DEPT_NO}">${i.TEAMNM}</option>
												</c:forEach>
										</select>
									</div>
									<div class="col-sm-2 ">
									<input class="btn btn-dark" type="button" value="검색" id="memberSearch"/>
									<input class="btn btn-dark" type="button" value="등록" id="memberForm"/>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row table-responsive text-center" style="padding-top:10px;">	
						<table class="table ">
						  <thead>
						    <tr>
						      <th scope="col">팀</th>
						      <th scope="col">사원명</th>
						      <th scope="col">ID</th>
						      <th scope="col">권한</th>
						      <th scope="col">근무여부</th>
						    </tr>
						  </thead>
						  <tbody id="memberSearchLayer">
						    <c:forEach items="${empMList}" var="i" varStatus="status">
								<tr>
									<td>${i.TEAMNM}</td>
									<td><a href="javascript:memberView('${i.EMP_NO}','update')">${i.EMP_NM}</a></td>
									<td>${i.LOGIN_ID}</td>
									<td>${i.EMP_GRD_CD}</td>
									<td>${i.USE_YN_NM}</td>
								</tr>
							</c:forEach>
							<tr>
								<td colspan="5" >
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
	</div>
	<form name="viewForm" method="post">
		<input type="hidden" name="emp_no"/>
		<input type="hidden" name="gubun"/> 
	</form>

<script>
function goPage(pages, pageLine) {
	
	if($("#deptno option:selected").val()!='ALL'){
		if(ajaxFlag)return;
		
		var deptno = $("#deptno option:selected").val();;
		var empno = $("#empno").val();
		
		
		$.ajax({
			type:"GET",  
		    url:"/memberSearch?deptno="+deptno+"&page=" + pages + "&pageLine=" + pageLine,
		    type:"GET",  
		    dataType:"html",
		    traditional:true,
		    success:function(args){   
		    	$("#memberSearchLayer").html(args);
		        ajaxFlag=false;
		    },   
		    error:function(xhr, status, e){  
		        ajaxFlag=false;
		    }  
		});
	}else{
		var url = nowUrl;
		if(url.indexOf('?')  >-1){url += "&";}else{url +="?";}
	    url += "page=" + pages + "&pageLine=" + pageLine+ "&deptno="+$("#deptno option:selected").val();
	    location.href = url;
	}
	
	
}
</script>
   