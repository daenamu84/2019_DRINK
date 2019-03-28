<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>

	
						  	<c:forEach items="${vendorList}" var="f" varStatus="status">
						  		<input type="hidden"  name="vendorSearch" id="vendorSearch" value="Y"/>	
						  		<tr>
									<td><a href="javascript:vendorView('${f.VENDOR_NO}','update')">${f.OUTLET_NM}</a></td>
									<td>${f.TEAMNM}</td>
									<td>${f.EMP_NM}</td>
									<td>${f.VENDOR_TEL_NO}</td>
									<td>${f.VENDOR_ADDR}</td>
									<td>${f.MARKGET_NM}</td>
									<td>${f.SGMT_NM}</td>
									<td>${f.STAT_NM}</td>
									<td>원장보기</td>
									<td>메뉴보기</td>
									<td>수정</td>
								</tr>
						  	</c:forEach>
						  		<tr>
						  			<td colspan="11">
						  				<div class="col-xs-3">
										<paging:paging var="skw3" currentPageNo="${paging.page}"
											recordsPerPage="${paging.pageLine}"
											numberOfRecords="${paging.totalCnt}" jsFunc="goPageSub" />
										${skw3.printBtPaging()}
									</div>
						  			</td>
						  		</tr>
						 