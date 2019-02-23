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

	 <nav class="navbar navbar-expand-md navbar-dark  bg-dark" style="margin-bottom:20px">
		<a class="navbar-brand" href="#">Navbar</a>
     
      	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
        	<span class="navbar-toggler-icon"></span>
      	</button>

     	<div class="collapse navbar-collapse" id="navbarsExampleDefault">
	     	<ul class="navbar-nav mr-auto">
	        	<li class="nav-item active">
	            	<a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
	          	</li>
	          	<li class="nav-item">
	            	<a class="nav-link" href="#">Link</a>
	          	</li>
	          	<li class="nav-item">
	            	<a class="nav-link " href="#">Disabled</a>
	          	</li>
	          	<li class="nav-item dropdown">
	            	<a class="nav-link dropdown-toggle" href="/teamList" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">시스템관리</a>
	            	<div class="dropdown-menu" aria-labelledby="dropdown01">
						<a class="dropdown-item" href="/teamList">팀관리</a>
		              	<a class="dropdown-item" href="/memberList">사원관리</a>
		              	<a class="dropdown-item" href="#">제품관리</a>
		              	<a class="dropdown-item" href="#">코드마스터</a>
		              	<a class="dropdown-item" href="/brandList">브랜드코드마스터</a>
	            	</div>
	          	</li>
	        </ul>
	        <form class="form-inline my-2 my-lg-0">
				<font color="#ffffff"> login</font>
	        </form>
      	</div>
	</nav>



