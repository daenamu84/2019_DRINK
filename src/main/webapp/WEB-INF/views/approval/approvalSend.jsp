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
			toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    ['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['color', ['color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']]
			  ]
			
		});
		
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
						//$(_empList[i]).remove();
					}else{
						alert("이미 지정된 결재자 입니다.");
						return false;
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
			$("#popLayer").modal("hide");
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
		

		if ($("input[name='appSignEmp']").filter(function(idx){  return this.value !== ""; }).length ==0) {
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
							<input type="text"  name="appr_nm" id="appr_nm" class="form-control" autocomplete="off"/>
						</div>
					</div>
					<div class="row" >
						<div class="col-12 col-sm-2"><span class="align-middle">결재구분</span></div>
						<div class="col-12 col-sm-2">
							<select class="custom-select" name="appr_divs_cd" id="appr_divs_cd" onChange="display_appdoc()">
								<option value="">선택하세요.</option>
								<c:forEach items="${C00026}" var="a">
									<option value="${a.CMM_CD}">${a.CMM_CD_NM}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-sm-2" id="app_doc1"><span class="align-middle">연결문서</span></div>
						<div class="col-12 col-sm-4" id="app_doc2">
							<input type="text"  name="appr_ref_nm" id="appr_ref_nm" class="form-control" autocomplete="off"/>
							<input type="hidden"  name="appr_ref_no" id="appr_ref_no" class="form-control" autocomplete="off"/>
						</div>
						<div class="col-12 col-sm-2" id="app_doc3">
							<input class="btn btn-primary" style="margin-right:2px;" type="button" id="docSearch" value="검색">
						</div>
					</div>
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">결재자</span></div>
						<div class="col-12 col-sm-2">
							<input type="text"  name="appSign" id="appSign1" class="form-control" readonly autocomplete="off"/>
							<input type="hidden"  name="appSignEmp" id="appSignEmp1"  class="form-control" readonly autocomplete="off"/>
						</div>
						<div class="col-12 col-sm-2">
							<input type="text"  name="appSign" id="appSign2" class="form-control" readonly autocomplete="off"/>
							<input type="hidden"  name="appSignEmp" id="appSignEmp2"  class="form-control" readonly autocomplete="off"/>
						</div>
						<div class="col-12 col-sm-2">
							<input type="text"  name="appSign" id="appSign3" class="form-control" readonly autocomplete="off"/>
							<input type="hidden"  name="appSignEmp" id="appSignEmp3"  class="form-control" readonly autocomplete="off"/>
						</div>
						<div class="col-12 col-sm-3">
							<input type="hidden" id="dept_no"  name="dept_no" value="${deptno}">
							<input class="btn btn-primary" style="margin-right:2px;" type="button" id="SingSearch" value="선택">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px;">	
			<div class="col">
				<div class="container" style="padding:0;">
					<textarea name="for_appr_cntn" class="summernote"></textarea>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px;">	
			<div class="col">
				<div class="container border" style="padding: 5px;">
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">첨부파일</span></div>
						<div class="col-12 col-sm-10">
							<input type="file" id="file1" class="fileDrop" name="file1" onchange="fileUpload(this,1);" style="width:60%;display:none;">
							<input type="text" id="apnd_file_divs_cd1" class="form-control" name="apnd_file_divs_cd1" style="width:50%;display:initial;" value="${apnd_file_divs_cd}">
							<input class="btn-primary" type="button" value="파일첨부" onClick="FileClick(1)">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top: 10px;">
			<div class="col">
				<div class="container " style="padding: 5px;">
					<div class="text-md-right">
						<input type="hidden" name="gubun" value="${gubun}" id="gubun">
						<input class="btn btn-dark" type="button" value="결재올릭기" id="approvalInsert"> 
						<input class="btn btn-dark" type="button" value="목록" id="approvalList">
					</div>
				</div>

			</div>
		</div>
	</form>
	</div>
	
	<!-- modal start  -->	
	<div id="popLayer" class="modal fade" role="dialog">
		<div class="modal-dialog modal-xl">
			<!-- Modal content-->
			<div class="modal-content" id="pay_body">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">결재자 지정</h5>
					<a href="#" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
				</div>
				<div class="modal-body">
					<div class="container" style="padding: 5px;">
						<div class="row">
							<div class="col-sm-5">
								<input class="btn btn-primary" type="button" id="addSign" value="적용">
							</div>
						</div>
					</div>
				</div>					
				<div class="modal-body" >
					<div class="container-fluid">
						<div class="col-12 col-sm-6 float-left">
							<div class="container-fluid">
								<div class="row" >	
									<div class="col-12 col-sm-10" style="padding:0px;">
										<ul class="list-group" id="empList" style="border: 1px solid rgba(0, 0, 0, 0.125);padding: 0;min-height:300px;">
											<c:forEach items="${empSignList}" var="list">
												<li class="list-group-item" data-value="${list.EMP_NO}">${list.EMP_NM}</li>
											</c:forEach>
										</ul>
									</div>
									<div class="col-12 col-sm-2" style="padding-left:2px;">
										<div class="btn-group-vertical" role="group" aria-label="Basic example">
										  	<input class="btn btn-primary" type="button" id="ckSign" value="결재">
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-12 col-sm-6 float-left">
							<div class="container-fluid">
								<div class="row" >	
									<div class="col-12 col-sm-10" style="padding:0px;">
										<ul class="list-group" id="signList" style="border: 1px solid rgba(0, 0, 0, 0.125);padding: 0;min-height:300px;">
										</ul>
									</div>
									<div class="col-12 col-sm-2" style="padding-left:2px;">
										<div class="btn-group-vertical" role="group" aria-label="Basic example">
										  	<input class="btn btn-primary" type="button" id="siginUp" value="위로">
											<input class="btn btn-primary" type="button" id="signDown" value="아래로">
											<input class="btn btn-primary" type="button" id="signDel" value="삭제">
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-body">
				</div>
			</div>
		</div>
	</div>
<!-- modal  end  -->

	<!-- modal start  -->
	<div id="apporval_doc" class="modal fade" role="dialog"
		data-backdrop="static" >
		<div class="modal-dialog modal-xl" style="max-width: 90%">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">검색</h5>
					<a href="#" class="close" data-dismiss="modal" aria-label="Close"><span
						aria-hidden="true">&times;</span></a>
				</div>
				<div class="modal-body" id="subLayer"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- modal  end  -->


</div>