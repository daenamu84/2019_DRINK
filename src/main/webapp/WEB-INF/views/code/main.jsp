<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>


<script>
var nowUrl = "/codeList";
var ajaxFlag = false;

	$(document).ready(function(){
		// 등록/수정 버튼 클릭시 
		$("#codeInsert, #codeupdate").click(function(){
			
			if(ajaxFlag)return;
			
			var blank_pattern = /[\s]/g;

			var _cmm_cd_grp_id = $("#cmm_cd_grp_id").val();
			if( blank_pattern.test( _cmm_cd_grp_id) == true){
			    alert(' 공백은 사용할 수 없습니다. ');
			    ajaxFlag=false;
			    return;
			}
			
			var _strReg = /^[A-Za-z0-9]+$/;
			 if (!_strReg.test(_cmm_cd_grp_id) ){
				alert('코드 영문과 숫자만 입력가능합니다.');
				ajaxFlag=false;
			    return;
		      }
			
			var _cmm_cd_grp_nm = $("#cmm_cd_grp_nm").val();
			var _cmm_cd_grp_cntn  = $("#cmm_cd_grp_cntn").val();
			var _use_yn = $("#use_yn option:selected").val();
			
			
			
			if(_cmm_cd_grp_nm.replace(/^\s*/,"") ==""){
				alert("크드명 입력하세요.");
				ajaxFlag=false;
				return;
			}
			
			ajaxFlag=true;
			$.ajax({      
			    type:"POST",  
			    url:"/codeInsert",      
			    data: JSON.stringify({"cmm_cd_grp_id":_cmm_cd_grp_id,"cmm_cd_grp_nm":_cmm_cd_grp_nm,"cmm_cd_grp_cntn":_cmm_cd_grp_cntn,"use_yn" :_use_yn }),
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
		
		//신규 버튼 클릭시 
		$("#codenew").click(function(){
			$("#cmm_cd_grp_id").val("");
			$("#cmm_cd_grp_nm").val("");
			$("#use_yn option:eq(0)").prop("selected", true);
			$("#codeupdate").hide();
			$("#codenew").hide();
			$("#codeInsert").show();
			
		});
		
	});
	
	$(document).on("click","#codeSnew", function(){
		$("#cmm_cd").val("");
		$("#cmm_cd_nm").val("");
		$("#sub_use_yn option:eq(0)").prop("selected", true);
		$("#codeSupdate").hide();
		$("#codeSnew").hide();
		$("#codeSInsert").show();
	});
	
	
	
	//서브 코드 저장 
	$(document).on("click","#codeSInsert , #codeSupdate", function(){
		if(ajaxFlag)return;
		console.log("서브코드 등록수정");
		
		var mcmm_cd_grp_id = $("#mcmm_cd_grp_id").val();
		if($("#mcmm_cd_grp_id").val() ==""){
			alert("마스터ID가 없습니다. \n  다시 시도해주세요.");
			location.reload();
		}
		
		ajaxFlag=true;
		//ajax
		var cmm_cd = $("#cmm_cd").val();
		if(cmm_cd.length > 4){
			alert('서브 코드는 4글자를 넘을수 없습니다.');
		    ajaxFlag=false;
		    return;
		}
		
		var _strReg = /^[A-Za-z0-9]+$/;
		 if (!_strReg.test(cmm_cd) ){
			alert('서브 코드는 영문과 숫자만 입력가능합니다.');
			ajaxFlag=false;
		    return;
	      }
		
		var cmm_cd_nm = $("#cmm_cd_nm").val();
		var cmm_cd_cntn = $("#cmm_cd_cntn").val();
		var sub_use_yn = $("#sub_use_yn option:selected").val();
		
		if(cmm_cd_nm.replace(/^\s*/,"") ==""){
			alert("코드명을 입력하세요.");
			ajaxFlag=false;
			return;
		}
		ajaxFlag=true;
		$.ajax({      
		    type:"POST",  
		    url:"/codeSubInsert",      
		    data: JSON.stringify({"mcmm_cd_grp_id":mcmm_cd_grp_id,"cmm_cd":cmm_cd,"cmm_cd_nm":cmm_cd_nm,"cmm_cd_cntn":cmm_cd_cntn,"sub_use_yn" :sub_use_yn }),
		    dataType:"json",
		    contentType:"application/json;charset=UTF-8",
		    traditional:true,
		    success:function(args){   
		        if(args.returnCode == "0000"){
		        	alert(args.message.replace(/<br>/gi,"\n"));
		        	//location.reload();
		        	$("input:radio[name='cmm_cd_grp_mid']:checked").trigger("change");
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
	
	//서브 코드 레이어
	$(document).on("change","input:radio[name='cmm_cd_grp_mid']", _.debounce( function(){
		if(ajaxFlag)return;
		ajaxFlag=true;
		$("#subLayer").empty();
		$("#popLayer").modal("show");
		
		$.ajax({      
		    type:"GET",  
		    url:"/codeSubList?cmm_cd_grp_id="+$(this).data("cmm_cd_grp_id"),      
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
	
	//마스터 선택시 
	function listView(cmm_cd_grp_id){
		if(ajaxFlag)return;
		ajaxFlag=true;
		$.ajax({      
		    type:"POST",  
		    url:"/codeView",      
		    data: JSON.stringify({"cmm_cd_grp_id":cmm_cd_grp_id}),
		    dataType:"json",
		    contentType:"application/json;charset=UTF-8",
		    traditional:true,
		    success:function(args){   
		        if(args.returnCode == "0000"){
		        	$("#cmm_cd_grp_id").val(args.data.CMM_CD_GRP_ID);
					$("#cmm_cd_grp_nm").val(args.data.CMM_CD_GRP_NM);
					$("#cmm_cd_grp_cntn").val(args.data.CMM_CD_GRP_CNTN);
					$("#use_yn").val(args.data.USE_YN);
					$("#codeupdate").show();
					$("#codenew").show();
					$("#codeInsert").hide();
					$('#cmm_cd_grp_id').attr('readonly', true);
					
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
	
	function subListView(cmm_cd_grp_id,cmm_cd){
		if(ajaxFlag)return;
		ajaxFlag=true;
		$.ajax({      
		    type:"POST",  
		    url:"/codeSubView",      
		    data: JSON.stringify({"cmm_cd_grp_id":cmm_cd_grp_id,"cmm_cd":cmm_cd}),
		    dataType:"json",
		    contentType:"application/json;charset=UTF-8",
		    traditional:true,
		    success:function(args){   
		        if(args.returnCode == "0000"){
		        	$("#cmm_cd").val(args.data.CMM_CD);
					$("#cmm_cd_nm").val(args.data.CMM_CD_NM);
					$("#cmm_cd_cntn").val(args.data.CMM_CD_CNTN);
					$("#sub_use_yn").val(args.data.USE_YN);
					$("#codeSupdate").show();
					$("#codeSnew").show();
					$("#codeSInsert").hide();
					$('#cmm_cd').attr('readonly', true);
					
		        }else{
		        	alert(args.message.replace(/<br>/gi,"\n"));
		        	$("input:radio[name='cmm_cd_grp_mid']").trigger("change");
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
	<div class="title"> ◈  코드 마스터</div> 
	<div class="container" style="max-width:100%;">
		<div class="row">			
			<div class="col">
				<div class=" border" style="padding: 5px;">
					<table class="table-borderless" width="100%">
						<thead>
							<tr>
								<td>코드</td>
								<td style="padding-left:20px;"><input type="text" class="form-control" maxlength="5" name="cmm_cd_grp_id" id="cmm_cd_grp_id"></td>
								<td style="padding-left:20px;">사용여부</td>
								<td style="padding-left:20px;"><select name="use_yn" class="form-control" id="use_yn">
									<option value="Y">사용</option>
									<option value="N">사용안함</option>
								</select></td>
								<td style="padding-left:20px;">코드명</td>
								<td style="padding-left:20px;"><input type="text" class="form-control" name="cmm_cd_grp_nm" id="cmm_cd_grp_nm"></td>
								<td style="padding-left:20px;">코드설명</td>
								<td style="padding-left:20px;"><input type="text" class="form-control" name="cmm_cd_grp_cntn" id="cmm_cd_grp_cntn"></td>
								<td>
									<input type="hidden" name="deptno" id="deptno"/>
									<input class="btn btn-dark" type="button" value="등록" id="codeInsert" />
									<input class="btn btn-dark" type="button" value="수정" id="codeupdate" style="display:none"/>
									<input class="btn btn-dark" type="button" value="취소" id="codenew" style="display:none"/>
								</td>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
		<div class="row" style="padding-top:10px;">	
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">선택</th>
			      <th scope="col">코드</th>
			      <th scope="col">코드명</th>
			      <th scope="col">코드설명</th>
			      <th scope="col">사용여부</th>
			    </tr>
			  </thead>
			  <tbody>
			  	 <c:forEach items="${codeList}" var="i" varStatus="status">
						<tr>
							<th scope="row"><input type="radio" name="cmm_cd_grp_mid" data-cmm_cd_grp_id="${i.CMM_CD_GRP_ID}"></th>
							<td><a href="javascript:listView('${i.CMM_CD_GRP_ID}');" class="text-decoration-none">${i.CMM_CD_GRP_ID}</a></td>
							<td><a href="javascript:listView('${i.CMM_CD_GRP_ID}');" class="text-decoration-none">${i.CMM_CD_GRP_NM}</a></td>
							<td><a href="javascript:listView('${i.CMM_CD_GRP_ID}');" class="text-decoration-none">${i.CMM_CD_GRP_CNTN}</a></td>
							<td>${i.USE_YN_NM}</td>
						</tr>
					</c:forEach>
			  </tbody>
			</table>
			<div style="margin-right: auto;margin-left: auto">
				<paging:paging var="skw3" currentPageNo="${paging.page}"
					recordsPerPage="${paging.pageLine}"
					numberOfRecords="${paging.totalCnt}" jsFunc="goPage" />
				${skw3.printBtPaging()}
			</div>
		</div>
	</div>
	
	<!-- modal start  -->	
	<div id="popLayer" class="modal fade" role="dialog" data-backdrop="static">
		<div class="modal-dialog modal-xl" style="max-width: 1540px">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">서브 코드</h5>
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

<script>
function goPage(pages, pageLine) {
	var url = nowUrl;
	if(url.indexOf('?')  >-1){url += "&";}else{url +="?";}
    url += "page=" + pages + "&pageLine=" + pageLine;
    location.href = url;
}
</script>