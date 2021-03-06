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
		
		$("#productInsertLayer").click(function(){
			$("#popLayer").modal("show");
		});

		$("#ProductInsert").click(function(){
			if(ajaxFlag)return;
			ajaxFlag=true;
			var _iBrandId = $("#iBrandId option:selected").val();
			var _iSubBrandId = $("#iSubBrandId option:selected").val();
			var _iProdMlCd = $("#iProdMlCd option:selected").val();
			var _iUseYn = $("#iUseYn option:selected").val();
			var _caserate_amt = $("#caserate_amt").val();

			if(_iBrandId =="" || _iBrandId == undefined){
				alert("브랜드를 선택하세요.");
				ajaxFlag=false;
				return;
			}
			
			if(_iSubBrandId =="" || _iSubBrandId == undefined){
				alert("서브브랜드를 선택하세요.");
				ajaxFlag=false;
				return;
			}
			if(_iProdMlCd =="" || _iProdMlCd == undefined){
				alert("용량을 선택하세요.");
				ajaxFlag=false;
				return;
			}
			if(_caserate_amt =="" || _caserate_amt == undefined){
				alert("case rate을 입력하세요");
				ajaxFlag=false;
				return;
			}
			
			
			$.ajax({      
			    type:"POST",  
			    url:"/productInsert",      
			    data: JSON.stringify({"brandId":_iBrandId,"subBrandId":_iSubBrandId,"prodMlCd":_iProdMlCd ,"useYn":_iUseYn,"caserate_amt":_caserate_amt}),
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
	
	
	$(document).on("click","#productSearch", function(){
		if(ajaxFlag)return;
		ajaxFlag=true;
		var brandChk =$("input:checkbox[name='brandChk']:checked");
		var brandList = [];
		brandChk.each(function() {
			brandList.push($(this).val()); 
		});
		if(brandChk.length < 1){
			alert("브랜드를 선택 하세요.");
			 ajaxFlag=false;
			 return;
		}
			
		$.ajax({      
		    type:"POST",  
		    url:"/productBrandSearch",      
		    data: {"brandId":brandList.toString()},
		    dataType:"html",
		    traditional:true,
		    success:function(args){   
		        $("#productList").empty();
		        $("#productList").html(args);
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
	$(document).on("click","#ProductUpdate", function(){
		if(ajaxFlag)return;
		ajaxFlag=true;
		
		var _uProdNo = $("#uProdNo").val();
		var _uProdMlCd = $("#uProdMlCd option:selected").val();
		var _uUseYn = $("#uUseYn option:selected").val();
		var _ucaserate_amt = $("#ucaserate_amt").val();
		
		if(_uProdNo=="" || _uProdNo== undefined){
			alert("제품번호가 없습니다.  다시 시도해주세요.");
			 ajaxFlag=false;
			 location.reload();
			 return;
		}
		if(_uProdMlCd=="" || _uProdMlCd== undefined){
			alert("용량을 선택해주세요.");
			 ajaxFlag=false;
			 return;
		}
		if(_uUseYn=="" || _uUseYn== undefined){
			alert("활성화를 선택해주세요.");
			 ajaxFlag=false;
			 return;
		}
		if(_ucaserate_amt =="" || _ucaserate_amt == undefined){
			alert("case rate을 입력하세요");
			ajaxFlag=false;
			return;
		}
		
		
		$.ajax({      
		    type:"POST",  
		    url:"/productUpdate",      
		    data: JSON.stringify({"prodNo":_uProdNo,"prodMlCd":_uProdMlCd ,"useYn":_uUseYn,"caserate_amt":_ucaserate_amt}),
		    dataType:"json",
		    contentType:"application/json;charset=UTF-8",
		    traditional:true,
		    success:function(args){   
		        if(args.returnCode == "0000"){
		        	alert(args.message.replace(/<br>/gi,"\n"));
		        	ajaxFlag=false;
		        	$("#prodDetailLayer").modal("hide");
		        	$("#productSearch").trigger("click");
		        }else{
		        	alert(args.message.replace(/<br>/gi,"\n"));
		        	location.reload();
		        	ajaxFlag=false;
		        }
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

	
	
	$(document).on("change","#iBrandId", _.debounce( function(){
		if(ajaxFlag)return;
		ajaxFlag=true;
		$("#iSubBrandId").empty();
		$.ajax({      
		    type:"GET",  
		    url:"/brandSCd?BrandId="+$(this).val(),      
		    dataType:"html",
		    traditional:true,
		    success:function(args){   
		    	$("#iSubBrandId").html(args);
		        ajaxFlag=false;
		    },   
		    error:function(xhr, status, e){  
		        ajaxFlag=false;
		    }  
		});
	},0));
	
	
	function productDetail(prod_no){
		
		$("#prodDetailView").empty();
		if(ajaxFlag)return;
		ajaxFlag=true;
		$.ajax({      
		    type:"POST",  
		    url:"/productDetailView",      
		    data: {"prodNo":prod_no},
		    dataType:"html",
		    traditional:true,
		    success:function(args){   
				$("#prodDetailLayer").modal("show");
		        $("#prodDetailView").html(args);
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
	
		
	function goPage(pages, pageLine) {
		if(ajaxFlag)return;
		ajaxFlag=true;
		$.ajax({      
		    type:"POST",  
		    url:"/productBrandSearch",      
		    data: {"brandId":$("#_pBrandId").val(),"page":pages,"pageLine":pageLine},
		    dataType:"html",
		    traditional:true,
		    success:function(args){   
		        $("#productList").empty();
		        $("#productList").html(args);
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

</script>

<div class="">
	<div class="title"> ◈  제품관리</div> 
	<div class="container-fluid">
		<div class="row">			
			<div class="col">
				<div class="container border" style="padding: 5px;">
					<div class="row">
								<c:forEach items="${brandList}" var="i" varStatus="status">
									<c:if test="${status.index eq 0 || (status.index%5) eq 0}">
									</c:if>
											<div class="col-sm-2  text-truncate"><label ><input type="checkbox" name="brandChk" value="${i.BRAND_ID}"/>${i.BRAND_NM}<c:if test="${i.USE_YN ne 'Y'}">(중지)</c:if></label></div>
									<c:if test="${status.last || (status.index%5) eq 4}">
									</c:if>
								</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col" style="margin-top:10px;">
				<input class="btn btn-primary" type="button" id="productInsertLayer" value="등록/수정">
				<input class="btn btn-success float-right" type="button" id="productSearch" value="검색">
			</div>
		</div>
		<div class="row" style="padding-top:10px;">	
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">No</th>
			      <th scope="col">브랜드</th>
			      <th scope="col">서브브랜드</th>
			      <th scope="col">용량</th>
			      <th scope="col">CASE RATE</th>
			      <th scope="col">주류유형</th>
			      <th scope="col">당사/경쟁사</th>
			      <th scope="col">활성화</th>
			    </tr>
			  </thead>
			  <tbody id="productList">
						
			  </tbody>
			</table>
		</div>
	</div>
	
<!-- modal start  -->	
	<div id="popLayer" class="modal fade" role="dialog">
		<div class="modal-dialog ">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">제품 등록</h5>
		        	<a href="#" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
				</div>
				<div class="modal-body">
					<div class="container-fluid">
						<div class="row"  style="padding: 5px 0px;">			
							<div class="col-sm-3">브랜드</div>
							<div class="col-sm-6">
								<select class="custom-select" id="iBrandId">
									<option value="">선택하세요.</option>
									<c:forEach var="i" items="${mBrandCd}" varStatus="status">
										<option value="${i.BRAND_ID}">${i.BRAND_NM}</option>
									</c:forEach>
							  </select>
						  </div>
						</div>
						<div class="row"  style="padding: 5px 0px;">			
							<div class="col-sm-3">서브 브랜드</div>
							<div class="col-sm-6">
								<select class="custom-select" id="iSubBrandId">
							  </select>
						  </div>
						</div>
						<div class="row"  style="padding: 5px 0px;">			
							<div class="col-sm-3">용량</div>
							<div class="col-sm-4">
								<select class="custom-select" id="iProdMlCd">
									<c:forEach items="${cd00017List}" var="i" varStatus="status">
										<option value="${i.CMM_CD}">${i.CMM_CD_NM}</option>
									</c:forEach>
							  </select>
						  </div>
						</div>
						<div class="row"  style="padding: 5px 0px;">	
							<div class="col-sm-3">활성화</div>
							<div class="col-sm-4">
								<select class="custom-select" id="iUseYn">
								    <option value="Y" selected>Y</option>
								    <option value="N">N</option>
							  </select>
							</div>
						</div>
						<div class="row"  style="padding: 5px 0px;">	
							<div class="col-sm-3">CASE RATE</div>
							<div class="col-sm-4">
								<input type="number"  name="caserate_amt" id="caserate_amt"/>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<input class="btn btn-success float-right" type="button" id="ProductInsert" value="등록">
					<input class="btn btn-secondary float-right" type="button" data-dismiss="modal" value="Close">
				</div>
			</div>
		</div>
	</div>
<!-- modal  end  -->

<!-- modal detail start  -->	
	<div id="prodDetailLayer" class="modal fade" role="dialog">
		<div class="modal-dialog ">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">제품 수정</h5>
		        	<a href="#" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
				</div>
				<div class="modal-body" id="prodDetailView">


				</div>
				<div class="modal-footer">
					<input class="btn btn-success float-right" type="button" id="ProductUpdate" value="수정">
					<input class="btn btn-secondary float-right" type="button" data-dismiss="modal" value="Close">
				</div>
			</div>
		</div>
	</div>
<!-- modal detail end  -->
</div>