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
	
	$(document).ready(function(){
		
		$("#memberSearch").click(function(){
			if(ajaxFlag)return;
			
			var deptno = $("#deptno").val();
			var teamnm = $("#teamnm").val();
			var use_yn = $("#use_yn").val();
			
			if(teamnm.replace(/^\s*/,"") ==""){
				alert("팀명을 입력하세요");
				ajaxFlag=false;
				return;
			}
			
			$.ajax({      
			    type:"POST",  
			    url:"/",      
			    data: JSON.stringify({"deptno":deptno,"teamnm":teamnm,"use_yn":use_yn}),
			    dataType:"json",
			    contentType:"application/json;charset=UTF-8",
			    traditional:true,
			    success:function(args){   
			        if(args.returnCode == "0000"){
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	location.replace("/teamList");
			        }else{
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	location.replace("/teamList");
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
	
	</script>
	<div class="title"> ◈  거래처 관리</div>
	<div class="container" style="max-width:100%;">
		<div class="row">
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<div class="container border" style="padding: 5px;">
								<form name="Frm" method="post">
								<div class="row"style="padding-left:50px;">
									<table class="table-borderless" style="border-spacing: 0 5px;border-collapse: separate;width:90%">
										<thead>
											<tr>
												<td>거래처명</td>
												<td style="padding-left:20px;"><input type="text" class="form-control" name="" id=""></td>
												<td style="padding-left:20px;">팀</td>
												<td style="padding-left:20px;">
													<select name="deptno" class="form-control" id="deptno">
														<option value="ALL">전체</option>
														<c:forEach items="${deptMMList}" var="a">
															<option value="${a.DEPT_NO}">${a.TEAMNM} </option>
														</c:forEach>
													</select>
												</td>
												<td style="padding-left:20px;">담당자</td>
												<td style="padding-left:20px;"><input type="text" class="form-control" name="" id=""></td>
											</tr>
											<tr >
												<td>Market</td>
												<td style="padding-left:20px;">
													<select name="" class="form-control" id="">
														<option value="ALL">전체</option>
														<c:forEach items="${marketMap}" var="b">
															<option value="${b.CMM_CD}">${b.CMM_CD_NM} </option>
														</c:forEach>
													</select>
												</td>
												<td style="padding-left:20px;">Segmentation</td>
												<td style="padding-left:20px;">
													<select name="" class="form-control" id="">
														<option value="ALL">전체</option>
														<c:forEach items="${sgmtMap}" var="c">
															<option value="${c.CMM_CD}">${c.CMM_CD_NM} </option>
														</c:forEach>
													</select>
												</td>
												<td style="padding-left:20px;">거래처상태</td>
												<td style="padding-left:20px;">
													<select name="" class="form-control" id="">
														<option value="ALL">전체</option>
														<c:forEach items="${commonList}" var="d">
															<option value="${d.CMM_CD}">${d.CMM_CD_NM} </option>
														</c:forEach>
													</select>
												</td>
											</tr>
											<tr >
												<td>도매장</td>
												<td style="padding-left:20px;"><input type="text" class="form-control" name="" id=""></td>
												<td style="padding-left:20px;">도매장여부</td>
												<td style="padding-left:20px;">
													<select name="" class="form-control" id="">
														<option value="Y">Y</option>
														<option value="N">N</option>
													</select>
												</td>
												<td style="padding-left:20px;">거래처등급</td>
												<td style="padding-left:20px;">
													<select name="" class="form-control" id="">
														<option value="ALL">전체</option>
														<c:forEach items="${vendorgrdcdList}" var="e">
															<option value="${e.CMM_CD}">${e.CMM_CD_NM} </option>
														</c:forEach>
													</select>
												</td>
											</tr>
											<tr>
												<td style="padding-left:20px;" colspan="6" class="text-right">
													<input class="btn btn-dark" type="button" value="검색" id=""/>
													<input class="btn btn-dark" type="button" value="등록" id="vendorForm"/>
													<input class="btn btn-dark" type="button" value="엑셀다운로드" id=""/>
												</td>
											</tr>
										</thead>
									</table>
								</div>
								</form>
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
						  <tbody>	
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
	