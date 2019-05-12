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
		function goPage(pages, pageLine) {
			
			$("#subLayer").empty();
			$("#popLayer").modal("show");

			$.ajax({
				type : "GET",
				url : "/wholesaleVendorList?page=" + pages + "&pageLine=" + pageLine,
				dataType : "html",
				traditional : true,
				success : function(args) {
					$("#subLayer").html(args);
				},
				error : function(xhr, status, e) {

				}
			});
		}
		
		function goPageSub(pages, pageLine) {
			var _wholesale_cd_nm = $("#_wholesale_cd_nm").val();
			
			$("#subLayer").empty();
			$("#popLayer").modal("show");
			

			$.ajax({
				type : "GET",
				url : "/wholesaleVendorList?page=" + pages + "&pageLine=" + pageLine+"&search_value="+_wholesale_cd_nm,
				dataType : "html",
				traditional : true,
				success : function(args) {
					$("#subLayer").html(args);
				},
				error : function(xhr, status, e) {

				}
			});
		}
		
		function seachWholesale() {
			var _wholesale_cd_nm = $("#_wholesale_cd_nm").val();
			alert(_wholesale_cd_nm);
			$("#subLayer").empty();
			$("#popLayer").modal("show");
			
			$.ajax({      
			    type:"GET",  
			    url:"/wholesaleVendorSearch?search_value="+_wholesale_cd_nm,     
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
		}
		
		
		// 한글입력막기 스크립트
		$( function(){
			$("#login_id" ).on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			});
		})

		function FileClick(a){
			$('#file'+a).click();
		}

		function fileUpload(e, b) {
			console.log("start");

			var file = e;

			var formData = new FormData();
			formData.append("files", e.files[0]);

			console.log(formData);

			$.ajax({
				type : "POST",
				url : "/fileUpload2",
				data : formData,
				contentType : false,
				processData : false,
				success : function(args) {
					$("#apnd_file_divs_cd" + b).val(args.data);
					//$("#empList").empty();
					//$("#empList").html(args);
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

		
		function getTeamList() {
			
			if (ajaxFlag)
				return;
			ajaxFlag = true;
			var deptno = "";
			var gubun = "<%=request.getParameter("gubun")%>";
			
			if (gubun == 'null') {
				deptno = $("#deptno option:selected").val();
			} else {
				deptno = '${data.DEPT_NO}';
			}

			$.ajax({
				type : "POST",
				url : "/Dept_EmpList",
				data : {
					"deptno" : deptno,
					"gubun" : gubun,
					"empno" : '${data.EMP_NO}'
				},
				dataType : "html",
				traditional : true,
				success : function(args) {
					$("#empList").empty();
					$("#empList").html(args);
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

		
		$(document).on("click", "#vendorList", function() {
			window.location.href = "/vendorList";
		});

		$(document).on("click", "#vendorInsert", function() {

			if (ajaxFlag)
				return;
			ajaxFlag = true;

			if ($("#vendor_nm").val() == "") {
				alert("거래처명을 입력하세요");
				ajaxFlag = false;
				return;
			}

			if ($("#vendor_grd_cd option:selected").val() == "") {
				alert("거래처 등급을  선택 하세요");
				ajaxFlag = false;
				return;
			}

			if ($("#vendor_area_cd option:selected").val() == "") {
				alert("거래처 지역을  선택 하세요");
				ajaxFlag = false;
				return;
			}

			var empno = $("#empno option:selected").val();
			$("#empno1").val(empno);

			if (($("#empno1").val()) == "") {
				alert("관리 담당자를 선택 세요");
				ajaxFlag = false;
				return;
			}

			if ($("#vendor_tel_no").val() == "") {
				alert("전화번호를 입력하세요");
				ajaxFlag = false;
				return;
			}
			
			if ($("#market_divs_cd option:selected").val() == "") {
				alert("Market을  선택 하세요");
				ajaxFlag = false;
				return;
			}
			
			
			if ($("#gov_rel_d option:selected").val() == "") {
				alert("공직자관련여부  선택 하세요");
				ajaxFlag = false;
				return;
			}

			var gubun = $("#gubun").val();

			if (gubun == "") {
				document.Form.action = "/vendorInsert";
			} else {
				document.Form.action = "/vendorUpdate";
			}
			document.Form.submit();
		});

		$(document).on("click", "#wholesale_cd_nm", function() {
			console.log("도매장 검색");
			if (ajaxFlag)
				return;
			ajaxFlag = true;
			$("#subLayer").empty();
			$("#popLayer").modal("show");

			$.ajax({
				type : "GET",
				url : "/wholesaleVendorList",
				dataType : "html",
				traditional : true,
				success : function(args) {
					$("#subLayer").html(args);
					ajaxFlag = false;
				},
				error : function(xhr, status, e) {
					ajaxFlag = false;
				}
			});

		});

		function subListView(vendor_no, vendor_nm) {
			$("#wholesale_cd").val(vendor_no);
			$("#wholesale_cd_nm").val(vendor_nm);
			//$("#wholesale_vendor_nm").val(vendor_nm);
			$("#popLayer").modal('hide');
		}
		
		function getSegment() {
			if (ajaxFlag)
				return;
			ajaxFlag = true;
			var market_divs_cd = "";
			
			market_divs_cd = $("#market_divs_cd option:selected").val();
			var  vendor_sgmt_divs_cd= "${data.VENDOR_SGMT_DIVS_CD}";
			var gubun="new";
			$.ajax({
				type : "POST",
				url : "/VendorSegList",
				data : {"market_divs_cd" : market_divs_cd, "gubun" : gubun,"_pVendor_sgmt_divs_cd":vendor_sgmt_divs_cd},
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
		
		function search_area() {
			if (ajaxFlag)
				return;
			ajaxFlag = true;
			var area1 = "";
			var area2 = "";
			var gubun = "<%=request.getParameter("gubun")%>";
				
			area2 = $("#vendor_area_cd2 option:selected").val();
			
			$.ajax({
				type : "POST",
				url : "/areaSearch",
				data : {
					"gubun" : gubun,
					"area2" : area2,
					"area1" : area1
				},
				dataType : "html",
				traditional : true,
				success : function(args) {
					$("#vendor_area_cdMap").empty();
					$("#vendor_area_cdMap").html(args);
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
	<script>
	//daum 주소
	function foldPostcode(obj) {
		var element_wrap = document.getElementById('wrap'+obj);      
	    // iframe을 넣은 element를 안보이게 한다.        
	    element_wrap.style.display = 'none';
	}

	function execPostcode(obj) {
		var element_wrap = document.getElementById('wrap'+obj);        
	    var frm = document.OrderForm;       
	    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
	    
	    var themeObj = {
	    		bgColor: "#F3F3F3", //바탕 배경색
	    		//searchBgColor: "", //검색창 배경색
	    		//contentBgColor: "", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
	    		//pageBgColor: "", //페이지 배경색
	    		textColor: "#444444", //기본 글자색
	    		//queryTextColor: "", //검색창 글자색
	    		postcodeTextColor: "#888888", //우편번호 글자색
	    		emphTextColor: "#C11353", //강조 글자색
	    		outlineColor: "#DCDCDC" //테두리
	    };
	    
	    new daum.Postcode({
	        oncomplete: function(data) {                
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            document.Form.vendor_addr.value= data.roadAddress;
	            document.Form.vendor_zip_no.value=data.zonecode;	
	            element_wrap.style.display = 'none';                
	            // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
	            document.body.scrollTop = currentScroll;                
			},          
	        width : '100%',
	        height : '100%',
	        theme: themeObj
	    }).embed(element_wrap);
	    element_wrap.style.display = 'block';
	}
	
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
                                	<label for="vendor_nm" class="col-md-2 col-form-label text-md-left"><font color="red">*</font>거래처명 </label>
                                    <div class="col-md-6">
                                    	<input type="text" id="vendor_nm" class="form-control" name="vendor_nm" <%if(request.getParameter("gubun")!=null){ %>readonly <%} %>  value="${data.VENDOR_NM}">
                                    	
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
                                    	<select name="vendor_area_cd2" class="form-control  float-left" id="vendor_area_cd2" style="width:150px" onchange="search_area();">
											<option value="">선택하세요</option>
											<c:forEach items="${vendorarea2cdMap}" var="b">
											<option value="${b.CMM_CD}" <c:if test="${b.CMM_CD eq data.VENDOR_AREA_CD2}">selected</c:if>>${b.CMM_CD_NM} </option>
											</c:forEach>
										</select>
										<div id='vendor_area_cdMap'>
											<select name="vendor_area_cd" class="form-control  " id="vendor_area_cd" style="width:150px">
												<option value="">선택하세요</option>
											</select>
										</div>
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
                                    <label for="market_divs_cd" class="col-md-2 col-form-label text-md-left"><font color="red">*</font> Market</label>
                                    <div class="col-md-6">
                                    	<select name="market_divs_cd" class="form-control" id="market_divs_cd" onchange="getSegment();">
                                    			<option value="">선택하세요</option>
											<c:forEach items="${marketMap}" var="d">
												<option value="${d.CMM_CD}" <c:if test="${d.CMM_CD eq data.MARKET_DIVS_CD}">selected</c:if>>${d.CMM_CD_NM} </option>
											</c:forEach>
										</select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="vendor_sgmt_divs_cd" class="col-md-2 col-form-label text-md-left"> <font color="red">*</font>Segmentation</label>
                                    <div class="col-md-6" id="segList">
                                    	
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="vendor_rrno" class="col-md-2 col-form-label text-md-left">주민번호</label>
                                    <div class="col-md-6"><input type="text" id="vendor_rrno" class="form-control" name="vendor_rrno"  value="${data.VENDOR_RRNO}"></div>
                                </div>
                                <div class="form-group row" id="wholesale_vendor_area">
                                    <label for="wholesale_cd" class="col-md-2 col-form-label text-md-left">도매장</label>
                                    <div class="col-md-6">
                                    	<input type="hidden" id="wholesale_cd" class="form-control" readonly name="wholesale_cd"  value="${data.WHOLESALE_CD}" >
                                    	<input type="text" id="wholesale_cd_nm" class="form-control" readonly name="wholesale_cd_nm"  value="${data.WHOLESALE_CD_NM}" >
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
							 <div class="container" style="padding: 15px;">◈  첨부파일 </div>
                            <div class="container border" style="padding: 15px;">
								<div class="form-group row">
                                	<label for="bank_nm" class="col-md-3 col-form-label text-md-left">사업자 등록증</label>
                                    <div class="col-md-6">
                                    	<input type="file" id="file1" class="fileDrop" name="file1" onchange="fileUpload(this,1);" style="width:60%;display:none;">
                                    	<input type="text" id="apnd_file_divs_cd1" class="form-control" name="apnd_file_divs_cd1" style="width:50%;display:initial;" value="${apnd_file_divs_cd1}">
                                    	<input class="btn-primary" type="button" value="파일첨부" onClick="FileClick(1)">&nbsp;<a href="/upload/${apnd_file_divs_cd1}" target="_blank">파일받기</a>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="bank_nm" class="col-md-3 col-form-label text-md-left">통장사본</label>
                                    <div class="col-md-6">
                                    	<input type="file" id="file2" class="fileDrop" name="file2" onchange="fileUpload(this,2);" style="width:60%;display:none;">
                                    	<input type="text" id="apnd_file_divs_cd2" class="form-control" name="apnd_file_divs_cd2" style="width:50%;display:initial;" value="${apnd_file_divs_cd2}">
                                    	<input class="btn-primary" type="button" value="파일첨부" onClick="FileClick(2)">&nbsp;<a href="/upload/${apnd_file_divs_cd2}" target="_blank">파일받기</a>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="bank_nm" class="col-md-3 col-form-label text-md-left">명함</label>
                                    <div class="col-md-6">
                                    	<input type="file" id="file3" class="fileDrop" name="file3" onchange="fileUpload(this,3);" style="width:60%;display:none;">
                                    	<input type="text" id="apnd_file_divs_cd3" class="form-control" name="apnd_file_divs_cd3" style="width:50%;display:initial;" value="${apnd_file_divs_cd3}">
                                    	<input class="btn-primary" type="button" value="파일첨부" onClick="FileClick(3)">&nbsp;<a href="/upload/${apnd_file_divs_cd3}" target="_blank">파일받기</a>
                                    </div>
                                </div>
                                 <div class="form-group row">
                                    <label for="bank_nm" class="col-md-3 col-form-label text-md-left">메뉴사진</label>
                                    <div class="col-md-6">
                                    	<input type="file" id="file4" class="fileDrop" name="file4" onchange="fileUpload(this,4);" style="width:60%;display:none;">
                                    	<input type="text" id="apnd_file_divs_cd4" class="form-control" name="apnd_file_divs_cd4" style="width:50%;display:initial;" value="${apnd_file_divs_cd4}">
                                    	<input class="btn-primary" type="button" value="파일첨부" onClick="FileClick(4)">&nbsp;<a href="/upload/${apnd_file_divs_cd4}" target="_blank">파일받기</a>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="bank_nm" class="col-md-3 col-form-label text-md-left">개인정보수집 및 활용 동의서</label>
                                    <div class="col-md-6">
                                    	<input type="file" id="file5" class="fileDrop" name="file5" onchange="fileUpload(this,5);" style="width:60%;display:none;">
                                    	<input type="text" id="apnd_file_divs_cd5" class="form-control" name="apnd_file_divs_cd5" style="width:50%;display:initial;" value="${apnd_file_divs_cd5}">
                                    	<input class="btn-primary" type="button" value="파일첨부" onClick="FileClick(5)">&nbsp;<a href="/upload/${apnd_file_divs_cd5}" target="_blank">파일받기</a>
                                    </div>
                                </div>
							</div>
                            <div class="container" style="padding: 15px;">◈  거래처 담당자 정보</div>
							<div class="container border" style="padding: 15px;">
								<table class="table table-borderless  text-center" style="border-spacing: 0 5px;border-collapse: separate;width:100%">
									<thead>
										<tr class="text-md-center">
											<td>구분</td>
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
									<c:if test="${gubun eq 'update'}"> 
										<c:forEach items="${vendorViewUser}" var="g" varStatus="status">	
									  		<tr>
												<td>
													<select name="relr_divs_cd" class="form-control" id="relr_divs_cd" style="wdith:30%">
													<c:forEach items="${relrdivscdMap}" var="f">
														<option value="${f.CMM_CD}" <c:if test="${f.CMM_CD eq g.RELR_DIVS_CD}">selected</c:if>>${f.CMM_CD_NM} </option>
													</c:forEach>
													</select>
													</td>
												<td><input type="text" id="relr_nm" class="form-control" style="width:80%;"  name="relr_nm"   value="${g.RELR_NM}"> </td>
												<td><input type="text" id="relr_postion_nm" class="form-control"  name="relr_postion_nm"   value="${g.RELR_POSTION_NM}"></td>
												<td><input type="text" id="relr_dept_nm" class="form-control"  name="relr_dept_nm"  value="${g.RELR_DEPT_NM}"></td>
												<td><input type="text" id="relr_tel_no" class="form-control"  name="relr_tel_no"   value="${g.RELR_TEL_NO}"></td>
												<td><input type="text" id="relr_email" class="form-control"  name="relr_email"  value="${g.RELR_EMAIL}"></td>
												<td><input type="text" id="relr_anvs_dt" class="form-control"  name="relr_anvs_dt"  value="${g.RELR_ANVS_DT}"></td>
												<td><input type="text" id="etc" class="form-control"  name="etc"   value="${g.ETC}"></td>
											</tr>
									  	</c:forEach>
									  	<c:set var="cnt"  value ="${3-fn:length(vendorViewUser)}"  />
									  	<c:forEach begin="1" end="${cnt}">
									  		<tr>
											<td>
												<select name="relr_divs_cd" class="form-control" id="relr_divs_cd" style="wdith:30%">
												<c:forEach items="${relrdivscdMap}" var="f">
													<option value="${f.CMM_CD}" <c:if test="${f.CMM_CD eq data.RELR_DIVS_CD}">selected</c:if>>${f.CMM_CD_NM} </option>
												</c:forEach>
												</select>
											</td>
											<td><input type="text" id="relr_nm" class="form-control" style="width:80%;"  name="relr_nm"   value="${data.RELR_NM}"> </td>
											<td><input type="text" id="relr_postion_nm" class="form-control"  name="relr_postion_nm"   value="${data.RELR_POSTION_NM}"></td>
											<td><input type="text" id="relr_dept_nm" class="form-control"  name="relr_dept_nm"  value="${data.RELR_DEPT_NM}"></td>
											<td><input type="text" id="relr_tel_no" class="form-control"  name="relr_tel_no"   value="${data.RELR_TEL_NO}"></td>
											<td><input type="text" id="relr_email" class="form-control"  name="relr_email"  value="${data.RELR_EMAIL}"></td>
											<td><input type="text" id="relr_anvs_dt" class="form-control"  name="relr_anvs_dt"  value="${data.RELR_ANVS_DT}"></td>
											<td><input type="text" id="etc" class="form-control"  name="etc"   value="${data.ETC}"></td>
										</tr>
									  	</c:forEach>	
									</c:if>
									<c:if test="${gubun ne 'update'}">
										<%for(int j=0; j<3;j++) {%>
										<tr>
											<td>
												<select name="relr_divs_cd" class="form-control" id="relr_divs_cd" style="wdith:30%">
												<c:forEach items="${relrdivscdMap}" var="f">
													<option value="${f.CMM_CD}" <c:if test="${f.CMM_CD eq data.RELR_DIVS_CD}">selected</c:if>>${f.CMM_CD_NM} </option>
												</c:forEach>
												</select>
											</td>
											<td><input type="text" id="relr_nm" class="form-control" style="width:80%;"  name="relr_nm"   value="${data.RELR_NM}"> </td>
											<td><input type="text" id="relr_postion_nm" class="form-control"  name="relr_postion_nm"   value="${data.RELR_POSTION_NM}"></td>
											<td><input type="text" id="relr_dept_nm" class="form-control"  name="relr_dept_nm"  value="${data.RELR_DEPT_NM}"></td>
											<td><input type="text" id="relr_tel_no" class="form-control"  name="relr_tel_no"   value="${data.RELR_TEL_NO}"></td>
											<td><input type="text" id="relr_email" class="form-control"  name="relr_email"  value="${data.RELR_EMAIL}"></td>
											<td><input type="text" id="relr_anvs_dt" class="form-control"  name="relr_anvs_dt"  value="${data.RELR_ANVS_DT}"></td>
											<td><input type="text" id="etc" class="form-control"  name="etc"   value="${data.ETC}"></td>
										</tr>
										<%} %>
										</c:if>
									</tbody> 
								</table>
								<div class="text-md-right">
								<input type="hidden" name="gubun" value="${gubun}" id="gubun">
								<input class="btn btn-dark" type="button" value="등록" id="vendorInsert">
								<input class="btn btn-dark" type="button" value="목록" id="vendorList">
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
    
	
	$(document).ready(function(){
		<%if(request.getParameter("gubun") !=null){ %>
		getTeamList();
		ajaxFlag = false;
		searchu_area();
		<%}%>
		ajaxFlag = false;
		getSegment();
		
	});
	
	<c:if test="${returnCode eq '0000'}">
 		alert("수정 하였습니다.");
	</c:if>
	function searchu_area(){
		if (ajaxFlag)
			return;
		ajaxFlag = true;
		var area1 = "";
		var area2 = "";
		var gubun = "<%=request.getParameter("gubun")%>";
		
		area1 = '${data.VENDOR_AREA_CD}';
		area2 = '${data.VENDOR_AREA_CD2}';
		
		$.ajax({
			type : "POST",
			url : "/areaSearch",
			data : {
				"gubun" : gubun,
				"area2" : area2,
				"area1" : area1
			},
			dataType : "html",
			traditional : true,
			success : function(args) {
				$("#vendor_area_cdMap").empty();
				$("#vendor_area_cdMap").html(args);
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
   