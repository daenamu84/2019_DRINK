<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page session="false" %>
<!DOCTYPE HTML>
<html lang="ko-KR">
<head>
	<title>Home</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1>
	html 폴더 index.jsp
</h1>
${param} <br>
<%=request.getRequestURL()%> <br>
<%=request.getContextPath()%> <br>
${pageContext.request.contextPath} <br>
${pageContext.request.requestURL}
</body>
</html>
