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

<div id='cssmenu'>
	<ul>
		<li><a href='#'><span>Home</span></a></li>
		<li class='active has-sub'><a href='#'><span>Products</span></a>
			<ul>
				<li class='has-sub'><a href='#'><span>Product 1</span></a>
					<ul>
						<li><a href='#'><span>Sub Product</span></a></li>
						<li class='last'><a href='#'><span>Sub Product</span></a></li>
					</ul>
				</li>
				<li class='has-sub'><a href='#'><span>Product 2</span></a>
					<ul>
						<li><a href='#'><span>Sub Product</span></a></li>
						<li class='last'><a href='#'><span>Sub Product</span></a></li>
					</ul>
				</li>
			</ul>
		</li>
		<li><a href='#'><span>About</span></a></li>
		<li class='last'><a href='#'><span>Contact</span></a></li>
	</ul>
</div>




