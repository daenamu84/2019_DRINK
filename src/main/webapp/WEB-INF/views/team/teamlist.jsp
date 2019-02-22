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
		
		$("#deptInsert").click(function(){
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
			    url:"/teamWork",      
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
		
	});
	
	function fnCopy(deptno,teamnm,use_yn){
		$("#deptno").val(deptno);
		$("#teamnm").val(teamnm);
		$("#use_yn").val(use_yn).prop("selected", true);
	}
	</script>

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
												<td>팀명</td>
												<td style="padding-left:20px;"><input type="text" class="form-control" name="teamnm" id="teamnm"></td>
												<td style="padding-left:20px;">사용여부</td>
												<td style="padding-left:20px;"><select name="use_yn" class="form-control" id="use_yn">
													<option value="Y">사용</option>
													<option value="N">사용안함</option>
												</select></td>
												<td>
													<input type="hidden" name="deptno" id="deptno"/>
													<input class="btn btn-dark" type="button" value="등록" id="deptInsert"/>
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
						      <th scope="col">팀 ID</th>
						      <th scope="col">팀명</th>
						      <th scope="col">사용여부</th>
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
</div>


   