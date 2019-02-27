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
<div class="container">
	<c:if test="${configProp['sever.statement'] eq 'DEV'}">
   		<div style="float:right;color:#ffffff;">개발</div>
   	</c:if> 
    <div class="row">
    	<div class="col-md-4 offset-4 new-wrap">
    		<div class="panel panel-default">
			  	<div class="panel-heading">해당 서비스는 이용자만<span class="br-block"></span> 가능합니다.</div>
			  	<div class="panel-body">
			    	<form name="loginForm" method="post"  action="/logInProcess">
                    <fieldset>
			    	  	<div class="form-group">
			    		    <input class="form-control" placeholder="UserID" name="loginId" id="loginId"  type="text">
							<%-- 
							<%
								if( notNullId != null && "".equals(notNullId) ){
							%>
									<p class="regColor"><%=notNullId %></p>
							<%
								}
							%>
							 --%>
			    		</div>
			    		<div class="form-group">
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
			    		<input class="btn btn-lg btn-success btn-block" type="button" onclick="goLogin();"  value="로그인">
			    		<input type="hidden" name="returnURL" value="${returnURL}">
			    	</fieldset>
			      	</form>
			    </div>
			</div>
		</div>
	</div>
</div>
<script>
	function goLogin(){
		loginForm.submit();
	}
</script>