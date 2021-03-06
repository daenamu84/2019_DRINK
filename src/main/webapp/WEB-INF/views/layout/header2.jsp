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
		<a class="navbar-brand" href="#">TB_SMS</a>
     
      	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
        	<span class="navbar-toggler-icon"></span>
      	</button>

     	<div class="collapse navbar-collapse" id="navbarsExampleDefault">
	     	<ul class="navbar-nav mr-auto">
	        	<li class="nav-item active">
	            	<a class="nav-link dropdown-toggle" href="/proPosalList" id="dropdown01"  aria-haspopup="true" aria-expanded="false">프로모션</a>
	          	</li>
	          	<li class="nav-item active dropdown">
	            	<a class="nav-link dropdown-toggle" href="/callList" id="dropdown02" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">업무조회</a>
	            	<div class="dropdown-menu" aria-labelledby="dropdown02">
						<a class="dropdown-item" href="/callList">콜 목록</a>
		              	<a class="dropdown-item" href="javascript:alert('작업중입니다.')">콜 (Calendar)</a>
	            	</div>
	          	</li>
	          	<li class="nav-item active dropdown">
	            	<a class="nav-link dropdown-toggle" href="/vendorList" id="dropdown03" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">업소관리</a>
	            	<div class="dropdown-menu" aria-labelledby="dropdown03">
						<a class="dropdown-item" href="/vendorList">거래처목록</a>
		              	<a class="dropdown-item" href="/ProdMenuList">거래처메뉴</a>
		              	<a class="dropdown-item" href="javascript:alert('작업중입니다.')">거래처 원장</a>
		              	
	            	</div>
	          	</li>
	          	<li class="nav-item">
	            	<a class="nav-link " href="javascript:alert('작업중입니다.')">리포트</a>
	          	</li>
	          	<c:if test="${loginSession.emp_grd_cd eq '0001'}">
	          	<li class="nav-item active dropdown">
	            	<a class="nav-link dropdown-toggle" href="/teamList" id="dropdown05" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">시스템관리 <span class="sr-only">(current)</span></a>
	            	<div class="dropdown-menu" aria-labelledby="dropdown05">
						<a class="dropdown-item" href="/teamList">팀관리</a>
		              	<a class="dropdown-item" href="/memberList">사원관리</a>
		              	<a class="dropdown-item" href="/productManager">제품관리</a>
		              	<a class="dropdown-item" href="/codeList">코드마스터</a>
		              	<a class="dropdown-item" href="/brandList">브랜드코드마스터</a>
	            	</div>
	          	</li>
	          	</c:if>
	        </ul>
	        <form class="form-inline my-2 my-lg-0">
				<c:if test="${nul ne loginSession}">
				<font color="#ffffff">${loginSession.log_nm}님 안녕하세요</font>
				<a href="/logOut" class="btn btn-default center-block"><font color="#ffffff"> logout</font></a>
			</c:if>
	        </form>
      	</div>
	</nav>




