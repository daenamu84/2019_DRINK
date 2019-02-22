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
			
			var _brandId = $("#brandID").val();
			var _brandNm = $("#brandNM").val();
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
	
	$(document).on("change","input:radio[name='brandMrd']", _.debounce( function(){
		if(ajaxFlag)return;
		console.log("lodash");
		console.log("라디오 체크");
		console.log($(this).data("brandid"));
		
		
	},0));
		
</script>

<div class="">
	<div class="title"> ◈  브랜드코드 마스터</div> 
	<div class="container" style="max-width:100%;">
		<div class="row">			
			<div class="col">
				<div class="container border" style="padding: 5px;">
					<div class="row">
						<div class="col-sm-2">코드</div>
						<div class="col-sm-3"><input type="text" id="brandID" class="form-control" readonly/></div>
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
						<div class="col-sm-2">자사/타사</div>
						<div class="col-sm-3">
							<select class="custom-select" id="orcoBrandYn">
							    <option value="Y" selected>자사</option>
							    <option value="N">타사</option>
						  </select>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-2">순위</div>
						<div class="col-sm-2"><input type="text" id="sortOrd" class="form-control" /></div>
						<div class="col-sm-4">
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
							<th scope="row"><input type="radio" name="brandMrd" data-brandid="${i.BRAND_ID}"></th>
							<td><span>${i.BRAND_ID}</span></td>
							<td><span>${i.BRAND_NM}</span></td>
							<td>${i.ORCO_BRAND_NM}</td>
							<td>${i.SORT_ORD}</td>
							<td>${i.USE_YN}</td>
						</tr>
					</c:forEach>
			  </tbody>
			</table>
		</div>
	</div>
	
<a href="#" class="btn btn-info btn-lg " data-toggle="modal" data-target="#popLayer">Open Modal</a>
<!-- modal start  -->	
	<div id="popLayer" class="modal fade" role="dialog">
		<div class="modal-dialog modal-lg">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">서브 브랜드</h5>
		        	<a href="#" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
				</div>
				<div class="modal-body">
					<div class="container" style="max-width:100%;">
						<div class="row">
							<div class="col">
								<div class="container border" style="padding: 5px;">
									<div class="row">
										<div class="col-sm-2">코드</div>
										<div class="col-sm-3">
											<input type="text" class="form-control" />
										</div>
										<div class="col-sm-2">브랜드명</div>
										<div class="col-sm">
											<input type="text" class="form-control" />
										</div>
									</div>
									<div class="row">
										<div class="col-sm-2">사용</div>
										<div class="col-sm-3">
											<select class="custom-select" id="">
												<option value="Y" selected>Y</option>
												<option value="N">N</option>
											</select>
										</div>
										<div class="col-sm-2">자사/타사</div>
										<div class="col-sm-3">
											<select class="custom-select" id="">
												<option value="Y" selected>자사</option>
												<option value="N">타사</option>
											</select>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-2">순위</div>
										<div class="col-sm-2">
											<input type="text" class="form-control" />
										</div>
										<div class="col-sm-3">
											<input class="btn btn-primary" type="button" value="등록">
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
								      <th scope="col">사용</th>
								      <th scope="col">자사</th>
								      <th scope="col">순위</th>
								    </tr>
								  </thead>
								  <tbody>
								    <tr>
								      <th scope="row"><input type="radio" name="brandSrd"></th>
								      <td>1</td>
								      <td>Otto</td>
								      <td>@mdo</td>
								      <td>@mdo</td>
								      <td>@mdo</td>
								    </tr>
								    <tr>
								      <th scope="row"><input type="radio" name="brandSrd"></th>
								      <td>2</td>
								      <td>Thornton</td>
								      <td>@fat</td>
								      <td>@mdo</td>
								      <td>@mdo</td>
								    </tr>
								    <tr>
								      <th scope="row"><input type="radio" name="brandSrd"></th>
								      <td>3</td>
								      <td>the Bird</td>
								      <td>@twitter</td>
								      <td>@mdo</td>
								      <td>@mdo</td>
								    </tr>
								  </tbody>
								</table>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
<!-- modal  end  -->
</div>