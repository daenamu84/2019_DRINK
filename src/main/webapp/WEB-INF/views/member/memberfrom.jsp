<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
	
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
			var use_yn = $("#use_yn").val();
			
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
			
			if(duplicatecheck.replace(/^\s*/,"") ==""){
				alert("중복체크를 하세요.");
				ajaxFlag=false;
				return;
			}
			
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
		
			$.ajax({      
			    type:"POST",  
			    url:"/memberWork",      
			    data: JSON.stringify({"deptno":deptno,"emp_nm":emp_nm,"login_id":login_id,"login_pwd":login_pwd,"emp_hp_no":emp_hp_no,"zip_cd":zip_cd,"emp_addr":emp_addr,"emp_birth":emp_birth,"entco_dt":entco_dt,"emp_grd_cd":emp_grd_cd,"use_yn":use_yn,"mng_dept_no":checkArr }),
			    dataType:"json",
			    contentType:"application/json;charset=UTF-8",
			    traditional:true,
			    success:function(args){   
			        if(args.returnCode == "0000"){
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	location.replace("/memberList");
			        }else{
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	location.replace("/memberList");
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
	
	</script>
	
	<div class="title"> ◈  사원등록</div>
	<div class="container " style="max-width:100%;">
		<div class="row">
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<div class="container border" style="padding: 15px;">
								<form name="my-form"   method="post">
                                <div class="form-group row">
                                    <label for="deptno" class="col-md-2 col-form-label text-md-left">팀</label>
                                    <div class="col-md-6">
                                    	<select name="deptno" class="form-control" id="deptno">
											<c:forEach items="${deptMMList}" var="i">
												<option value="${i.DEPT_NO}">${i.TEAMNM} </option>
											</c:forEach>
										</select>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="emp_nm" class="col-md-2 col-form-label text-md-left">이름</label>
                                    <div class="col-md-6">
                                    	<input type="text" id="emp_nm" class="form-control" name="emp_nm">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="login_id" class="col-md-2 col-form-label text-md-left">아이디</label>
                                    <div class="col-md-6">
                                    	<input type="text" id="login_id"  name="login_id" style="width:30%"> <input class="btn btn-dark" type="button" value="중복체크" id="checkloginid"/>
                                    	<input type="hidden" name="duplicatecheck" id="duplicatecheck"/><span id="msg" style="display:none">사용가능한 ID 입니다.</span>
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
                                        <input type="text" id="emp_hp_no" class="form-control" name="emp_hp_no">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="emp_addr" class="col-md-2 col-form-label text-md-left">주소</label>
                                    <div class="col-md-6">
                                        <input type="text" id="zip_cd" class="form-control" name="zip_cd" style="width:30%"><br>
                                        <input type="text" id="emp_addr" class="form-control" name="emp_addr"><br>
                                    </div>
                                </div>
								
								<div class="form-group row">
                                    <label for="emp_birth" class="col-md-2 col-form-label text-md-left">생일</label>
                                    <div class="col-md-6">
                                        <input type="text" id="emp_birth" class="form-control" name="emp_birth">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="entco_dt" class="col-md-2 col-form-label text-md-left">입사일</label>
                                    <div class="col-md-6">
                                        <input type="text" id="entco_dt" class="form-control" name="entco_dt">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="emp_grd_cd" class="col-md-2 col-form-label text-md-left">사원등급</label>
                                    <div class="col-md-6">
                                        <select name="emp_grd_cd" class="form-control" id="emp_grd_cd">
											<option value="0001">ADMIN</option>
											<option value="0002">슈퍼관리자</option>
											<option value="0003">부서관리자</option>
											<option value="0004">일반</option>
										</select>
                                    </div>
                                </div>
                                 <div class="form-group row">
                                    <label for="use_yn" class="col-md-2 col-form-label text-md-left">급무여부</label>
                                    <div class="col-md-6">
                                    	<input type="checkbox" name="use_yn" id="use_yn" value="Y" checked/>근무중
                                    </div>
                                </div>
                                
                                <div class="border" style="padding: 15px;">
                                  		관리할 팀을 선택 해 주세요<br>
                                    
                                    <c:forEach items="${deptMMList}" var="i">
										<input type="checkbox" id="mng_dept_no" name="mng_dept_no" value="${i.DEPT_NO}"> ${i.TEAMNM} <br>											
									</c:forEach>
                                    
                                </div>

								<div class="text-md-right">
										<button type="submit" class="btn btn-dark"  id="memberWork">등록</button>
                                </div>
								</form>
                             </div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



   