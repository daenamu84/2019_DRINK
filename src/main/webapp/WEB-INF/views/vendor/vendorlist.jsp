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
														<c:forEach items="${deptMMList}" var="i">
															<option value="${i.DEPT_NO}">${i.TEAMNM} </option>
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
														<option value="1">Market1</option>
														<option value="2">Market2</option>
													</select>
												</td>
												<td style="padding-left:20px;">Segmentation</td>
												<td style="padding-left:20px;">
													<select name="" class="form-control" id="">
														<option value="1">Segmentation1</option>
														<option value="2">Segmentation2</option>
													</select>
												</td>
												<td style="padding-left:20px;">거래처상태</td>
												<td style="padding-left:20px;">
													<select name="" class="form-control" id="">
														<c:forEach items="${commonList}" var="j">
															<option value="${j.CMM_CD}">${j.CMM_CD_NM} </option>
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
												<td style="padding-left:20px;" colspan="2" class="text-right">
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
						    	<tr>
									<td>성포주류</td>
									<td>T-1</td>
									<td>박지승</td>
									<td>010456789</td>
									<td>경기 고양시 일산구 장항동 547-12</td>
									<td>On Trade</td>
									<td>Trendy Bar</td>
									<td>승인완료</td>
									<td>원장보기</td>
									<td>메뉴보기</td>
									<td>수정</td>
								</tr>
						  </tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	