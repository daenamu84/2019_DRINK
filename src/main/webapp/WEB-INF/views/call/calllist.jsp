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
	
	$(document).ready(function(){
		
		$("#callSearch, #downloadCallExcel").click(function(){
			alert("작업중입니다.")
		});
		
		$("#callForm").click(function(){
			location.replace("/callForm");
		});
	});
	 
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
													<select name="deptno" class="form-control" id="deptno">
														<option value="ALL">전체</option>
														<c:forEach items="${deptList}" var="a">
															<option value="${a.DEPT_NO}">${a.TEAMNM} </option>
														</c:forEach>
													</select>
												</td>
												<td style="padding-left:20px;">팀원</td>
												<td style="padding-left:20px;">
													<select name="emp_no" class="form-control" id="emp_no">
													</select>
												</td>
												<td style="padding-left:20px;">거래처</td>
												<td style="padding-left:20px;"><input type="text" class="form-control" name="outlet_nm" id="outlet_nm"></td>
											</tr>
											<tr>
												<td style="padding-left:20px;">기간</td>
												<td style="padding-left:20px;">
													<input type="text" class="dateRange" name="scallStaDt" value="" autocomplete="off"/><i name="dateRangeIcon" class="fas fa-calendar-alt"></i>~
													</td>
												<td>	
													<input type="text" class="dateRange" name="scallEndDt" value="" autocomplete="off"/><i name="dateRangeIcon" class="fas fa-calendar-alt"></i>
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
												<td></td>
												<td style="padding-left:20px;"></td>
											</tr>
											<tr>
												<td style="padding-left:20px;" colspan="7" class="text-right">
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
						  <tbody>
						    <c:forEach items="${deptList}" var="i" varStatus="status">
								<tr>
									<td><a href="javascript:fnCopy('${i.DEPT_NO}','${i.TEAMNM}','${i.USE_YN}')">${i.DEPT_NO}</a></td>
									<td><a href="javascript:fnCopy('${i.DEPT_NO}','${i.TEAMNM}','${i.USE_YN}')">${i.TEAMNM}</a></td>
									<td>${i.USE_YN_NM}</td>
								</tr>
							</c:forEach>
						  </tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>



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