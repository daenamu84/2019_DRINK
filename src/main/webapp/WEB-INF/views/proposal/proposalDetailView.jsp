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
	
	});
	
</script>

<div class="">
	<div class="container-fluid">
		<div class="row" ">			
			<div class="title col col-12  col-sm-5" style="padding: 1px 0px;">◈  STEP2. PROPOSAL 제품/지원목록 등록</div> 
			<label class="col col-12 col-sm-1" style="padding: 1px 0px;">제안제품수</label>
			<div class="col col-12 col-sm-2" style="padding: 1px 0px;">
					<select name="productCnt" class="form-control" id="productCnt">
								<option value="1" >1</option>
								<option value="2" >2</option>
								<option value="3" >3</option>
								<option value="4" >4</option>
								<option value="5" >5</option>
								<option value="6" >6</option>
								<option value="7" >7</option>
								<option value="8" >8</option>
								<option value="9" >9</option>
								<option value="10" >10</option>
					</select>
			</div>
			<label class="col col-12 col-sm-1" style="padding: 1px 0px;">지원품목수</label>
			<div class="col col-12 col-sm-2" style="padding: 1px 0px;">
					<select name="supplyCnt" class="form-control" id="supplyCnt">
								<option value="1" >1</option>
								<option value="2" >2</option>
								<option value="3" >3</option>
								<option value="4" >4</option>
								<option value="5" >5</option>
								<option value="6" >6</option>
								<option value="7" >7</option>
								<option value="8" >8</option>
								<option value="9" >9</option>
								<option value="10" >10</option>
					</select>
			</div>
			<div class="col col-12 col-sm-1" style="padding: 1px 0px;">
					<input class="btn btn-primary" type="button" id="prodInsert" value="변경">
			</div>
		</div>
		<div class="row" style="padding-top:10px; overflow-x:auto;">
			<div class="title"> 제안제품</div> 
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">제품명</th>
			      <th scope="col">출고수량</th>
			      <th scope="col">출고단가</th>
			      <th scope="col">할인률</th>
			      <th scope="col">최종출고금액</th>
			    </tr>
			  </thead>
			  <tbody id="view1">
			  	<tr>
			  		<td></td>
			  		<td></td>
			  		<td></td>
			  		<td></td>
			  		<td></td>
			  	</tr>
			  </tbody>
			</table>
		</div>
	</div>

	
</div>