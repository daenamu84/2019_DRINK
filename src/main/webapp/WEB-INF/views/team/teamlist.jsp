<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<script>
(function() {
	  'use strict';
	  window.addEventListener('load', function() {
	    // Fetch all the forms we want to apply custom Bootstrap validation styles to
	    var forms = document.getElementsByClassName('needs-validation');
	    // Loop over them and prevent submission
	    var validation = Array.prototype.filter.call(forms, function(form) {
	      form.addEventListener('submit', function(event) {
	        if (form.checkValidity() === false) {
	          event.preventDefault();
	          event.stopPropagation();
	        }
	        form.classList.add('was-validated');
	      }, false);
	    });
	  }, false);
	})();
</script>


	<div class="container" style="max-width:100%;">
		<div class="row">
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<div class="container border" style="padding: 5px;">
								<form class="needs-validation" novalidate action="/brandList">
								<div class="row"style="padding-left:20px;">
									<table class="table-borderless ">
										<thead>
											<tr>
												<td><label for="TEAMNM">팀명</label></td>
												<td style="padding-left:20px;">
													<input type="text" class="form-control" name="TEAMNM" id="TEAMNM" required>
													
												</td>
												<td style="padding-left:20px;">사용여부</td>
												<td style="padding-left:20px;"><select name="USE_YN" class="form-control">
													<option value="Y">사용</option>
													<option value="N">사용안함</option>
												</select></td>
												<td>
													<button class="btn btn-primary" type="submit">등록</button>
												</td>
											</tr>
										</thead>
									</table>
								</div>
								</form>
							</div>
						</div>
					</div>
					<div class="row" style="padding-top:10px;">	
						<table class="table">
						  <thead>
						    <tr>
						      <th scope="col">팀 ID</th>
						      <th scope="col">팀명</th>
						      <th scope="col">사용여부</th>
						      <th scope="col">수정</th>
						    </tr>
						  </thead>
						  <tbody>
						    <tr>
						      <td>1</td>
						      <td>Otto</td>
						      <td>@mdo</td>
						      <td>@mdo</td>
						    </tr>
						  </tbody>
						</table>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</div>


   