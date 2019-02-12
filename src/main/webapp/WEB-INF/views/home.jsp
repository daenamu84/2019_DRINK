<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page session="false" %>
<%
 String protocol = request.getProtocol();
 String serverName = request.getServerName();
 int serverPort = request.getServerPort();
 String remoteAddr = request.getRemoteAddr();
 String remoteHost = request.getRemoteHost();
 String method = request.getMethod();
 StringBuffer requestURL = request.getRequestURL();
 String requestURI = request.getRequestURI();
 String useBrowser = request.getHeader("User-Agent");
 String fileType = request.getHeader("Accept");
 String contextPath = request.getContextPath();
 
%>
<h1>
	Hello world!  
</h1>

<p>${request}</p>
----------------------------------<br>
 프로토콜:<%=protocol%><p>
 서버의 이름:<%=serverName%><p>
 서버의 포트 번호:<%=serverPort%><p>
 사용자 컴퓨터의 주소:<%=remoteAddr%><p>
 사용자 컴퓨터의 이름:<%=remoteHost%><p>
 사용 method:<%=method%><p>
 요청경로(URL):<%=requestURL%><p>
 요청경로(URI):<%=requestURI%><p>
 현재 사용하는 브라우저:<%=useBrowser%><p>
 브라우저가 지원하는 매체(method)의 타입:<%=fileType%><p>
 contextPath : <%=contextPath %> <p>
<%=request.getServletPath().substring(1)%>
<P>  The time on the server is ss :: <spring:message code="message"/>  </P>
<b>${globalTimeStamp} </b>
