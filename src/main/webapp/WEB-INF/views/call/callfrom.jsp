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
	var ajaxFlag = false;
	// 한글입력막기 스크립트
	$( function(){
		$("#login_id" ).on("blur keyup", function() {
			$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
		});
	})
	
	function getTeamList(){
		if(ajaxFlag)return;
		ajaxFlag=true;
		var deptno = "";
		<%if(request.getParameter("gubun") !=null){ %>
		deptno = $("#deptno option:selected").val();
		<%}else{%>
		deptno = '${data.DEPT_NO}';
		<%}%>
		$.ajax({      
		    type:"POST",  
		    url:"/Dept_EmpList",      
		    data: {"deptno":deptno,"empno": '${data.EMP_NO}'},
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
	
	function wholesalevendo(e){
		
		if(e.value =='N'){
			$("#wholesale_vendor_area").show();
		}
		if(e.value =='Y'){
			$("#wholesale_vendor_area").hide();
			$("#wholesale_vendor_no").val("");
			$("#wholesale_vendor_nm").val("");
		}
	}
	
	$(document).on("click","#vendorInsert", function(){
		
		
		if(ajaxFlag)return;
		ajaxFlag=true;
		
		if($("#outlet_nm").val() ==""){
			alert("거래처명을 입력하세요");
			ajaxFlag=false;
			return;
		}
		
		if($("#vendor_grd_cd option:selected").val() == ""){
			alert("거래처 등급을  선택 하세요");
			ajaxFlag=false;
			return;
		}
		
		if($("#vendor_area_cd option:selected").val() == ""){
			alert("거래처 지역을  선택 하세요");
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
		
		if($("#wholesale_yn option:selected").val() == ""){
			alert("도매장여부 선택 하세요");
			ajaxFlag=false;
			return;
		}
		
		
		if($("#gov_rel_d option:selected").val() == ""){
			alert("공직자관련여부  선택 하세요");
			ajaxFlag=false;
			return;
		}
		
		var gubun = $("#gubun").val();
		
		if(gubun ==""){ 
			document.Form.action="/vendorInsert";
		}else{
			document.Form.action="/vendorUpdate";
		}
		document.Form.submit();
	});
	
	$(document).on("click","#wholesale_vendor_no", function(){
		console.log("도매장 검색");
		if(ajaxFlag)return;
		ajaxFlag=true;
		$("#subLayer").empty();
		$("#popLayer").modal("show");
		
		$.ajax({      
		    type:"GET",  
		    url:"/wholesaleVendorList",      
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
		
	});
	
	function subListView(vendor_no, outlet_nm){
		$("#wholesale_vendor_no").val(vendor_no);
		//$("#wholesale_vendor_nm").val(outlet_nm);
		$("#popLayer").modal('hide');
	}
	
	</script>
	
	
	<div class="container " style="max-width:100%;">
		<div class="row">
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<form name="Form"  method="post">
							<div class="container" style="padding: 15px;">◈  콜 등록 </div>
							<div class="container border" style="padding: 15px;">
								<div class="form-group row">
                                	<label for="outlet_nm" class="col-md-2 col-form-label text-md-left"><font color="red">*</font>거래처명 </label>
                                    <div class="col-md-6">
                                    	<input type="text" id="outlet_nm" class="form-control" name="outlet_nm" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.OUTLET_NM}">
                                    	
                                    	<%if(request.getParameter("gubun")!=null){ %>
                                    		<input type="hidden" name="vendor_no" id="vendor_no"  value="${data.VENDOR_NO}"/>
                                    	<%}else{ %>
                                    	<%} %>
                                    </div>
                                </div>
                                <%if(request.getParameter("gubun")!=null){ %>
                                <div class="form-group row">
                                	<label for="vendor_stat_cd" class="col-md-2 col-form-label text-md-left"><font color="red">*</font>거래처 상태 </label>
                                    <div class="col-md-6">
                                    	<c:if test="${loginSession.emp_grd_cd ne '0004' }">
                                    	<select name="vendor_stat_cd" class="form-control" id="vendor_stat_cd" >
											<c:forEach items="${vendorstatList}" var="z">
											<option value="${z.CMM_CD}" <c:if test="${z.CMM_CD eq data.VENDOR_STAT_CD}">selected</c:if>>${z.CMM_CD_NM} </option>
											</c:forEach>
										</select>
										</c:if>
										<c:if test="${loginSession.emp_grd_cd eq '0004' }">
											<input type="hidden" name="vendor_stat_cd" value="${data.VENDOR_STAT_CD}" id="vendor_stat_cd"/>
											${data.VENDOR_STAT_NM}
										</c:if>
									</div>
                                </div>
                                
                                <%} %>
                                <div class="form-group row">
                                    <label for="vendor_grd_cd" class="col-md-2 col-form-label text-md-left"><font color="red">*</font>거래처 등급</label>
                                    <div class="col-md-6">
                                    	<select name="vendor_grd_cd" class="form-control" id="vendor_grd_cd" >
											<option value="">선택하세요</option>
											<c:forEach items="${vendorgrdcdList}" var="a">
											<option value="${a.CMM_CD}" <c:if test="${a.CMM_CD eq data.VENDOR_GRD_CD}">selected</c:if>>${a.CMM_CD_NM} </option>
											</c:forEach>
										</select>
                                    </div>
                                </div>
                                 <div class="form-group row">
                                    <label for="vendor_area_cd" class="col-md-2 col-form-label text-md-left"><font color="red">*</font>거래처 지역</label>
                                    <div class="col-md-6">
                                    	<select name="vendor_area_cd" class="form-control" id="vendor_area_cd" >
											<option value="">선택하세요</option>
											<c:forEach items="${vendorareacdMap}" var="b">
											<option value="${b.CMM_CD}" <c:if test="${b.CMM_CD eq data.VENDOR_AREA_CD}">selected</c:if>>${b.CMM_CD_NM} </option>
											</c:forEach>
										</select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="vendor_brno" class="col-md-2 col-form-label text-md-left">사업자등록번호</label>
                                    <div class="col-md-6"><input type="text" id="vendor_brno" class="form-control" name="vendor_brno" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.VENDOR_BRNO}"></div>
                                </div>
                                <div id="wrap4" style="display:none; border:1px solid; width:570px; height:440px; margin:50px 0px 0px 73px; position:absolute; z-index:10;">
									<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldPostcode('4')" alt="접기 버튼">
								</div>
                                <div class="form-group row">
                                    <label for="vendor_addr" class="col-md-2 col-form-label text-md-left">주소</label>
                                    <div class="col-md-6">
                                    	<input type="text" id="vendor_zip_no" class="form-control"  style="width:30%;display:initial;" name="vendor_zip_no" readonly  value="${data.VENDOR_ZIP_NO}">
                                    	<input class="btn btn-dark" type="button" value="우편번호"  onclick="execPostcode('4')" style="margin-top: -5px;"/>
                                    	<input type="text" id="vendor_addr" class="form-control"  name="vendor_addr"   value="${data.VENDOR_ADDR}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="deptno" class="col-md-2 col-form-label text-md-left"><font color="red">*</font>관리 팀</label>
                                    <div class="col-md-6">
                                    	<select name="deptno" class="form-control" id="deptno" onchange="getTeamList();">
											<option value="">선택하세요</option>
											<c:forEach items="${deptMngList}" var="c">
											<option value="${c.DEPT_NO}" <c:if test="${c.DEPT_NO eq data.DEPT_NO}">selected</c:if>>${c.TEAMNM} </option>
											</c:forEach>
										</select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="teamno" class="col-md-2 col-form-label text-md-left"><font color="red">*</font> 관리담당자
                                    	<input type="hidden" name="empno1" id="empno1"/>
                                    	<input type="hidden" name="ext_emp_no" id="ext_emp_no" value="${data.EMP_NO}"/>
                                    </label>
                                    <div class="col-md-6" id="empList">
                                    	
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="vendor_tel_no" class="col-md-2 col-form-label text-md-left"><font color="red">*</font> 전화번호 </font></label>
                                    <div class="col-md-6">
                                    	<input type="text" id="vendor_tel_no" class="form-control" name="vendor_tel_no"  value="${data.VENDOR_TEL_NO}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="vendor_url" class="col-md-2 col-form-label text-md-left">홈페이지</label>
                                    <div class="col-md-6">
                                    	<input type="text" id="vendor_url" class="form-control" name="vendor_url"  value="${data.VENDOR_URL}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="market_divs_cd" class="col-md-2 col-form-label text-md-left">Market</label>
                                    <div class="col-md-6">
                                    	<select name="market_divs_cd" class="form-control" id="market_divs_cd">
											<c:forEach items="${marketMap}" var="d">
												<option value="${d.CMM_CD}" <c:if test="${d.CMM_CD eq data.MARKET_DIVS_CD}">selected</c:if>>${d.CMM_CD_NM} </option>
											</c:forEach>
										</select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="vendor_sgmt_divs_cd" class="col-md-2 col-form-label text-md-left">Segmentation</label>
                                    <div class="col-md-6">
                                    	<select name="vendor_sgmt_divs_cd" class="form-control" id="vendor_sgmt_divs_cd">
											<c:forEach items="${sgmtMap}" var="e">
												<option value="${e.CMM_CD}" <c:if test="${e.CMM_CD eq data.VENDOR_SGMT_DIVS_CD}">selected</c:if>>${e.CMM_CD_NM} </option>
											</c:forEach>
										</select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="vendor_rrno" class="col-md-2 col-form-label text-md-left">주민번호</label>
                                    <div class="col-md-6"><input type="text" id="vendor_rrno" class="form-control" name="vendor_rrno"  value="${data.VENDOR_RRNO}"></div>
                                </div>
                                <div class="form-group row">
                                    <label for="wholesale_yn" class="col-md-2 col-form-label text-md-left"><font color="red">*</font> 도매장여부</label>
                                    <div class="col-md-6">
                                    	<select name="wholesale_yn" id="wholesale_yn" onchange="wholesalevendo(this)" <%if(request.getParameter("gubun")!=null){ %> disabled <%} %> >
                                    		<option value="">선택하세요</option>
                                    		<option value="Y" <c:if test="${'Y' eq data.WHOLESALE_YN}">selected</c:if>>Y</option>
                                    		<option value="N" <c:if test="${'N' eq data.WHOLESALE_YN}">selected</c:if>>N</option>
                                    	</select>
                                    </div>
                                </div>
                                <div class="form-group row" id="wholesale_vendor_area" style="display:none">
                                    <label for="wholesale_vendor_no" class="col-md-2 col-form-label text-md-left">도매장</label>
                                    <div class="col-md-6">
                                    	<input type="text" id="wholesale_vendor_no" class="form-control" readonly name="wholesale_vendor_no"  value="${data.WHOLESALE_VENDOR_NO}" >
                                    </div>
                                </div>
                                 <div class="form-group row">
                                    <label for="gov_rel_d" class="col-md-2 col-form-label text-md-left"><font color="red">*</font> 공직자관련여부</label>
                                    <div class="col-md-6">
                                    	<select name="gov_rel_d" id="gov_rel_d">
                                    		<option value="">선택하세요</option>
                                    		<option value="Y" <c:if test="${'Y' eq data.GOV_REL_D}">selected</c:if>>Y</option>
                                    		<option value="N" <c:if test="${'N' eq data.GOV_REL_D}">selected</c:if>>N</option>
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
                                    <div class="col-md-6"><input type="text" id="bank_nm" class="form-control" name="bank_nm"   value="${data.BANK_NM}"></div>
                                </div>
                                <div class="form-group row">
                                    <label for="bank_nm" class="col-md-2 col-form-label text-md-left">예금주</label>
                                    <div class="col-md-6"><input type="text" id="bank_accnt_nm" class="form-control" name="bank_accnt_nm"   value="${data.BANK_ACCNT_NM}"></div>
                                </div>
                                <div class="form-group row">
                                    <label for="bank_nm" class="col-md-2 col-form-label text-md-left">계좌번호</label>
                                    <div class="col-md-6"><input type="text" id="bank_accnt_no" class="form-control" name="bank_accnt_no"  value="${data.BANK_ACCNT_NO}"></div>
                                </div>
                                 <div class="form-group row">
                                    <label for="bank_nm" class="col-md-2 col-form-label text-md-left">지급기한</label>
                                    <div class="col-md-6"><input type="text" id="payment_term" class="form-control" name="payment_term"   value="${data.PAYMENT_TERM}"></div>
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
												<c:forEach items="${relrdivscdMap}" var="f">
													<option value="${f.CMM_CD}" <c:if test="${f.CMM_CD eq data.RELR_DIVS_CD}">selected</c:if>>${f.CMM_CD_NM} </option>
												</c:forEach>
												</select>
											</td>
											<td><input type="text" id="relr_nm" class="form-control"  name="relr_nm"   value="${data.RELR_NM}"> </td>
											<td><input type="text" id="relr_postion_nm" class="form-control"  name="relr_postion_nm"   value="${data.RELR_POSTION_NM}"></td>
											<td><input type="text" id="relr_dept_nm" class="form-control"  name="relr_dept_nm"  value="${data.RELR_DEPT_NM}"></td>
											<td><input type="text" id="relr_tel_no" class="form-control"  name="relr_tel_no"   value="${data.RELR_TEL_NO}"></td>
											<td><input type="text" id="relr_email" class="form-control"  name="relr_email"  value="${data.RELR_EMAIL}"></td>
											<td><input type="text" id="relr_anvs_dt" class="form-control"  name="relr_anvs_dt"  value="${data.RELR_ANVS_DT}"></td>
											<td><input type="text" id="etc" class="form-control"  name="etc"   value="${data.ETC}"></td>
										</tr>
									</tbody> 
								</table>
								<div class="text-md-right">
								<input type="hidden" name="gubun" value="${gubun}" id="gubun">
								<input class="btn btn-dark" type="button" value="등록" id="vendorInsert">
                            	</div>
							</div>
							
                            </form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- modal start  -->	
	<div id="popLayer" class="modal fade" role="dialog" data-backdrop="static">
		<div class="modal-dialog modal-xl">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">도매장 검색</h5>
		        	<a href="#" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
				</div>
				<div class="modal-body" id="subLayer">
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
<!-- modal  end  -->
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

   <script>
    <c:if test="${'N' eq data.WHOLESALE_YN}">
	$("#wholesale_vendor_area").show(); 
	</c:if>
	
	<%if(request.getParameter("gubun") !=null){ %>
	getTeamList();
	<%}%>
	
	<c:if test="${returnCode eq '0000'}">
 		alert("수정 하였습니다.");
	</c:if>

   </script>
   