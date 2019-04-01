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
									<c:forEach items="${cd00017List}" var="i" varStatus="status">
										<option value="${i.CMM_CD}"  <c:if test="${productList.PROD_ML_CD eq i.CMM_CD}">selected</c:if>>${i.CMM_CD_NM}</option>
									</c:forEach>
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
						<div class="row">	
							<div class="col-sm-3">CASE RATE</div>
							<div class="col-sm-4">
								<input type="number"  name="ucaserate_amt" id="ucaserate_amt" value="${productList.CASERATE_AMT}"/>
							</div>
						</div>
					</div>