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
	var ajaxFlag = false;
	// 한글입력막기 스크립트
	$( function(){
		$("#login_id" ).on("blur keyup", function() {
			$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
		});
	})
	
	function getTeamList(e){
		if(ajaxFlag)return;
		ajaxFlag=true;
		var deptno= $("#deptno option:selected").val();
		
		$.ajax({      
		    type:"POST",  
		    url:"/Dept_EmpList",      
		    data: {"deptno":deptno},
		    dataType:"html",
		    traditional:true,
		    success:function(args){   
		        $("#empList").empty();
		        $("#empList").html(args);
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
		
	}
	
	$(document).on("click","#vendorInsert", function(){
		if(ajaxFlag)return;
		ajaxFlag=true;
		
		if($("#outlet_nm").val() ==""){
			alert("거래처명을 입력하세요");
			ajaxFlag=false;
			return;
		}
		
		var empno= $("#empno option:selected").val();
		$("#empno1").val(empno);
		
		if(($("#empno1").val())==""){
			alert("관리 담당자를 선택 세요");
			ajaxFlag=false;
			return;
		}
		
		if($("#vendor_tel_no").val() ==""){
			alert("전화번호를 입력하세요");
			ajaxFlag=false;
			return;
		}
		
		document.Form.action="/vendorInsert";
		document.Form.submit();
	});
	
	</script>
	
	<div class="container " style="max-width:100%;">
		<div class="row">
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<form name="Form"  method="post">
							<div class="container" style="padding: 15px;"> <%if(request.getParameter("gubun")==null){ %>◈  거래처 기본 정보 등록 <%}else{ %>◈  ◈  거래처 기본 정보 수정 <%} %></div>
							<div class="container border" style="padding: 15px;">
								<div class="form-group row">
                                	<label for="outlet_nm" class="col-md-2 col-form-label text-md-left"><font color="red">*</font>거래처명 </label>
                                    <div class="col-md-6"><input type="text" id="outlet_nm" class="form-control" name="outlet_nm" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.OUTLET_NM}"></div>
                                </div>
                                <div class="form-group row">
                                    <label for="vendor_brno" class="col-md-2 col-form-label text-md-left">사업자등록번호</label>
                                    <div class="col-md-6"><input type="text" id="vendor_brno" class="form-control" name="vendor_brno" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.VENDOR_BRNO}"></div>
                                </div>
                                <div class="form-group row">
                                    <label for="vendor_addr" class="col-md-2 col-form-label text-md-left">주소</label>
                                    <div class="col-md-6">
                                    	<input type="text" id="vendor_zip_no" class="form-control"  style="width:30%" name="vendor_zip_no" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.VENDOR_ZIP_NO}">
                                    	<input type="text" id="vendor_addr" class="form-control"  name="vendor_addr" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.OUTLET_NM}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="deptno" class="col-md-2 col-form-label text-md-left"><font color="red">*</font>관리 팀</label>
                                    <div class="col-md-6">
                                    	<select name="deptno" class="form-control" id="deptno" onchange="getTeamList(event);">
											<option value="ALL">전체</option>
											<c:forEach items="${deptMngList}" var="i">
											<option value="${i.DEPT_NO}">${i.TEAMNM} </option>
											</c:forEach>
										</select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="teamno" class="col-md-2 col-form-label text-md-left"><font color="red">*</font> 관리담당자
                                    	<input type="hidden" name="empno1" id="empno1"/>
                                    </label>
                                    <div class="col-md-6" id="empList">
                                    	
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="vendor_tel_no" class="col-md-2 col-form-label text-md-left"><font color="red">*</font> 전화번호 </font></label>
                                    <div class="col-md-6">
                                    	<input type="text" id="vendor_tel_no" class="form-control" name="vendor_tel_no" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.VENDOR_TEL_NO}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="vendor_url" class="col-md-2 col-form-label text-md-left">홈페이지</label>
                                    <div class="col-md-6">
                                    	<input type="text" id="vendor_url" class="form-control" name="vendor_url" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.VENDOR_URL}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="market_divs_cd" class="col-md-2 col-form-label text-md-left">Market</label>
                                    <div class="col-md-6">
                                    	<select name="market_divs_cd" class="form-control" id="market_divs_cd">
											<c:forEach items="${marketMap}" var="k">
												<option value="${k.CMM_CD}">${k.CMM_CD_NM} </option>
											</c:forEach>
										</select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="vendor_sgmt_divs_cd" class="col-md-2 col-form-label text-md-left">Segmentation</label>
                                    <div class="col-md-6">
                                    	<select name="vendor_sgmt_divs_cd" class="form-control" id="vendor_sgmt_divs_cd">
											<c:forEach items="${sgmtMap}" var="l">
												<option value="${l.CMM_CD}">${l.CMM_CD_NM} </option>
											</c:forEach>
										</select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="vendor_rrno" class="col-md-2 col-form-label text-md-left">주민번호</label>
                                    <div class="col-md-6"><input type="text" id="vendor_rrno" class="form-control" name="vendor_rrno" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.VENDOR_RRNO}"></div>
                                </div>
                                <div class="form-group row">
                                    <label for="wholesale_vendor_no" class="col-md-2 col-form-label text-md-left">도매장</label>
                                    <div class="col-md-6">
                                    	<input type="text" id="wholesale_vendor_no" class="form-control" name="wholesale_vendor_no"   value="${data.WHOLESALE_VENDOR_NO}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="wholesale_vendor_no" class="col-md-2 col-form-label text-md-left"><font color="red">*</font> 도매장여부</label>
                                    <div class="col-md-6">
                                    	<select name="wholesale_yn" id="wholesale_yn">
                                    		<option value="Y">Y</option>
                                    		<option value="N">N</option>
                                    	</select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="gov_rel_d" class="col-md-2 col-form-label text-md-left"><font color="red">*</font> 공직자관련여부</label>
                                    <div class="col-md-6">
                                    	<select name="gov_rel_d" id="gov_rel_d">
                                    		<option value="Y">Y</option>
                                    		<option value="N">N</option>
                                    	</select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="gov_rel_cntn" class="col-md-2 col-form-label text-md-left">관계내용</label>
                                    <div class="col-md-6">
                                    	<input type="text" id="gov_rel_cntn" class="form-control" name="gov_rel_cntn"   value="${data.GOV_REL_CNTN}">
                                    </div>
                                </div>
							</div>
                            <div class="container" style="padding: 15px;">◈  거래처 은행 정보</div>
                            <div class="container border" style="padding: 15px;">
								<div class="form-group row">
                                	<label for="bank_nm" class="col-md-2 col-form-label text-md-left">은행명</label>
                                    <div class="col-md-6"><input type="text" id="bank_nm" class="form-control" name="bank_nm" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.BANK_NM}"></div>
                                </div>
                                <div class="form-group row">
                                    <label for="bank_nm" class="col-md-2 col-form-label text-md-left">예금주</label>
                                    <div class="col-md-6"><input type="text" id="bank_accnt_nm" class="form-control" name="bank_accnt_nm" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.BANK_ACCNT_NM}"></div>
                                </div>
                                <div class="form-group row">
                                    <label for="bank_nm" class="col-md-2 col-form-label text-md-left">계좌번호</label>
                                    <div class="col-md-6"><input type="text" id="bank_accnt_no" class="form-control" name="bank_accnt_no" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.BANK_ACCNT_NO}"></div>
                                </div>
                                 <div class="form-group row">
                                    <label for="bank_nm" class="col-md-2 col-form-label text-md-left">지급기한</label>
                                    <div class="col-md-6"><input type="text" id="payment_term" class="form-control" name="payment_term" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.PAYMENT_TERM}"></div>
                                </div>
							</div>
                            <div class="container" style="padding: 15px;">◈  거래처 담당자 정보</div>
							<div class="container border" style="padding: 15px;">
								<table class="table-borderless" style="border-spacing: 0 5px;border-collapse: separate;width:100%">
									<thead>
										<tr class="text-md-center">
											<td>구분코드</td>
											<td> <font color="red">*</font> 이름</td>
											<td>직책</td>
											<td>부서명</td>
											<td><font color="red">*</font> 연락처</td>
											<td>이메일</td>
											<td>기념일</td>
											<td>메모</td>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>
												<select name="relr_divs_cd" class="form-control" id="relr_divs_cd" style="wdith:30%">
												<c:forEach items="${relrdivscdMap}" var="o">
													<option value="${o.CMM_CD}">${o.CMM_CD_NM} </option>
												</c:forEach>
												</select>
											</td>
											<td><input type="text" id="relr_nm" class="form-control"  name="relr_nm" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.RELR_NM}"> </td>
											<td><input type="text" id="relr_postion_nm" class="form-control"  name="relr_postion_nm" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.RELR_POSTION_NM}"></td>
											<td><input type="text" id="relr_dept_nm" class="form-control"  name="relr_dept_nm" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.RELR_DEPT_NM}"></td>
											<td><input type="text" id="relr_tel_no" class="form-control"  name="relr_tel_no" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.RELR_TEL_NO}"></td>
											<td><input type="text" id="relr_email" class="form-control"  name="relr_email" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.RELR_EMAIL}"></td>
											<td><input type="text" id="relr_anvs_dt" class="form-control"  name="relr_anvs_dt" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.RELR_ANVS_DT}"></td>
											<td><input type="text" id="etc" class="form-control"  name="etc" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.ETC}"></td>
										</tr>
									</tbody> 
								</table>
								<div class="text-md-right">
								<input type="hidden" name="gubun" value="${gubun}">
								<input class="btn btn-dark" type="button" value="등록" id="vendorInsert">
                            	</div>
							</div>
							
                            </form>
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

   