<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<spring:eval expression="@configProp" var="configProp"></spring:eval>
<c:if test="${!empty errorResult.notNullId}">
	<spring:message var="notNullId" code="${errorResult.notNullId}"/>
</c:if>
<c:if test="${!empty errorResult.notNullPasswd}">
	<spring:message var="notNullPasswd" code="${errorResult.notNullPasswd}"/>
</c:if>
<c:if test="${!empty errorResult.notEqualId}">
	<spring:message var="notEqualId" code="${errorResult.notEqualId}"/>
</c:if>
<c:if test="${!empty errorResult.notEqualPasswd}">
	<spring:message var="notEqualPasswd" code="${errorResult.notEqualPasswd}"/>
</c:if>
<style>
	body {
		font-family: "Lato", sans-serif;
		background-color:#104d8c;
	}
	
	.main-head {
		height: 150px;
		background: #FFF;
	}
	
	.sidenav {
		height: 100%;
		background-color: #d4cece;
		overflow-x: hidden;
		padding-top: 20px;
	}
	
	.main {
		padding: 0px 10px;
	}
	
	@media screen and (max-height: 450px) {
		.sidenav {
			padding-top: 15px;
		}
	}
	
	@media screen and (max-width: 450px) {
		.login-form {
			margin-top: 10%;
		}
		.register-form {
			margin-top: 10%;
		}
	}
	
	@media screen and (min-width: 768px) {
		.main {
			margin-left: 40%;
		}
		.sidenav {
			width: 37%;
			position: fixed;
			z-index: 1;
			top: 0;
			left: 0;
		}
		.login-form {
			margin-top: 80%;
		}
		.register-form {
			margin-top: 20%;
		}
	}
	
	.login-main-text {
		margin-top: 40%;
		padding: 60px;
		color: #fff;
	}
	
	.login-main-text h2 {
		font-weight: 300;
	}
	
	.btn-black {
		background-color: #000 !important;
		color: #fff;
	}
</style>
<div class="container" style="width:100%;height:100%">
	<div class="sidenav" style="background-image:URL(${pageContext.request.contextPath}/resources/image/tb_web_02_1024.jpg);background-repeat: no-repeat;height:52%">
	</div>
	<!-- div class="sidenav" style="background-image:URL(${pageContext.request.contextPath}/resources/image/tb_web_02.jpg);width:100%">
		<div class="login-main-text">
			Login from here to access.
		</div>
	</div-->
	<div class="main" >
		<div class="col-md-6 col-sm-12">
			<div class="login-form">
				<form name="loginForm" method="post"  action="/logInProcess">
					<div class="form-group">
						<label>User Name</label> 
						<input class="form-control" placeholder="UserID" name="loginId" id="loginId"  type="text">
					</div>
					<div class="form-group">
						<label>Password</label> 
						<input class="form-control" placeholder="Password" name="passwd" id="passwd" type="password" value="">
						<c:if test="${!empty notNullId}">
							<p class="regColor">${notNullId}</p>
						</c:if>
						<c:if test="${!empty notEqualId}">
							<p class="regColor">${notEqualId}</p>
						</c:if>
						<c:if test="${!empty notNullPasswd}">
							<p class="regColor">${notNullPasswd}</p>
						</c:if>
						<c:if test="${!empty notEqualPasswd}">
							<p class="regColor">${notEqualPasswd}</p>
						</c:if>
					</div>
					<input type="button"  class="btn btn-black" onclick="goLogin();" value="Login" id="login">
					<input type="hidden" name="returnURL" value="${returnURL}">
				</form>
			</div>
		</div>
	</div>
</div>
<div style="background-image:URL(${pageContext.request.contextPath}/resources/image/tb_web_02_1024.jpg);height: 289px;background-position-y: 1067px;width:100%;bottom:0;position:fixed">
</div>
<script>
	function goLogin() {
		loginForm.submit();
	}
</script>