<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%  
    response.setHeader("Cache-Control","no-store");  
    response.setHeader("Pragma","no-cache");  
    response.setDateHeader("Expires",0);  
 
    if (request.getProtocol().equals("HTTP/1.1")) {
        response.setHeader("Cache-Control", "no-cache");
    }
%>  
<head>
    <tiles:insertAttribute name="metaTag" ignore ="true"/>
    <tiles:insertAttribute name="headerScript" />
</head>
<body>
		<tiles:insertAttribute name="header" />
		<tiles:insertAttribute name="body" />
		<tiles:insertAttribute name="footer" />
		<tiles:insertAttribute name="footerScript" />
</body>