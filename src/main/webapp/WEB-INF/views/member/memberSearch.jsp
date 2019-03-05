<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>

	
			    <c:forEach items="${empList}" var="i" varStatus="status">
					<tr>
						<td>${i.TEAMNM}</td>
						<td><a href="javascript:memberView('${i.EMP_NO}','update')">${i.EMP_NM}</a></td>
						<td>${i.LOGIN_ID}</td>
						<td>${i.EMP_GRD_CD}</td>
						<td>${i.USE_YN_NM}</td>
					</tr>
				</c:forEach>
						

   