<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>



	<div class="container" style="max-width:100%;">
		<div class="row">
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<div class="container border" style="padding: 5px;">
								<div class="row"style="padding-left:20px;">
									<table class="table-borderless ">
										<thread>
											<tr>
												<td>팀명</td>
												<td style="padding-left:20px;"><input type="text" class="form-control" name="TEAMNM" id="TEAMNM"></td>
												<td style="padding-left:20px;">사용여부</td>
												<td style="padding-left:20px;"><select name="USE_YN" class="form-control">
													<option value="Y">사용</option>
													<option value="N">사용안함</option>
												</select></td>
												<td><input class="btn btn-dark" type="button" value="등록"></td>
											</tr>
										</thread>
									</table>
								</div>
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


   