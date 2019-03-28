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

	<script type="text/javascript">
	var nowUrl = "/vendorList";
	$(function(){

		//  var source = ['난누군가','또여긴어딘가','누가날불러?'];
	    // 자동으로 /ajax/auato 주소로 term 이란 파라미터가 전송된다.
	    // 응답은 [{label:~~~,value:~~~},{label:~~~,value:~~~}] 형태가 된다.
		    $('.temp').autocomplete({"source":function(request,response){
		    	console.log(request);
		           $.getJSON("/vendorAuto",{"term":request.term},
	                   function(result) {
	                          return response($.map(result, function(item){
	                                  var l = item.label.replace(request.term, request.term);
	                                  return {label:l, value:item.label};
					}));
		           });
		    }}, $('.temp')[0]);
		});
	
	
	var ajaxFlag = false;
	
	$(document).ready(function(){
		
		$("#downloadExcel").click(function(){
			alert("작업중입니다.")
		});
		
		$("#vendorSearch").click(function(){
			
			var outlet_nm = $("#outlet_nm").val();
			var dept_no = $("#dept_no option:selected").val();
			var emp_nm = $("#emp_nm").val();
			var market_divs_cd = $("#market_divs_cd option:selected").val();
			var vendor_sgmt_divs_cd = $("#vendor_sgmt_divs_cd option:selected").val();
			var vendor_stat_cd = $("#vendor_stat_cd option:selected").val();
			var wholesale_yn = $("#wholesale_yn option:selected").val();
			var vendor_grd_cd = $("#vendor_grd_cd option:selected").val();
			
			if(ajaxFlag)return;
			ajaxFlag=true;
			$.ajax({      
			    type:"GET",  
			    url:"/vendorSearch?outlet_nm="+outlet_nm+"&dept_no="+dept_no+"&emp_nm="+emp_nm+"&market_divs_cd="+market_divs_cd+"&vendor_sgmt_divs_cd="+vendor_sgmt_divs_cd
			    +"&vendor_stat_cd="+vendor_stat_cd+"&wholesale_yn="+wholesale_yn+"&vendor_grd_cd="+vendor_grd_cd,
			    dataType:"html",
			    traditional:true,
			    success:function(args){   
			    	$("#vendorSeachLayer").html(args);
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    }  
			});
			
			
		});
		
		
		$("#vendorForm").click(function(){
			location.replace("/vendorForm");
		});
	});
	
	
	function vendorView(vendor_no, gubun){
		document.viewForm.vendor_no.value=vendor_no;
		document.viewForm.gubun.value=gubun;
		
		document.viewForm.action="/vendorView";
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
	<div class="title"> ◈  거래처 관리</div>
	<div class="container" style="max-width:100%;">
		<div class="row">
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<div class="container border" style="padding: 5px;">
								<div class="row"style="padding-left:50px;">
									<table class="table-borderless" style="border-spacing: 0 5px;border-collapse: separate;width:90%">
										<thead>
											<tr>
												<td>거래처명</td>
												<td style="padding-left:20px;"><input type="text" class="form-control temp" name="outlet_nm" id="outlet_nm"></td>
												<td style="padding-left:20px;">팀</td>
												<td style="padding-left:20px;">
													<select name="dept_no" class="form-control" id="dept_no">
														<option value="ALL">전체</option>
														<c:forEach items="${deptMMList}" var="a">
															<option value="${a.DEPT_NO}">${a.TEAMNM} </option>
														</c:forEach>
													</select>
												</td>
												<td style="padding-left:20px;">담당자</td>
												<td style="padding-left:20px;"><input type="text" class="form-control" name="emp_nm" id="emp_nm"></td>
											</tr>
											<tr >
												<td>Market</td>
												<td style="padding-left:20px;">
													<select name="market_divs_cd" class="form-control" id="market_divs_cd"  onchange="getSegment();">
														<option value="ALL">전체</option>
														<c:forEach items="${marketMap}" var="b">
															<option value="${b.CMM_CD}">${b.CMM_CD_NM} </option>
														</c:forEach>
													</select>
												</td>
												<td style="padding-left:20px;">Segmentation</td>
												<td style="padding-left:20px;" id="segList">
													<select name="vendor_sgmt_divs_cd" class="form-control" id="vendor_sgmt_divs_cd">
												  		<option value="ALL">전체</option>
													</select>
													
												</td>
												<td style="padding-left:20px;">거래처상태</td>
												<td style="padding-left:20px;">
													<select name="vendor_stat_cd" class="form-control" id="vendor_stat_cd">
														<option value="ALL">전체</option>
														<c:forEach items="${commonList}" var="d">
															<option value="${d.CMM_CD}">${d.CMM_CD_NM} </option>
														</c:forEach>
													</select>
												</td>
											</tr>
											<tr >
												<td>도매장여부</td>
												<td style="padding-left:20px;">
													<select name="wholesale_yn" class="form-control" id="wholesale_yn">
														<option value="ALL">전체</option>
														<option value="Y">Y</option>
														<option value="N">N</option>
													</select>
												</td>
												<td style="padding-left:20px;">거래처등급</td>
												<td style="padding-left:20px;">
													<select name="vendor_grd_cd" class="form-control" id="vendor_grd_cd">
														<option value="ALL">전체</option>
														<c:forEach items="${vendorgrdcdList}" var="e">
															<option value="${e.CMM_CD}">${e.CMM_CD_NM} </option>
														</c:forEach>
													</select>
												</td>
												<td style="padding-left:20px;" colspan="2" class="text-right">
													<input class="btn btn-dark" type="button" value="검색" id="vendorSearch"/>
													<input class="btn btn-dark" type="button" value="등록" id="vendorForm"/>
													<input class="btn btn-dark" type="button" value="엑셀다운로드" id="downloadExcel"/>
												</td>
											</tr>
											
										</thead>
									</table>
								</div>
								
							</div>
						</div>
					</div>
					<div class="row" style="padding-top:20px;">	
						<table class="table">
						  <thead>
						    <tr>
						      <th scope="col">거래처명</th>
						      <th scope="col">관리팀</th>
						      <th scope="col">담당자</th>
						      <th scope="col">전화번호</th>
						      <th scope="col">주소</th>
						      <th scope="col">Market</th>
						      <th scope="col">Segmentation</th>
						      <th scope="col">상태</th>
						      <th scope="col" colspan="3" class="text-center" >관리</th>
						    </tr>
						  </thead>
						  <tbody id="vendorSeachLayer">	
						  	<c:forEach items="${vendorList}" var="f" varStatus="status">	
						  		<tr>
									<td><a href="javascript:vendorView('${f.VENDOR_NO}','update')">${f.OUTLET_NM}</a></td>
									<td>${f.TEAMNM}</td>
									<td>${f.EMP_NM}</td>
									<td>${f.VENDOR_TEL_NO}</td>
									<td>${f.VENDOR_ADDR}</td>
									<td>${f.MARKGET_NM}</td>
									<td>${f.SGMT_NM}</td>
									<td>${f.STAT_NM}</td>
									<td>원장보기</td>
									<td>메뉴보기</td>
									<td>수정</td>
								</tr>
						  	</c:forEach>
						  		<tr>
						  			<td colspan="11">
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
		<input type="hidden" name="vendor_no"/>
		<input type="hidden" name="gubun"/> 
	</form>
	<script>
		<c:if test="${returnCode eq '0000'}">
	 		alert("저장하였습니다.");
		</c:if>
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
			
			var outlet_nm = $("#outlet_nm").val();
			var dept_no = $("#dept_no option:selected").val();
			var emp_nm = $("#emp_nm").val();
			var market_divs_cd = $("#market_divs_cd option:selected").val();
			var vendor_sgmt_divs_cd = $("#vendor_sgmt_divs_cd option:selected").val();
			var vendor_stat_cd = $("#vendor_stat_cd option:selected").val();
			var wholesale_yn = $("#wholesale_yn option:selected").val();
			var vendor_grd_cd = $("#vendor_grd_cd option:selected").val();
			
			if(ajaxFlag)return;
			ajaxFlag=true;
			$.ajax({      
			    type:"GET",  
			    url:"/vendorSearch?outlet_nm="+outlet_nm+"&dept_no="+dept_no+"&emp_nm="+emp_nm+"&market_divs_cd="+market_divs_cd+"&vendor_sgmt_divs_cd="+vendor_sgmt_divs_cd
			    +"&vendor_stat_cd="+vendor_stat_cd+"&wholesale_yn="+wholesale_yn+"&vendor_grd_cd="+vendor_grd_cd+"&page=" + pages + "&pageLine=" + pageLine,
			    dataType:"html",
			    traditional:true,
			    success:function(args){   
			    	$("#vendorSeachLayer").html(args);
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    }  
			});
		}
	</script>