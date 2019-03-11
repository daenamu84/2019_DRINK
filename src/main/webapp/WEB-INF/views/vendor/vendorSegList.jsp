<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>

	
						  	<select name="vendor_sgmt_divs_cd" class="form-control" id="vendor_sgmt_divs_cd">
						  		<c:if test="${gubun eq 'list' }">
						  		<option value="ALL">전체</option>
								</c:if>
								<c:forEach items="${sgmtMap}" var="c">
									<option value="${c.CMM_CD}">${c.CMM_CD_NM} </option>
								</c:forEach>
							</select>
						 