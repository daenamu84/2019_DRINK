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
		
		$("#brandInsert").click(function(){
			if(ajaxFlag)return;
			ajaxFlag=true;
			var blank_pattern = /[\s]/g;

			var _brandId = $("#brandID").val();
			if( blank_pattern.test( _brandId) == true){
			    alert(' 공백은 사용할 수 없습니다. ');
			    ajaxFlag=false;
			    return;
			}
			
			if(_brandId.length > 10){
				alert('브랜드ID는 10글자를 넘을수 없습니다.');
			    ajaxFlag=false;
			    return;
			}
			
			var _strReg = /^[A-Za-z0-9]+$/;
			 if (!_strReg.test(_brandId) ){
				alert('브랜드ID는 영문과 숫자만 입력가능합니다.');
				ajaxFlag=false;
			    return;
		      }
			
			var _brandNm = $("#brandNM").val();
			if(_brandNm.length > 50){
				alert('브랜드명은 50글자를 넘을수 없습니다.');
			    ajaxFlag=false;
			    return;
			}
			var _useYn = $("#useYn option:selected").val();
			var _orcoBrandYn = $("#orcoBrandYn option:selected").val();
			var _sortOrd = $("#sortOrd").val();
			
			if(_brandNm.replace(/^\s*/,"") ==""){
				alert("브랜드명을 입력하세요.");
				ajaxFlag=false;
				return;
			}
			$.ajax({      
			    type:"POST",  
			    url:"/brandInsert",      
			    data: JSON.stringify({"brandId":_brandId,"brandNm":_brandNm,"useYn" :_useYn, "orcoBrandYn":_orcoBrandYn,"sortOrd":_sortOrd }),
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
		
		$("#brandClean").click(function(){
			$("#brandID").val("");
			$("#brandNM").val("");
			$("#useYn option:eq(0)").prop("selected", true);
			$("#orcoBrandYn option:eq(0)").prop("selected", true);
			$("#sortOrd").val("");
			
		});
		
	});
	
	$(document).on("click","#brandSClean", function(){
		console.log("서브브랜드 초기화");
		$("#subBrandId").val("");
		$("#subBrandNm").val("");
		$("#liqKdCd option:eq(0)").prop("selected", true);
		$("#stcaseCd option:eq(0)").prop("selected", true);
		$("#subUseYn option:eq(0)").prop("selected", true);
		$("#subSortOrd").val("");
		
	});

	$(document).on("click","#brandSInsert", function(){
		if(ajaxFlag)return;
		ajaxFlag=true;
		
		var masterBrandId = $("#masterBrandId").val();
		if($("#masterBrandId").val() ==""){
			alert("마스터브랜드ID가 없습니다. \n  다시 시도해주세요.");
			location.reload();
			return;
		}
		
		//ajax
		var _subBrandId = $("#subBrandId").val();
		if(_subBrandId.length > 10){
			alert('서브 브랜드ID는 10글자를 넘을수 없습니다.');
		    ajaxFlag=false;
		    return;
		}
		
		var _strReg = /^[A-Za-z0-9]+$/;
		 if (!_strReg.test(_subBrandId) ){
			alert('서브 브랜드ID는 영문과 숫자만 입력가능합니다.');
			ajaxFlag=false;
		    return;
	      }
		
		var _subBrandNm = $("#subBrandNm").val();
		if(_subBrandNm.length > 50){
			alert('서브 브랜드명은 50글자를 넘을수 없습니다.');
		    ajaxFlag=false;
		    return;
		}
		var _subUseYn = $("#subUseYn option:selected").val();
		var _liqKdCd = $("#liqKdCd option:selected").val();
		var _stcaseCd = $("#stcaseCd option:selected").val();
		var _subSortOrd = $("#subSortOrd").val();
		
		if(_subBrandNm.replace(/^\s*/,"") ==""){
			alert("서브 브랜드명을 입력하세요.");
			ajaxFlag=false;
			return;
		}
		$.ajax({      
		    type:"POST",  
		    url:"/brandSubInsert",      
		    data: JSON.stringify({"masterBrandId":masterBrandId,"subBrandId":_subBrandId,"subBrandNm":_subBrandNm,"subUseYn" :_subUseYn, "liqKdCd":_liqKdCd,"stcaseCd":_stcaseCd,"subSortOrd":_subSortOrd }),
		    dataType:"json",
		    contentType:"application/json;charset=UTF-8",
		    traditional:true,
		    success:function(args){   
		        if(args.returnCode == "0000"){
		        	alert(args.message.replace(/<br>/gi,"\n"));
		        	//location.reload();
		        	$("input:radio[name='brandMrd']:checked").trigger("change");
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
	
	$(document).on("change","input:radio[name='brandMrd']", _.debounce( function(){
		if(ajaxFlag)return;
		ajaxFlag=true;
		$("#subLayer").empty();
		$("#popLayer").modal("show");
		$.ajax({      
		    type:"GET",  
		    url:"/brandSubList?masterBrandId="+$(this).data("brandid"),      
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
	},0));
		
	function listView(brandId){
		if(ajaxFlag)return;
		ajaxFlag=true;
		$.ajax({      
		    type:"POST",  
		    url:"/brandView",      
		    data: JSON.stringify({"brandId":brandId}),
		    dataType:"json",
		    contentType:"application/json;charset=UTF-8",
		    traditional:true,
		    success:function(args){   
		        if(args.returnCode == "0000"){
		        	$("#brandID").val(args.data.BRAND_ID);
					$("#brandNM").val(args.data.BRAND_NM);
					$("#useYn").val(args.data.USE_YN);
					$("#orcoBrandYn").val(args.data.ORCO_BRAND_YN);
					$("#sortOrd").val(args.data.SORT_ORD);
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
	}	
	
	function subListView(masterBrandId,brandId){
		if(ajaxFlag)return;
		ajaxFlag=true;
		$.ajax({      
		    type:"POST",  
		    url:"/brandSubView",      
		    data: JSON.stringify({"masterBrandId":masterBrandId,"brandId":brandId}),
		    dataType:"json",
		    contentType:"application/json;charset=UTF-8",
		    traditional:true,
		    success:function(args){   
		        if(args.returnCode == "0000"){
		        	$("#subBrandId").val(args.data.SUB_BRAND_ID);
					$("#subBrandNm").val(args.data.SUB_BRAND_NM);
					$("#subUseYn").val(args.data.USE_YN);
					$("#liqKdCd").val(args.data.LIQ_KD_CD);
					$("#stcaseCd").val(args.data.STCASE_CD);
					$("#subSortOrd").val(args.data.SORT_ORD);
		        }else{
		        	alert(args.message.replace(/<br>/gi,"\n"));
		        	$("input:radio[name='brandMrd']").trigger("change");
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
</script>

<div class="">
	<div class="title"> ◈  브랜드코드 마스터</div> 
	<div class="container" style="max-width:100%;">
		<div class="row">			
			<div class="col">
				<div class="container border" style="padding: 5px;">
					<div class="row">
						<div class="col-sm-2">코드</div>
						<div class="col-sm-3"><input type="text" id="brandID" class="form-control" /></div>
						<div class="col-sm-2">브랜드명</div>
						<div class="col-sm"><input type="text" id="brandNM" class="form-control" /></div>
					</div>
					<div class="row">
						<div class="col-sm-2">사용</div>
						<div class="col-sm-3">
							<select class="custom-select" id="useYn">
							    <option value="Y" selected>Y</option>
							    <option value="N">N</option>
						  </select>
						</div>
						<div class="col-sm-2">자사/경쟁사</div>
						<div class="col-sm-3">
							<select class="custom-select" id="orcoBrandYn">
								<c:forEach items="${cd00014}" var="i" varStatus="status">
									<option value="${i.CMM_CD}">${i.CMM_CD_NM}</option>
								</c:forEach>
						  </select>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-2">순위</div>
						<div class="col-sm-2"><input type="text" id="sortOrd" class="form-control" /></div>
						<div class="col-sm-5">
							<input class="btn btn-primary" type="button" id="brandInsert" value="등록/수정">
							<input class="btn btn-primary" type="button" id="brandClean" value="초기화">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px;">	
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">선택</th>
			      <th scope="col">코드</th>
			      <th scope="col">브랜드명</th>
			      <th scope="col">자사</th>
			      <th scope="col">순위</th>
			      <th scope="col">사용여부</th>
			    </tr>
			  </thead>
			  <tbody>
			  	 <c:forEach items="${brandList}" var="i" varStatus="status">
						<tr>
							<th scope="row"><input type="radio" name="brandMrd" data-brandid="${i.BRAND_ID}" value="${i.BRAND_ID}"></th>
							<td><a href="javascript:listView('${i.BRAND_ID}');" class="text-decoration-none">${i.BRAND_ID}</a></td>
							<td><a href="javascript:listView('${i.BRAND_ID}');" class="text-decoration-none">${i.BRAND_NM}</a></td>
							<td>${i.ORCO_BRAND_NM}</td>
							<td>${i.SORT_ORD}</td>
							<td>${i.USE_YN}</td>
						</tr>
					</c:forEach>
			  </tbody>
			</table>
		</div>
	</div>
	
<!-- modal start  -->	
	<div id="popLayer" class="modal fade" role="dialog">
		<div class="modal-dialog modal-xl">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">서브 브랜드</h5>
		        	<a href="#" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
				</div>
				<div class="modal-body" id="subLayer">
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
<!-- modal  end  -->
</div>