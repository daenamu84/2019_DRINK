<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>


<select name="empno" class="form-control" id="empno">
	<c:forEach items="${EmpList}" var="m">
	<option value="${m.EMP_NO}" <c:if test="${emp_no eq m.EMP_NO}">selected</c:if>>${m.EMP_NM} </option>
	</c:forEach>
</select>