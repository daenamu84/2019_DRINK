<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.js"></script>


<script>
var ajaxFlag = false;

	$(function() {
	});	

	$(document).ready(function(){
		
		$('.summernote').summernote({
			height: 400,
			toolbar: []
			
		});
		$('.summernote').summernote('disable');
		
		
		//댓글
		$("#comment_write").click(function(){
			var _comment = $("#comment").val();
			var _appr_no = $("#appr_no").val();
			if(ajaxFlag)return;
			ajaxFlag=true;
			
			if(_comment==""){
				alert("댓글을 입력사에요");
				ajaxFlag=false;
				return;
			}
			
			$("#comment").val("");
			
			$.ajax({      
			    type:"GET",  
			    url:"/approvalCommentInsert?comment="+_comment+"&appr_no="+_appr_no,     
			    dataType:"html",
			    traditional:true,
			    success:function(args){   
			    	$("#comment_list").html(args);
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    }  
			});
		});
	
		$("#approva_ok").click(function(){
			if(ajaxFlag)return;
			ajaxFlag=true;
			
			apSingIn($("#appr_no").val(),"01");
		});
		
		$("#approva_no").click(function(){
			if(ajaxFlag)return;
			ajaxFlag=true;
			
			apSingIn($("#appr_no").val(),"02");
		});
	
	});
	
	function apSingIn(_apprNo, _type){
		$.ajax({      
		    type:"POST",  
		    url:"/ApprovalSingIn",
		    data: JSON.stringify({"_apprNo":_apprNo,"_type":_type}),
		    dataType:"json",
		    contentType:"application/json;charset=UTF-8",
		    traditional:true,
		    success:function(args){   
		        if(args.returnCode == "0000"){
		        	alert(args.message.replace(/<br>/gi,"\n"));
		        	location.href="/ApprovalList";
		        }else{
		        	alert(args.message.replace(/<br>/gi,"\n"));
		        	location.href="/ApprovalList";
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
	}
	
	function Delete_comment(_comment_no,_c_appr_no){
	
		if(ajaxFlag)return;
		ajaxFlag=true;
		
		
		$("#comment").val("");
		
		$.ajax({      
		    type:"GET",  
		    url:"/approvalCommentDelete?comment_no="+_comment_no+"&appr_no="+_c_appr_no,     
		    dataType:"html",
		    traditional:true,
		    success:function(args){   
		    	$("#comment_list").html(args);
		        ajaxFlag=false;
		    },   
		    error:function(xhr, status, e){  
		        ajaxFlag=false;
		    }  
		});
	}
	
	$(document).on("click","#empList li",function() {
		$("#empList li").removeClass("active");
		$(this).addClass("active");
	});

	$(document).on("click","#signList li",function() {
		$("#signList li").removeClass("active");
		$(this).addClass("active");
	});

	$(document).on("click","#siginUp",function() {
		var _signList = $("#signList  li.active");
		for(var i=0; i<_signList.length; i++){
			var _bf = $(_signList[i]).prev();
			$(_signList[i]).insertBefore(_bf);
		}
	});
	$(document).on("click","#signDown",function() {
		var _signList = $("#signList  li.active");
		for(var i=0; i<_signList.length; i++){
			var _bf = $(_signList[i]).next();
			$(_signList[i]).insertAfter(_bf);
		}
	});
	$(document).on("click","#signDel",function() {
		var _signList = $("#signList  li.active");
		for(var i=0; i<_signList.length; i++){
			$(_signList[i]).remove();
		}
	});
	
	
	
	
	function display_appdoc(){
		var _appr_divs_cd = $("#appr_divs_cd option:selected").val();
		
		if(_appr_divs_cd=="1000"){
			$("#app_doc1").hide();
			$("#app_doc2").hide();
			$("#app_doc3").hide();
		}else{
			$("#app_doc1").show();
			$("#app_doc2").show();
			$("#app_doc3").show();
		}
	}
	function Set_Appr_ref_nm(appr_ref_no, appr_ref_nm){
		$("#appr_ref_no").val(appr_ref_no);
		$("#appr_ref_nm").val(appr_ref_nm);
		$("#apporval_doc").modal("hide");
	}		
	
	function FileClick(a){
		$('#file'+a).click();
	}
	
	
	
	$(document).on("click", "#approvalList", function() {
		window.location.href = "/ApprovalList";
	});
	
	
	
</script>

<div class="">
	<div class="container-fluid">
	<form name="Form"  method="post">
		<div class="row">			
			<div class="col">
				<div class="container title"> ◈  전자결재 기안</div>
				<div class="container border">
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">기안명</span></div>
						<div class="col-12 col-sm-10">
							<input type="text"  name="appr_nm" id="appr_nm" class="form-control" value="${data.APPR_NM}" autocomplete="off" readonly/>
							<input type="hidden" name="appr_no" id ="appr_no" value="${data.APPR_NO}"/>
						</div>
					</div>
					<div class="row" >
						<div class="col-12 col-sm-2"><span class="align-middle">결재구분</span></div>
						<div class="col-12 col-sm-2">
							<input type="text"  name="appr_divs_cd_nm" id="appr_divs_cd_nm" class="form-control" value="${data.APPR_DIVS_CD_NM}" autocomplete="off" readonly/>
						</div>
						<div class="col-12 col-sm-2" id="app_doc1"><span class="align-middle">연결문서</span></div>
						<div class="col-12 col-sm-4" id="app_doc2">
							<input type="text"  name="appr_ref_nm" id="appr_ref_nm" class="form-control"  value="${data.APPR_REF_NM}" autocomplete="off" readonly/>
						</div>
					</div>
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">결재자</span></div>
						<c:forEach items="${approvalSignUser}" var="g" varStatus="status">	
					  		<div class="col-12 col-sm-2">
								<input type="text"    name="appSign" value="${g.EMP_NM}<c:if test="${g.APPR_STUTS_CD_NM ne '결재중'}">(${g.APPR_STUTS_CD_NM})</c:if>"
								id="appSign1" class="form-control" readonly autocomplete="off"/>
								<input type="hidden"  name="appSignEmp" id="appSignEmp1" value="${g.APPR_SIGN_EMP_NO}"  class="form-control" readonly autocomplete="off"/>
							</div>
					  	</c:forEach>
					  	<div>
					  		<c:if test="${loginSession.emp_grd_cd ne '0004' and data.APPR_STUS_CD eq '0001' and data.D_APPR_STUS_CD eq '0001'}">
						  		<input class="btn btn-dark" type="button" value="결재" id="approva_ok">
						  		<input class="btn btn-dark" type="button" value="반려" id="approva_no">
					  		</c:if>
					  	</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px;">	
			<div class="col">
				<div class="container" style="padding:0;">
					<textarea name="for_appr_cntn" class="summernote">${data.FOR_APPR_CNTN}</textarea>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px;">	
			<div class="col">
				<div class="container border" style="padding: 5px;">
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">첨부파일</span></div>
						<div class="col-12 col-sm-10">
							<a href="/upload/${data1.REG_FILE_NM}" target="_blank">${data1.REG_FILE_NM}</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px;">
			<div class="col">
				<div class="container" style="padding: 5px;">
					<table class="table">
						<tbody id="comment_list">
							<c:forEach items="${approvalComment}" var="z" varStatus="status">
								<tr>
									<td>${z.EMP_NM}</td>
									<td>
										${z.COMMENT} (${z.DATA_REG_DTM})&nbsp;
										<c:if test="${loginSession.emp_no eq z.EMP_NO}">	
											<input class="btn btn-secondary btn-sm float-right" type="button" value="삭제" onClick="Delete_comment('${z.COMMENT_NO}','${z.APPR_NO}')" >
										</c:if>
										<input type="hidden"  name="comment_no" id="comment_no" value="${z.COMMENT_NO}"/>
										<input type="hidden"  name="c_appr_no" id="c_appr_no" value="${z.APPR_NO}"/>
									</td>
								</tr>
							</c:forEach>
						</tbody>
						<tbody>
							<tr>
								<td colspan="2">
									<input type="text" name="comment" id="comment" class="form-control" style="width: 90%;display: inline-block;">
									<input class="btn btn-secondary btn-sm" type="button" value="댓글작성" id="comment_write" >
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top: 10px;">
			<div class="col">
				<div class="container " style="padding: 5px;">
					<div class="text-md-right">
						<input type="hidden" name="gubun" value="${gubun}" id="gubun">
						<input class="btn btn-dark" type="button" value="목록" id="approvalList">
					</div>
				</div>

			</div>
		</div>
	</form>
	</div>
	
	


</div>