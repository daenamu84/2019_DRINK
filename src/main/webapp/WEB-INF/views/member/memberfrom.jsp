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
		
		$("#checkloginid").click(function(){
			if(ajaxFlag)return;
			
			var login_id = $("#login_id").val();
			
			if(login_id.replace(/^\s*/,"") ==""){
				alert("아이디를 입력하세요.");
				ajaxFlag=false;
				return;
			}
			console.log("login_id="+login_id);
			
			$.ajax({      
			    type:"POST",  
			    url:"/duplicateIDCheck",      
			    data: JSON.stringify({"login_id":login_id }),
			    dataType:"json",
			    contentType:"application/json;charset=UTF-8",
			    traditional:true,
			    success:function(args){   
			        if(args.returnCode == "0000"){
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	$("#duplicatecheck").val("OK");
			        	$("#msg").show();
			        }else{
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	//location.reload();
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
		
		
		$("#memberWork").click(function(){
			if(ajaxFlag)return;
			
			var deptno = $("#deptno").val();
			var ex_dept_no = $("#ex_dept_no").val();
			var emp_no = $("#emp_no").val();
			var emp_nm = $("#emp_nm").val();
			var login_id = $("#login_id").val();
			var duplicatecheck = $("#duplicatecheck").val();
			var login_pwd = $("#login_pwd").val();
			var emp_hp_no = $("#emp_hp_no").val();
			var zip_cd = $("#zip_cd").val();
			var emp_addr = $("#emp_addr").val();
			var emp_birth = $("#emp_birth").val();
			var entco_dt = $("#entco_dt").val();
			var emp_grd_cd = $("#emp_grd_cd").val();
			var use_yn 
			if($('input:checkbox[id="use_yn"]').is(":checked")){
				use_yn='Y';
			}else{
				use_yn='N';
			}
			
			var mng_dept_no = $("#mng_dept_no").val();
			
			if(emp_nm.replace(/^\s*/,"") ==""){
				alert("이름을  입력하세요.");
				ajaxFlag=false;
				return;
			}
			
			if(login_id.replace(/^\s*/,"") ==""){
				alert("아이디를 입력하세요.");
				ajaxFlag=false;
				return;
			}
			 <%if(request.getParameter("gubun")==null){ %>
			if(duplicatecheck.replace(/^\s*/,"") ==""){
				alert("중복체크를 하세요.");
				ajaxFlag=false;
				return;
			}
			<%}%>
			if(login_pwd.replace(/^\s*/,"") ==""){
				alert("비밀번호를  입력하세요.");
				ajaxFlag=false;
				return;
			}
			
			var checkArr = [];     // 배열 초기화
			
		    $("input[name='mng_dept_no']").each(function(i,e){
				if(this.checked){
					checkArr.push($("input[name='mng_dept_no']")[i].value);
					
				}
			});
			
		    var url = "/memberWork";
			if(emp_no!=""){
				url = "/memberUpdate";
			}
			
			$.ajax({      
			    type:"POST",  
			    url:url,      
			    data: JSON.stringify({"deptno":deptno,"emp_no":emp_no,"ex_dept_no":ex_dept_no,"emp_nm":emp_nm,"login_id":login_id,"login_pwd":login_pwd,"emp_hp_no":emp_hp_no,"zip_cd":zip_cd,"emp_addr":emp_addr,"emp_birth":emp_birth,"entco_dt":entco_dt,"emp_grd_cd":emp_grd_cd,"use_yn":use_yn,"mng_dept_no":checkArr }),
			    dataType:"json",
			    contentType:"application/json;charset=UTF-8",
			    traditional:true,
			    success:function(args){   
			        if(args.returnCode == "0000"){
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	if(args.retgubun == "insert"){
			        		location.replace("/memberList");
			        	}else{
			        		//alert(0);
			        		ViewMember(emp_no,args.retgubun);	
			        	}
			        }else{
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	if(args.retgubun == "insert"){
			        		location.replace("/memberList");
			        	}else{
			        		//alert(1);
			        		//ViewMember(emp_no,args.retgubun);	
			        	}
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
		
	});
	
	function ViewMember(emp_no,gubun){
		
		document.viewForm.emp_no.value=emp_no;
		document.viewForm.gubun.value=gubun;
		
		document.viewForm.action="/memberView";
		document.viewForm.submit();
		
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
	            document.Form.emp_addr.value= data.roadAddress;
	            document.Form.zip_cd.value=data.zonecode;	
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
	
	<div class="title"> <%if(request.getParameter("gubun")==null){ %>◈  사원등록<%}else{ %>◈  사원수정<%} %></div>
	<div class="container " style="max-width:100%;">
		<div class="row">
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<div class="container border" style="padding: 15px;">
								<form name="Form"   method="post">
                                <div class="form-group row">
                                    <label for="deptno" class="col-md-2 col-form-label text-md-left">팀</label>
                                    <div class="col-md-6">
                                    	<input type="hidden" id="emp_no" name="emp_no" value="${data.EMP_NO}">
                                    	<input type="hidden" id="ex_dept_no" name="ex_dept_no" value="${data.DEPT_NO}">
                                    	<select name="deptno" class="form-control" id="deptno">
											<c:forEach items="${deptMMList}" var="i">
												<option value="${i.DEPT_NO}" <c:if test="${i.DEPT_NO eq data.DEPT_NO}">selected</c:if>>${i.TEAMNM} </option>
											</c:forEach>
										</select>
                                    </div>
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
                                    	<select name="emp_grd_cd" class="form-control" id="emp_grd_cd">
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

   