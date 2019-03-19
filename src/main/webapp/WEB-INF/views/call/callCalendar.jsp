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
			    format: "yyyymm"
		     });
		
	});
	
	$(document).ready(function(){
		
	});
	
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
							<select name="deptno" class="form-control" id="deptno">
								<option value="">선택하세요</option>
								<c:forEach items="${teamList}" var="c">
								<option value="${c.DEPT_NO}" >${c.TEAMNM} </option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-sm-2" id="empList">
						</div>
						<div class="col-12 col-sm-2"><span class="align-middle">업소</span></div>
						<div class="col-12 col-sm-4">
							<input type="text"  name="vendorNm" id="vendorNm" class="form-control" readonly autocomplete="off"/>
							<input type="hidden" name="vendorId" id="vendorId" class="form-control" />
						</div>
					</div>
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">월</span></div>
						<div class="col-12 col-sm-3">
							<input type="text" class="_pDateRange form-control bg-white" id="_pStaDt" value="" style="width: 90%;display: inline-block;" readonly autocomplete="off"/><i name="_pDateRangeIcon" class="fas fa-calendar-alt"></i>
						</div>
						<div class="col-12 col-sm-3">
							<input class="btn btn-primary" type="button" id="prodSearch" value="조회">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px; overflow-x:auto;">	
			<div class="reserve_date">
				<div class="reserve_left">
					<div class="calendar" id="viewCalendar">
						<div class="calendar_date">
							<span>2019-03</span>
						</div>
						<table>
							<colgroup>
								<col style="width:7%;" />
								<col style="width:7%;" />
								<col style="width:12%;" />
								<col style="width:12%;" />
								<col style="width:12%;" />
								<col style="width:12%;" />
								<col style="width:12%;" />
								<col style="width:12%;" />
								<col style="width:12%;" /> 
							</colgroup>
							<tr>
								<th></th>
								<th></th>
								<th>일</th>
								<th>월</th>
								<th>화</th>
								<th>수</th>
								<th>목</th>
								<th>금</th>
								<th>토</th>									
							</tr>
								<c:forEach items="${callCalendar}" var="i" varStatus="status">
									<tr class="cb border-top border-dark" >
										<td class="border border-right-0" colspan="2">
											<div class="">&nbsp;</div>
										</td>
										<td class="border border-right-0  ">
											<div class=""><b>${i.SUN}</b></div>
										</td>
										<td class="border border-right-0  ">
											<div class=""><b>${i.MON}</b></div>
										</td>
										<td class="border border-right-0  ">
											<div class=""><b>${i.TUE}</b></div>
										</td>
										<td class="border border-right-0  ">
											<div class=""><b>${i.WED}</b></div>
										</td>
										<td class="border border-right-0  ">
											<div class=""><b>${i.THU}</b></div>
										</td>
										<td class="border border-right-0  ">
											<div class=""><b>${i.FRI}</b></div>
										</td>
										<td class="border  ">
											<div class=""><b>${i.SAT}</b></div>
										</td>
									</tr>
									<tr class="cb  border-top border-dark">
										<td class="border border-right-0  " rowspan=2>
											<div class="">&nbsp;Plan</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">&nbsp;Account</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">&nbsp;1111111</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border  ">
											<div class="">active</div>
										</td>
									</tr>
									<tr class="cb">
										<td class="border border-right-0  ">
											<div class="">&nbsp;Purpose</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">&nbsp;purd</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border  ">
											<div class="">active</div>
										</td>
									</tr>
									<tr class="cb  border-top border-dark">
										<td class="border border-right-0  " rowspan=2>
											<div class="">&nbsp;Actual</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">&nbsp;Account</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">&nbsp;aoc</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border  ">
											<div class="">active</div>
										</td>
									</tr>
									<tr class="cb">
										<td class="border border-right-0  ">
											<div class="">&nbsp;Purpose</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">&nbsp;pur</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border border-right-0  ">
											<div class="">active</div>
										</td>
										<td class="border  ">
											<div class="">active</div>
										</td>
									</tr>
								</c:forEach>
						</table>	
					</div>
				</div>
			</div>
		</div>
	</div>
	
</div>