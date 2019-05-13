<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>


<script>
var ajaxFlag = false;

	$(function() {
	});	

	$(document).ready(function(){
		
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
	
	
</script>

<div class="">
	<div class="title"> ◈  전자결재 기안</div> 
	<div class="container-fluid">
		<div class="row">			
			<div class="col">
				<div class="container border" style="padding: 5px;">
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">기안명</span></div>
						<div class="col-12 col-sm-10">
							<input type="text"  name="appTitle" id="appTitle" class="form-control" autocomplete="off"/>
						</div>
					</div>
					<div class="row" >
						<div class="col-12 col-sm-2"><span class="align-middle">기안구분</span></div>
						<div class="col-12 col-sm-2">
							<select name="deptno" class="form-control" id="deptno">
								<option value="">선택하세요</option>
							</select>
						</div>
						<div class="col-12 col-sm-2"><span class="align-middle">연결문서</span></div>
						<div class="col-12 col-sm-4">
							<input type="text"  name="appDoc" id="appDoc" class="form-control" autocomplete="off"/>
						</div>
						<div class="col-12 col-sm-2">
							<input class="btn btn-primary" style="margin-right:2px;" type="button" id="docSearch" value="검색">
						</div>
					</div>
					<div class="row" style="padding: 5px 0px;">
						<div class="col-12 col-sm-2"><span class="align-middle">결재자</span></div>
						<div class="col-12 col-sm-2">
							<input type="text"  name="appSign" id="appSign1" class="form-control" readonly autocomplete="off"/>
							<input type="hidden"  name="appSignEmp" id="appSignEmp1" class="form-control" readonly autocomplete="off"/>
						</div>
						<div class="col-12 col-sm-2">
							<input type="text"  name="appSign" id="appSign2" class="form-control" readonly autocomplete="off"/>
							<input type="hidden"  name="appSignEmp" id="appSignEmp2" class="form-control" readonly autocomplete="off"/>
						</div>
						<div class="col-12 col-sm-2">
							<input type="text"  name="appSign" id="appSign3" class="form-control" readonly autocomplete="off"/>
							<input type="hidden"  name="appSignEmp" id="appSignEmp3" class="form-control" readonly autocomplete="off"/>
						</div>
						<div class="col-12 col-sm-3">
							<input class="btn btn-primary" style="margin-right:2px;" type="button" id="SingSearch" value="선택">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px;">	
			<div class="col">
				<div class="container" style="padding:0;">
					<textarea class="form-control " style="height:400px;"></textarea>
				</div>
			</div>
		</div>
	</div>
	
	<!-- modal start  -->	
	<div id="popLayer" class="modal fade" role="dialog">
		<div class="modal-dialog modal-xl">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">결제자 지정</h5>
					<a href="#" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
				</div>
				<div class="modal-body">
					<div class="container" style="padding: 5px;">
						<div class="row">
							<div class="col-sm-2"><span class="align-middle">검색</span></div>
							<div class="col-sm-3">
								<input type="text"  id="_sVendorNm" class="form-control" />
							</div>
							<div class="col-sm-5">
								<input class="btn btn-primary" type="button" id="empSearch" value="조회">
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
											  <li class="list-group-item" data-value="1">홍길동1</li>
											  <li class="list-group-item" data-value="2">홍길동2</li>
											  <li class="list-group-item" data-value="3">홍길동3</li>
											  <li class="list-group-item" data-value="4">홍길동4</li>
											  <li class="list-group-item" data-value="5">홍길동5</li>
										</ul>
									</div>
									<div class="col-12 col-sm-2" style="padding-left:2px;">
										<div class="btn-group-vertical" role="group" aria-label="Basic example">
										  	<input class="btn btn-primary" type="button" id="ckSign" value="결제">
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
	
	
</div>