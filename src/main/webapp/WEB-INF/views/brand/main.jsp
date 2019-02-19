<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>

<div class="">
	<div class="title"> ◈  브랜드코드 마스터</div> 
	<div class="container" style="max-width:100%;">
		<div class="row">
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row">			
						<div class="col">
							<div class="container border" style="padding: 5px;">
								<div class="row">
									<div class="col-sm-2">코드</div>
									<div class="col-sm"><input type="text" class="form-control" /></div>
									<div class="col-sm-2">브랜드명</div>
									<div class="col-sm"><input type="text" class="form-control" /></div>
								</div>
								<div class="row">
									<div class="col-sm-2">사용</div>
									<div class="col-sm">
										<select class="custom-select" id="">
										    <option value="Y" selected>Y</option>
										    <option value="N">N</option>
									  </select>
									</div>
									<div class="col-sm-2">자사/타사</div>
									<div class="col-sm-3">
										<select class="custom-select" id="">
										    <option value="Y" selected>자사</option>
										    <option value="N">타사</option>
									  </select>
									</div>
									<div class="col-sm-1">stcase</div>
									<div class="col-sm"><input type="text" class="form-control" /></div>
								</div>
								<div class="row">
									<div class="col-sm-3">순위</div>
									<div class="col-sm"><input type="text" class="form-control" /></div>
									<div class="col-sm-3"><input class="btn btn-primary" type="button" value="등록"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="row" style="padding-top:10px;">	
						<table class="table">
						  <thead>
						    <tr>
						      <th scope="col">선택</th>
						      <th scope="col">코드</th>
						      <th scope="col">브랜드명</th>
						      <th scope="col">STCASE</th>
						      <th scope="col">자사</th>
						      <th scope="col">순위</th>
						      <th scope="col">사용여부</th>
						    </tr>
						  </thead>
						  <tbody>
						    <tr>
						      <th scope="row"><input type="radio" name="brandMrd"></th>
						      <td>1</td>
						      <td>Otto</td>
						      <td>@mdo</td>
						      <td>@mdo</td>
						      <td>@mdo</td>
						      <td>@mdo</td>
						    </tr>
						    <tr>
						      <th scope="row"><input type="radio" name="brandMrd"></th>
						      <td>2</td>
						      <td>Thornton</td>
						      <td>@fat</td>
						      <td>@mdo</td>
						      <td>@mdo</td>
						      <td>@mdo</td>
						    </tr>
						    <tr>
						      <th scope="row"><input type="radio" name="brandMrd"></th>
						      <td>3</td>
						      <td>the Bird</td>
						      <td>@twitter</td>
						      <td>@mdo</td>
						      <td>@mdo</td>
						      <td>@mdo</td>
						    </tr>
						  </tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="container" style="max-width:100%;">
					<div class="row">
						<div class="col">
							<div class="container border" style="padding: 5px;">
								<div class="row">
									<div class="col-sm-2">코드</div>
									<div class="col-sm"><input type="text" class="form-control" /></div>
									<div class="col-sm-2">브랜드명</div>
									<div class="col-sm"><input type="text" class="form-control" /></div>
								</div>
								<div class="row">
									<div class="col-sm-2">사용</div>
									<div class="col-sm-2">
										<select class="custom-select" id="">
										    <option value="Y" selected>Y</option>
										    <option value="N">N</option>
									  </select>
									</div>
									<div class="col-sm-3">자사/타사</div>
									<div class="col-sm-3">
										<select class="custom-select" id="">
										    <option value="Y" selected>자사</option>
										    <option value="N">타사</option>
									  </select>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-3">순위</div>
									<div class="col-sm"><input type="text" class="form-control" /></div>
									<div class="col-sm-3"><input class="btn btn-primary" type="button" value="등록"></div>
								</div>
							</div>
						</div>
				</div>
				<div class="row" style="padding-top:10px;">	
					<table class="table">
						  <thead>
						    <tr>
						      <th scope="col">선택</th>
						      <th scope="col">코드</th>
						      <th scope="col">브랜드명</th>
						      <th scope="col">사용</th>
						      <th scope="col">자사</th>
						      <th scope="col">순위</th>
						    </tr>
						  </thead>
						  <tbody>
						    <tr>
						      <th scope="row"><input type="radio" name="brandSrd"></th>
						      <td>1</td>
						      <td>Otto</td>
						      <td>@mdo</td>
						      <td>@mdo</td>
						      <td>@mdo</td>
						    </tr>
						    <tr>
						      <th scope="row"><input type="radio" name="brandSrd"></th>
						      <td>2</td>
						      <td>Thornton</td>
						      <td>@fat</td>
						      <td>@mdo</td>
						      <td>@mdo</td>
						    </tr>
						    <tr>
						      <th scope="row"><input type="radio" name="brandSrd"></th>
						      <td>3</td>
						      <td>the Bird</td>
						      <td>@twitter</td>
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