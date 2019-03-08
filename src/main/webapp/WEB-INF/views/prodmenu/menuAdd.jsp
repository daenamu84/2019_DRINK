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

	$(document).ready(function(){
	
		$("#vendorPop").click(function(){
			$("#popLayer").modal("show");
		});
		
		$("#vendorSearch").click(function(){
			if(ajaxFlag)return;
			ajaxFlag=true;
			$.ajax({      
			    type:"GET",  
			    url:"/vendorSearchPop?vendorNm="+$("#_sVendorNm").val(),      
			    dataType:"html",
			    traditional:true,
			    success:function(args){   
			    	$("#vendorSeachLayer").html(args);
			        ajaxFlag=false;
			    },   
			    error:function(xhr, status, e){  
			        ajaxFlag=false;
			    }  
			});
		});
		
		$("#prodMenuAdd").click(function(){
			if(ajaxFlag)return;
			ajaxFlag=true;
			var _oProdNo = $("input[name='_oProdNo']");
			var _oBrandId = $("input[name='_oBrandId']");
			var _oSubBrandId = $("input[name='_oSubBrandId']");
			var _oSalePrice = $("input[name='_oSalePrice']");
			var _oSaleStdDt = $("input[name='_oSaleStaDt']");
			var _oSaleEndDt = $("input[name='_oSaleEndDt']");
			
			var _addParam = [];
			
			for (var i = 0; i < _oProdNo.length; i++) {
				if(_oProdNo[i].value =="" || _oBrandId[i].value =="" || _oSubBrandId[i].value =="" || _oSalePrice[i].value =="" || _oSaleStdDt[i].value =="" || _oSaleEndDt[i].value =="" ){
					continue;
				}
				if( (_oSaleStdDt[i].value != "" &&  _oSaleEndDt[i].value != "" ) && _oSaleStdDt[i].value > _oSaleEndDt[i].value ){
					alert("시작일은 종료일보다 클수 없습니다.");
					ajaxFlag=false;
					return;
				}
				_addParam.push({"prodNo":_oProdNo[i].value,"brandId":_oBrandId[i].value,"subBrandId":_oSubBrandId[i].value,"salePrice":_oSalePrice[i].value,"saleStdDt":_oSaleStdDt[i].value,"saleEndDt":_oSaleEndDt[i].value});
			}

			if(_addParam.length < 1){
				alert("저장할 데이터를 입력해주세요.");
				ajaxFlag=false;
				return;
			}
			var _vendorId = $("#vendorId").val();
			if(_vendorId == ""  || _vendorId == undefined){
			//	alert("업소가 선택 되지 않았습니다.");
			//	ajaxFlag=false;
			//	return;
			}
			$.ajax({      
			    type:"POST",  
			    url:"/prodMenuAdd",
			    data: JSON.stringify({"_addPram":_addParam,"vendorId":_vendorId}),
			    dataType:"json",
			    contentType:"application/json;charset=UTF-8",
			    traditional:true,
			    success:function(args){   
			        if(args.returnCode == "0000"){
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	location.reload();
			        }else{
			        	alert(args.message.replace(/<br>/gi,"\n"));
			        	location.reload();
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
	
	$(document).on("click","i[name='dateRangeIcon']",function() {
	      $(this).parent().find(".dateRange").click();
	});
	 
	function setVendorId(vendorId, vendorNm){
		$("#vendorId").val(vendorId);
		$("#vendorNm").val(vendorNm);
		$("#popLayer").modal("hide");
		if(ajaxFlag)return;
		ajaxFlag=true;
		$.ajax({      
		    type:"GET",  
		    url:"/prodSearch?vendorId="+vendorId,      
		    dataType:"html",
		    traditional:true,
		    success:function(args){   
		    	$("#productList").html(args);
		        ajaxFlag=false;
		    },   
		    error:function(xhr, status, e){  
		        ajaxFlag=false;
		    }  
		});
	}
	
	
</script>

<div class="">
	<div class="title"> ◈  거래처 메뉴</div> 
	<div class="container-fluid">
		<div class="row">			
			<div class="col">
				<div class="container border" style="padding: 5px;">
					<div class="row">
						<div class="col-sm-2"><span class="align-middle">업소</span></div>
						<div class="col-sm-3">
							<input type="text"  name="vendorNm" id="vendorNm" class="form-control" readonly/>
							<input type="hidden" name="vendorId" id="vendorId" class="form-control" />
						</div>
						<div class="col-sm-5">
							<input class="btn btn-primary" type="button" id="vendorPop" value="선택">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px; overflow-x:auto;">	
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">브랜드</th>
			      <th scope="col">서브브랜드</th>
			      <th scope="col">용량</th>
			      <th scope="col">가격(원)</th>
			      <th scope="col">시작일</th>
			      <th scope="col">종료일</th>
			    </tr>
			  </thead>
			  <tbody id="productList">
			  </tbody>
			</table>
		</div>
		<div class="row flex-row-reverse" style="padding-top:10px;">	
			<input class="btn btn-primary float-sm-right" type="button" id="prodMenuAdd" value="등록">
		</div>
	</div>
	
	<!-- modal start  -->	
	<div id="popLayer" class="modal fade" role="dialog">
		<div class="modal-dialog modal-xl">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">거래처 조회</h5>
				</div>
				<div class="modal-body">
					<div class="container" style="padding: 5px;">
						<div class="row">
							<div class="col-sm-2"><span class="align-middle">업소</span></div>
							<div class="col-sm-3">
								<input type="text"  id="_sVendorNm" class="form-control" />
							</div>
							<div class="col-sm-5">
								<input class="btn btn-primary" type="button" id="vendorSearch" value="조회">
							</div>
						</div>
					</div>
				</div>					
				<div class="modal-body" id="subLayer">
				</div>
				<div class="modal-footer">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">거래처 번호</th>
								<th scope="col">거래처명</th>
							</tr>
						</thead>
						<tbody id="vendorSeachLayer">
							<c:forEach items="${vendorList}" var="i" varStatus="status">
								<tr>
									<td><a
										href="javascript:setVendorId('${i.VENDOR_NO}','${i.OUTLET_NM}');" class="text-decoration-none">${i.VENDOR_NO}</a></td>
									<td><a
										href="javascript:setVendorId('${i.VENDOR_NO}','${i.OUTLET_NM}');" class="text-decoration-none">${i.OUTLET_NM}</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
<!-- modal  end  -->
	
</div>