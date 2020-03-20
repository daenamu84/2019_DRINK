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

<nav class="navbar navbar-expand-md navbar-dark  bg-dark" style="margin-bottom: 20px">
	<a class="navbar-brand" href="#">TB_SMS </a>

	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarsExampleDefault"
		aria-controls="navbarsExampleDefault" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarsExampleDefault" style="flex-direction: row-reverse">
		<div style="padding-left:40px">
		<c:if test="${nul ne loginSession}">
			<font color="#ffffff">|&nbsp;&nbsp;${loginSession.log_nm}</font>
			<a href="/logOut" class="btn btn-default center-block"><font color="#ffffff"> logout</font></a>
		</c:if>
		</div>
		<ul class="navbar-nav">
			<li class="nav-item ${dropdown01}">
				<a class="nav-link dropdown-toggle" href="/proPosalList" id="dropdown01" aria-haspopup="true" aria-expanded="false">프로모션 관리</a>
			</li>
			<li class="nav-item ${dropdown02} dropdown">
				<a class="nav-link dropdown-toggle" href="/callList" id="dropdown02" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">콜조회</a>
				<div class="dropdown-menu" aria-labelledby="dropdown02">
					<a class="dropdown-item" href="/callList">콜 목록</a> 
					<a class="dropdown-item" href="/callCalendar">콜 (Calendar)</a>
				</div>
			</li>
			<li class="nav-item ${dropdown03} dropdown">
				<a class="nav-link dropdown-toggle" href="/vendorList" id="dropdown03" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">업소관리</a>
				<div class="dropdown-menu" aria-labelledby="dropdown03">
					<a class="dropdown-item" href="/vendorList">거래처목록</a> 
					<a class="dropdown-item" href="/ProdMenuList">Distribution</a> 
					<a class="dropdown-item" href="/vendorLedger">Activation</a>
				</div>
			</li>
			<li class="nav-item ${dropdown04} dropdown">
				<a class="nav-link dropdown-toggle" href="/ApprovalList" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">전자결재함</a>
				<div class="dropdown-menu" aria-labelledby="dropdown04">
					<a class="dropdown-item" href="/ApprovalList">전자결재문서</a>
					<c:if test="${loginSession.emp_grd_cd ne '0004'}"> 
					<a class="dropdown-item" href="/ApprovalConfirm">전자결재대기문서</a>
					</c:if>
				</div>
			</li>
			<li class="nav-item ${dropdown06} dropdown">
				<a class="nav-link dropdown-toggle" href="/ApprovalList" id="dropdown06" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">통계</a>
				<div class="dropdown-menu" aria-labelledby="dropdown04">
					<a class="dropdown-item" href="/prod_sumList">제품리스트통계(사원)</a>				
					<a class="dropdown-item" href="/prod_DeptsumList">제품리스트통계(부서)</a>
					<a class="dropdown-item" href="/prod_DisAccountsumList">Distrubution Account</a>
					<a class="dropdown-item" href="/prod_DistrubutionList">Distrubution</a>
					<!-- a class="dropdown-item" href="/ApprovalList">Acctivation Account</a -->
					<a class="dropdown-item" href="/ApprovalList">Activation</a>
				</div>
			</li>
			<c:if test="${loginSession.emp_grd_cd eq '0001'}">
			<li class="nav-item ${dropdown05} dropdown">
				<a class="nav-link dropdown-toggle" href="/teamList" id="dropdown05" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">시스템관리
					<span class="sr-only">(current)</span>
				</a>
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
		
	</div>
</nav>





