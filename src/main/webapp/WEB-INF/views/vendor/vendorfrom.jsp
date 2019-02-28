<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

	
	<script type="text/javascript">
	
	// 한글입력막기 스크립트
	$( function(){
		$("#login_id" ).on("blur keyup", function() {
			$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
		});
	})
	
	</script>
	
	<div class="container " style="max-width:100%;">
		<div class="row">
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<div class="container" style="padding: 15px;"> <%if(request.getParameter("gubun")==null){ %>◈  거래처 기본 정보 등록 <%}else{ %>◈  ◈  거래처 기본 정보 수정 <%} %></div>
							<div class="container border" style="padding: 15px;">
								<form name="my-form"   method="post">
								<div class="form-group row">
                                    <label for="deptno" class="col-md-2 col-form-label text-md-left">거래처명</label>
                                    <div class="col-md-6"><input type="text" id="outlet_nm" class="form-control" name="outlet_nm" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.OUTLET_NM}"></div>
                                </div>
                                <div class="form-group row">
                                    <label for="deptno" class="col-md-2 col-form-label text-md-left">사업자등록번호</label>
                                    <div class="col-md-6"><input type="text" id="outlet_nm" class="form-control" name="outlet_nm" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.OUTLET_NM}"></div>
                                </div>
                                <div class="form-group row">
                                    <label for="emp_nm" class="col-md-2 col-form-label text-md-left">이름</label>
                                    <div class="col-md-6">
                                    	<input type="text" id="emp_nm" class="form-control" name="emp_nm" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.EMP_NM}">
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

                                <div class="form-group row">
                                    <label for="emp_addr" class="col-md-2 col-form-label text-md-left">주소</label>
                                    <div class="col-md-6">
                                        <input type="text" id="zip_cd" class="form-control" name="zip_cd" style="width:30%" value="${data.ZIP_CD}"><br>
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
                                        <select name="emp_grd_cd" class="form-control" id="emp_grd_cd">
											<option value="0001" <c:if test="${i.DEPT_NO eq data.EMP_GRD_CD}">selected</c:if>>ADMIN</option>
											<option value="0002" <c:if test="${i.DEPT_NO eq data.EMP_GRD_CD}">selected</c:if>>슈퍼관리자</option>
											<option value="0003" <c:if test="${i.DEPT_NO eq data.EMP_GRD_CD}">selected</c:if>>부서관리자</option>
											<option value="0004" <c:if test="${i.DEPT_NO eq data.EMP_GRD_CD}">selected</c:if>>일반</option>
										</select>
                                    </div>
                                </div>
                                 <div class="form-group row">
                                    <label for="use_yn" class="col-md-2 col-form-label text-md-left">급무여부</label>
                                    <div class="col-md-6">
                                    	<input type="checkbox" name="use_yn" id="use_yn"  value= "${data.USE_YN}" <c:if test="${data.USE_YN eq 'Y'}">checked</c:if>/>근무중
                                    </div>
                                </div>
                                
                                <div class="border" style="padding: 15px;">
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
	 	<c:forEach items="${memberDeptList}" var="j">
			$("input[name=mng_dept_no][value=${j.DEPT_NO}]").prop("checked",true);
		</c:forEach>
	</script>
	<form name="viewForm" method="post">
		<input type="hidden" name="emp_no"/>
		<input type="hidden" name="gubun"/> 
	</form>

   