 <%@page import="com.drink.dto.model.session.SessionDto"%>
<%@page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="com.drink.commonHandler.util.SessionUtils"%>
<%@ page trimDirectiveWhitespaces="true" %>
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<spring:eval expression="@configProp" var="configProp"></spring:eval>
<%
	ApplicationContext ac = RequestContextUtils.getWebApplicationContext(request);
	SessionUtils sessionUtils = (SessionUtils) ac.getBean("SessionUtils");
	SessionDto loginSession = (SessionDto)sessionUtils.getLoginSession(request);
	request.setAttribute("loginSession", loginSession);
%>
<div>
	 <nav class="navbar navbar-inverse navbar-fixed-top">
	        <div class="container-fluid">
	            <div class="navbar-header">             
	            	<!-- 거래처명 노출  -->  
	                <a class="navbar-brand" style="color:#ffffff" href="/main"><c:choose><c:when test="${null eq loginSession.vdNm || empty loginSession.vdNm}">DRINK</c:when> <c:otherwise>${loginSession.vdNm}</c:otherwise></c:choose></a> 
	            </div>
	        </div>
	</nav>
</div>


