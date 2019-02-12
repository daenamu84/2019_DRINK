 <%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>    
<footer id="foot">
	<hr/>
	<div class="container">
		<div class="bdbox pd5">
			<p>drink  업체소개</p>
		</div>	
		<div style="margin: 5px 0px;">
			<c:if test="${nul ne loginSession}">
				<a href="/logOut" class="btn btn-default center-block">로그아웃</a>
			</c:if>
		</div>
	</div>
</footer>