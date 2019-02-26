<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
	<tr>
		<td><a href="javascript:subListView('1');"class="text-decoration-none">1</a></td>
		<td>브랜드명</td>
		<td>서브브랜드명</td>
		<td><a href="javascript:subListView('2');"class="text-decoration-none">용량</a></td>
		<td>주류유형</td>
		<td>당사/타사</td>
		<td>활성화</td>
	</tr>