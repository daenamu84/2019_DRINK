<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>

<c:forEach items="${approvalComment}" var="z" varStatus="status">
	<tr>
		<td>${z.EMP_NM}</td>
		<td>${z.COMMENT} (${z.DATA_REG_DTM})&nbsp;
			<c:if test="${emp_no eq z.EMP_NO}">	
				<input class="btn btn-secondary btn-sm float-right" type="button" value="삭제" onClick="Delete_comment('${z.COMMENT_NO}','${z.APPR_NO}')">
			</c:if>
			<input type="hidden"  name="s_comment_no" id="s_comment_no" value="${z.COMMENT_NO}"/>
			<input type="hidden"  name="s_c_appr_no" id="s_c_appr_no" value="${z.APPR_NO}"/>
		</td>
	</tr>
</c:forEach>