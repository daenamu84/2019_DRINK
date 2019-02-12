<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html lang="ko-KR">
<head>
<script>
var returnURL ="${returnURL}";
location.replace(decodeURIComponent(returnURL));
</script>
</head>
<body>
</body>
</html>