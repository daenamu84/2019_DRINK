<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<section>
	<article class="container" style="margin-top:80px;">
		<div class="row col-md-4 col-md-offset-4">
			<div class="alert alert-danger" role="alert">
			<p class="txtCenter">사이트에 에러가 발생 하였습니다.</p>
			</div>
			<input class="btn btn-lg btn-primary btn-block" type="button" onclick="javascrit:location.replace('/main');"  value="메인페이지">
		</div>
	</article>
</section>
