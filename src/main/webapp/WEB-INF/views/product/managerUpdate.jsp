<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>


<div class="container-fluid">
						<div class="row">			
							<div class="col-sm-3">브랜드</div>
							<div class="col-sm-4">
								<input type="hidden" class="form-control" id="uProdNo" value="${productList.PROD_NO}"/>
								<input type="hidden" class="form-control" id="uBrandId" value="${productList.BRAND_ID}"/>${productList.BRAND_NM}
						  </div>
						</div>
						<div class="row">			
							<div class="col-sm-3">서브 브랜드</div>
							<div class="col-sm-4">
								<input type="hidden" class="form-control" id="uSubBrandId" value="${productList.SUB_BRAND_ID}"/>${productList.SUB_BRAND_NM}
						  </div>
						</div>
						<div class="row">			
							<div class="col-sm-3">용량</div>
							<div class="col-sm-4">
								<select class="custom-select" id="uProdMlCd">
								    <option value="1000" <c:if test="${productList.PROD_ML_CD eq '1000'}">selected</c:if>>1000</option>
								    <option value="1500" <c:if test="${productList.PROD_ML_CD eq '1500'}">selected</c:if>>1500</option>
							  </select>
						  </div>
						</div>
						<div class="row">	
							<div class="col-sm-3">활성화</div>
							<div class="col-sm-4">
								<select class="custom-select" id="uUseYn">
								    <option value="Y" <c:if test="${productList.USE_YN eq 'Y'}">selected</c:if>>Y</option>
								    <option value="N" <c:if test="${productList.USE_YN eq 'N'}">selected</c:if>>N</option>
							  </select>
							</div>
						</div>
					</div>