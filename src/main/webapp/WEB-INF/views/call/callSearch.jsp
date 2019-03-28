<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>

	
						  	 <c:forEach items="${CallList}" var="i" varStatus="status">
								<tr>
									<td><input type="checkbox" name="checkDeal" value="${i.SCALL_NO}"></td>
									<td><a href="javascript:fnCopy('${i.SCALL_NO}')">${i.SCALL_GBN_NM_M}</a></td>
									<td>${i.SCALL_DT}</td>
									<td>${i.OUTLET_NM}</td>
									<td>${i.TEAMNM}</td>
									<td>${i.EMP_NM}</td>
									<td>${i.SCALL_PURPOSE_CD_NM}</td>
									<td>${i.SCALL_PFR_NM}</td>
								</tr>
							</c:forEach>	
							<tr>
									<td colspan="8">
										<div class="col-xs-3">
										<paging:paging var="skw3" currentPageNo="${paging.page}"
											recordsPerPage="${paging.pageLine}"
											numberOfRecords="${paging.totalCnt}" jsFunc="goPageSub" />
										${skw3.printBtPaging()}
										</div>
									</td>
								</tr>
						 