<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@ page language="java" contentType="Application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page session="false" %>
<% String jsonData = new ObjectMapper().writeValueAsString(request.getAttribute("resultJson")); %>
<%=jsonData%>
