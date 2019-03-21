<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
	<script type="text/javascript">
	
	// 한글입력막기 스크립트
	$( function(){
		$("#login_id" ).on("blur keyup", function() {
			$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
		});
	})
	
	
	
	var ajaxFlag = false;
	
	$(document).ready(function(){
		
		$(document).on("click","i[name='dateRangeIcon']",function() {
		      $(this).parent().find(".dateRange").click();
		});
		
		
	});
	
	
	</script>
	
	
	<div class="title"> ◈ STEP01. PROPOSAL 기본정보</div>
	<div class="container-fluid" >
		<div class="row">
			<div class="col">
				<div class="container-fluid" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<div class="container-fluid border" style="padding: 15px;">
								<form name="Form"   method="post">
                                 <div class="form-group row">
                                    <label for="prps_nm" class="col-md-2 col-form-label text-md-left">제안명</label>
                                    <div class="col-md-8">
                                    	<input type="text" id="prps_nm" class="form-control" name="prps_nm" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.PRPS_NM}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="prps_purpose_cd" class="col-md-2 col-form-label text-md-left">제안목적</label>
                                    <div class="col-md-4">
                                    	<select name="prps_purpose_cd" class="form-control" id="prps_purpose_cd">
                                    		<option value="">선택하세요</option>
											<c:forEach items="${p_purposeList}" var="a">
											<option value="${a.CMM_CD}" <c:if test="${a.CMM_CD eq data.PRPS_PURPOSE_CD}">selected</c:if>>${a.CMM_CD_NM} </option>
											</c:forEach>
										</select>
                                    </div>
                                    <label for="act_plan_cd" class="col-md-2 col-form-label text-md-left">액티비티계획</label>
                                    <div class="col-md-4">
                                    	<select name="act_plan_cd" class="form-control" id="act_plan_cd">
                                    		<option value="">선택하세요</option>
											<c:forEach items="${p_activityList}" var="b">
											<option value="${b.CMM_CD}" <c:if test="${b.CMM_CD eq data.ACT_PLAN_CD}">selected</c:if>>${b.CMM_CD_NM} </option>
											</c:forEach>
										</select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="prps_purpose_cd" class="col-md-2 col-form-label text-md-left">제안기간</label>
                                    <div class="col-md-4">
                                    	<div style="float:left"><input type="text" class="dateRange" name="prps_str_dt" id="prps_str_dt" value="" autocomplete="off"/><i name="dateRangeIcon" class="fas fa-calendar-alt"></i>~</div>
                                    	<div ><input type="text" class="dateRange" name="prps_end_dt" id="prps_end_dt" value="" autocomplete="off"/><i name="dateRangeIcon" class="fas fa-calendar-alt"></i></div>
                                    </div>
                                    <label for="act_plan_cd" class="col-md-2 col-form-label text-md-left">거래처</label>
                                    <div class="col-md-4">
                                    	<input type="text" id="outlet_no" class="form-control" name="outlet_no" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.OUTLET_NO}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="login_id" class="col-md-2 col-form-label text-md-left">아이디</label>
                                    <div class="col-md-6">
                                    	<input type="text" id="login_id" class="form-control" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %> name="login_id" value="${data.LOGIN_ID}" style="width:30%;display:initial;"> 
                                    	<%if(request.getParameter("gubun")==null){ %>
                                    	<input class="btn btn-dark" type="button" value="중복체크" id="checkloginid" style="margin-top: -5px;"/>
                                    	<input type="hidden" name="duplicatecheck" id="duplicatecheck"/><span id="msg" style="display:none">사용가능한 ID 입니다.</span>
                                    	<% } %>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="login_pwd" class="col-md-2 col-form-label text-md-left">비밀번호</label>
                                    <div class="col-md-6">
                                    	<input type="password" id="login_pwd" class="form-control" name="login_pwd">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="login_pwd1" class="col-md-2 col-form-label text-md-left">비밀번호확인</label>
                                    <div class="col-md-6">
                                    	<input type="password" id="login_pwd1" class="form-control" name="login_pwd1">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="emp_hp_no" class="col-md-2 col-form-label text-md-left">휴대폰번호</label>
                                    <div class="col-md-6">
                                        <input type="text" id="emp_hp_no" class="form-control" name="emp_hp_no" value="${data.EMP_HP_NO}">
                                    </div>
                                </div>
								<div id="wrap4" style="display:none; border:1px solid; width:570px; height:440px; margin:50px 0px 0px 73px; position:absolute; z-index:10;">
									<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldPostcode('4')" alt="접기 버튼">
								</div>
                                <div class="form-group row">
                                    <label for="emp_addr" class="col-md-2 col-form-label text-md-left">주소</label>
                                    <div class="col-md-6">
                                        <input type="text" id="zip_cd" class="form-control" name="zip_cd" readonly style="width:30%;display:initial;" value="${data.ZIP_CD}">
                                        <input class="btn btn-dark" type="button" value="우편번호"  onclick="execPostcode('4')" style="margin-top: -5px;"/>
                                        <br>
                                        <input type="text" id="emp_addr" class="form-control" name="emp_addr" value="${data.EMP_ADDR}"><br>
                                    </div>
                                </div>
								
								<div class="form-group row">
                                    <label for="emp_birth" class="col-md-2 col-form-label text-md-left">생일</label>
                                    <div class="col-md-6">
                                        <input type="text" id="emp_birth" class="form-control" name="emp_birth" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %> value="${data.EMP_BIRTH}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="entco_dt" class="col-md-2 col-form-label text-md-left">입사일</label>
                                    <div class="col-md-6">
                                        <input type="text" id="entco_dt" class="form-control" name="entco_dt" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %> value="${data.ENTCO_DT}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="emp_grd_cd" class="col-md-2 col-form-label text-md-left">사원등급</label>
                                    <div class="col-md-6">
                                    	<select name="emp_grd_cd" class="form-control" id="emp_grd_cd" onChange="showMngDept()">
                                    		<option value="">선택하세요</option>
											<c:forEach items="${commonList}" var="j">
											<option value="${j.CMM_CD}" <c:if test="${j.CMM_CD eq data.EMP_GRD_CD}">selected</c:if>>${j.CMM_CD_NM} </option>
											</c:forEach>
										</select>
                                        
                                    </div>
                                </div>
                                 <div class="form-group row">
                                    <label for="use_yn" class="col-md-2 col-form-label text-md-left">급무여부</label>
                                    <div class="col-md-6">
                                    	<input type="checkbox" name="use_yn" id="use_yn"  value= "${data.USE_YN}" <c:if test="${data.USE_YN eq 'Y'}">checked</c:if>/>근무중
                                    </div>
                                </div>
                                
                                <div class="border" id="deptMng" style="padding: 15px;display:none" >
                                  		관리할 팀을 선택 해 주세요<br>

                                    <c:forEach items="${deptMMList}" var="i">
										 
										<input type="checkbox" id="mng_dept_no" name="mng_dept_no" value="${i.DEPT_NO}" <c:if test="{flag}">checked</c:if>> ${i.TEAMNM} <br>
										
									</c:forEach>											
									
                                    
                                </div>

								<div class="text-md-right">
										<input type="hidden" name="gubun" value="${gubun}">
										<input class="btn btn-dark" type="button" value="등록" id="memberWork">
                                </div>
								</form>
                             </div>
						</div>
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
	dataRangeOptions.locale.format = 'YYYYMMDD';
	
	$(".dateRange").daterangepicker(dataRangeOptions);
	$('.dateRange').on('apply.daterangepicker', function(ev, picker) {
		$(this).val(picker.endDate.format('YYYYMMDD'));
	});
	
});
</script>