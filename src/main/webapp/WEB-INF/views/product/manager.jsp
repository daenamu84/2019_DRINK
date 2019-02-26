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
			console.log("클릭");
			$("#popLayer").modal("show");
		});
		
		$("#ProductInsert").click(function(){
			if(ajaxFlag)return;
			ajaxFlag=true;
			var _iBrandId = $("#iBrandId option:selected").val();
			var _iSubBrandId = $("#iSubBrandId option:selected").val();
			var _iProdMlCd = $("#iProdMlCd option:selected").val();
			var _iUseYn = $("#iUseYn option:selected").val();

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
			
			$.ajax({      
			    type:"POST",  
			    url:"/productInsert",      
			    data: JSON.stringify({"brandId":_iBrandId,"subBrandId":_iSubBrandId,"prodMlCd":_iProdMlCd ,"useYn":_iUseYn}),
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
											<div class="col-sm"><label><input type="checkbox" name="brandChk" value="${i.BRAND_ID}"/>${i.BRAND_NM}<c:if test="${i.USE_YN ne 'Y'}">(중지)</c:if></label></div>
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
			      <th scope="col">주류유형</th>
			      <th scope="col">당사/타사</th>
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
				<div class="modal-body" id="subLayer">
					<div class="container-fluid">
						<div class="row">			
							<div class="col-sm-3">브랜드</div>
							<div class="col-sm-4">
								<select class="custom-select" id="iBrandId">
									<c:forEach var="i" items="${mBrandCd}" varStatus="status">
										<option value="${i.BRAND_ID}">${i.BRAND_NM}</option>
									</c:forEach>
							  </select>
						  </div>
						</div>
						<div class="row">			
							<div class="col-sm-3">서브 브랜드</div>
							<div class="col-sm-4">
								<select class="custom-select" id="iSubBrandId">
							  </select>
						  </div>
						</div>
						<div class="row">			
							<div class="col-sm-3">용량</div>
							<div class="col-sm-4">
								<select class="custom-select" id="iProdMlCd">
								    <option value="1000" selected>1000</option>
								    <option value="1500">1500</option>
							  </select>
						  </div>
						</div>
						<div class="row">	
							<div class="col-sm-3">활성화</div>
							<div class="col-sm-4">
								<select class="custom-select" id="iUseYn">
								    <option value="Y" selected>Y</option>
								    <option value="N">N</option>
							  </select>
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
</div>