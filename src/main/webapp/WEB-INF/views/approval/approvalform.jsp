<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>


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
		
		$("#ckSign").click(function(){
			var _empList = $("#empList li.active");
			var _signList = $("#signList");
			if(_signList.find("li").length < 3){
				for(var i=0; i<_empList.length;i++){
					
					var ckLen = _signList.find("[data-value='"+$(_empList[i]).data("value")+"']");
					
					if(ckLen.length == 0){
						var tmpHtml = $(_empList[i]).clone().removeClass("active").wrapAll("<div/>").parent().html();
						_signList.append(tmpHtml);
						$("#empList li").removeClass("active");
						$(_empList[i]).remove();
					}
				}
			}else{
				alert("결재자는 3명까지 선택 가능 합니다.");
			}
		});
		
		//연결문서
		$("#docSearch").click(function(){
			
			var _appr_divs_cd = $("#appr_divs_cd option:selected").val();
			
			if(_appr_divs_cd==""){
				alert("결재구분을 선택하세요");
				return;
			}
			
			$("#apporval_doc").modal("show");
			
			$.ajax({      
			    type:"GET",  
			    url:"/Apporval_doc_Search?apporval_doc="+_appr_divs_cd,     
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
		
		//결재자
		$("#SingSearch").click(function(){
			$("#popLayer").modal("show");
		});
		
		
		$("#addSign").click(function(){
			var _signList = $("#signList  li");
			
			for(var i =0; i< 3; i++){
				if( i< _signList.length){
					var _va = _signList[i].innerText;
					var _key = $(_signList[i]).data("value");
					$("input[name='appSign']")[i].value=_va;
					$("input[name='appSignEmp']")[i].value=_key;
				}else{
					$("input[name='appSign']")[i].value="";
					$("input[name='appSignEmp']")[i].value="";
				}
			}
		});
	});
	
	
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
	
	//vendor paging
	function goApp_docPage(pages, pageLine) {
		
		var vendor_nm = $("#vendor_nm").val();
		var _apporval_doc = $("#_apporval_doc").val();
		
		$("#apporval_doc").modal("show");
		
		$.ajax({      
		    type:"GET",  
		    url:"/Apporval_doc_Search?apporval_doc="+_apporval_doc+"&page=" + pages + "&pageLine=" + pageLine+"&vendor_nm="+vendor_nm,     
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
	
	//proposal paging
	function goApp_docPage1(pages, pageLine) {
		
		var vendor_nm = $("#vendor_nm").val();
		var _apporval_doc = $("#_apporval_doc").val();
		
		$("#apporval_doc").modal("show");
		
		$.ajax({      
		    type:"GET",  
		    url:"/Apporval_doc_Search?apporval_doc="+_apporval_doc+"&page=" + pages + "&pageLine=" + pageLine+"&vendor_nm="+vendor_nm,     
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
	
	function vendorSearch(){
		
		var vendor_nm = $("#vendor_nm").val();
		var _apporval_doc = $("#_apporval_doc").val();
		
		$("#subLayer").empty();
		
		if(ajaxFlag)return;
		ajaxFlag=true;
		$.ajax({      
		    type:"GET",  
		    url:"/Apporval_doc_Search?apporval_doc="+_apporval_doc+"&vendor_nm="+vendor_nm,
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
	
	$(document).on("click", "#approvalList", function() {
		window.location.href = "/ApprovalList";
	});
	
	$(document).on("click", "#approvalInsert", function() {

		if (ajaxFlag)
			return;
		ajaxFlag = true;

		if ($("#appr_nm").val() == "") {
			alert("결재명명을 입력하세요");
			ajaxFlag = false;
			return;
		}

		if ($("#appr_divs_cd option:selected").val() == "") {
			alert("결재구분을  선택 하세요");
			ajaxFlag = false;
			return;
		}
		
		if ($("#appr_divs_cd option:selected").val() == "0001" || $("#appr_divs_cd option:selected").val() == "0002") {
			if ($("#appr_ref_no").val() == "") {
				alert("연결문서를 선택 하세요");
				ajaxFlag = false;
				return;
			}
		}
		
		if ($("#appSignEmp1").val() == "") {
			alert("결재자를 선택하세요");
			ajaxFlag = false;
			return;
		}
		
		
		var gubun = $("#gubun").val();
		
		
		if (gubun == "") {
			document.Form.action = "/approvalInsert";
		} else {
			document.Form.action = "/approvalUpdate";
		}
		document.Form.submit();
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
					  		<input class="btn btn-dark" type="button" value="결재" id="approva_ok">
					  		<input class="btn btn-dark" type="button" value="반려" id="approva_no">
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
						<thead id="comment_list">
							<c:forEach items="${approvalComment}" var="z" varStatus="status">
								<tr>
									<th scope="col">결재구분</th>
									<th scope="col">기안명</th>
								</tr>
							</c:forEach>
						</thead>
						<tbody>
							<tr>
								<td colspan="2">
									<input type="text" name="comment" id="comment" class="form-control" style="width: 90%;display: inline-block;">
									<input class="btn btn-secondary" type="button" value="댓글작성" id="comment_write" >
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