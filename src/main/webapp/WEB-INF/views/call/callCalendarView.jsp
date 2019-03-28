<%@page import="java.util.ArrayList"%>
<%@page import="com.drink.commonHandler.util.DataMap"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/page-taglib.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="calendar_date">
	<span>${fn:substring(_pStaDt,0,4)}-${fn:substring(_pStaDt,4,6)}</span>
</div>
<table>
	<colgroup>
		<col style="width:7%;" />
		<col style="width:7%;" />
		<col style="width:12%;" />
		<col style="width:12%;" />
		<col style="width:12%;" />
		<col style="width:12%;" />
		<col style="width:12%;" />
		<col style="width:12%;" />
		<col style="width:12%;" /> 
	</colgroup>
	<tr>
		<th></th>
		<th></th>
		<th>일</th>
		<th>월</th>
		<th>화</th>
		<th>수</th>
		<th>목</th>
		<th>금</th>
		<th>토</th>									
	</tr>
	<c:forEach items="${callCalendar}" var="i" varStatus="status">
			<tr class="cb border-top border-dark" >
				<td class="border border-right-0" colspan="2">
					<div class="">&nbsp;</div>
				</td>
				<td class="border border-right-0  ">
					<div class=""><b>${i.SUN}</b></div>
				</td>
				<td class="border border-right-0  ">
					<div class=""><b>${i.MON}</b></div>
				</td>
				<td class="border border-right-0  ">
					<div class=""><b>${i.TUE}</b></div>
				</td>
				<td class="border border-right-0  ">
					<div class=""><b>${i.WED}</b></div>
				</td>
				<td class="border border-right-0  ">
					<div class=""><b>${i.THU}</b></div>
				</td>
				<td class="border border-right-0  ">
					<div class=""><b>${i.FRI}</b></div>
				</td>
				<td class="border  ">
					<div class=""><b>${i.SAT}</b></div>
				</td>
			</tr>
			<tr class="cb  border-top border-dark">
				<td class="border border-right-0  " rowspan=2>
					<div class="">&nbsp;Plan</div>
				</td>
				<td class="border border-right-0  ">
					<div class="">&nbsp;Account</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.SUN}PLAN"  />
					<c:set var="breakFlag"  value ="true"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${breakFlag}">
								<c:if test="${!js.last }"><label>${j.VENDOR_NM},&nbsp;</label></c:if>
								<c:if test="${js.last}"><label>${j.VENDOR_NM}</label></c:if>
								<c:if test="${js.count == 3}"> 
								<c:set var="breakFlag" value="false"/></c:if> 
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(i[PlanKey]) > 3}">...</c:if>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.MON}PLAN"  />
					<c:set var="breakFlag"  value ="true"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${breakFlag}">
								<c:if test="${!js.last }"><label>${j.VENDOR_NM},&nbsp;</label></c:if>
								<c:if test="${js.last}"><label>${j.VENDOR_NM}</label></c:if>
								<c:if test="${js.count == 3}"> 
								<c:set var="breakFlag" value="false"/></c:if> 
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(i[PlanKey]) > 3}">...</c:if>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.TUE}PLAN"  />
					<c:set var="breakFlag"  value ="true"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${breakFlag}">
								<c:if test="${!js.last }"><label>${j.VENDOR_NM},&nbsp;</label></c:if>
								<c:if test="${js.last}"><label>${j.VENDOR_NM}</label></c:if>
								<c:if test="${js.count == 3}"> 
								<c:set var="breakFlag" value="false"/></c:if> 
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(i[PlanKey]) > 3}">...</c:if>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.WED}PLAN"  />
					<c:set var="breakFlag"  value ="true"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${breakFlag}">
								<c:if test="${!js.last }"><label>${j.VENDOR_NM},&nbsp;</label></c:if>
								<c:if test="${js.last}"><label>${j.VENDOR_NM}</label></c:if>
								<c:if test="${js.count == 3}"> 
								<c:set var="breakFlag" value="false"/></c:if> 
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(i[PlanKey]) > 3}">...</c:if>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.THU}PLAN"  />
					<c:set var="breakFlag"  value ="true"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${breakFlag}">
								<c:if test="${!js.last }"><label>${j.VENDOR_NM},&nbsp;</label></c:if>
								<c:if test="${js.last}"><label>${j.VENDOR_NM}</label></c:if>
								<c:if test="${js.count == 3}"> 
								<c:set var="breakFlag" value="false"/></c:if> 
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(i[PlanKey]) > 3}">...</c:if>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.FRI}PLAN"  />
					<c:set var="breakFlag"  value ="true"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${breakFlag}">
								<c:if test="${!js.last }"><label>${j.VENDOR_NM},&nbsp;</label></c:if>
								<c:if test="${js.last}"><label>${j.VENDOR_NM}</label></c:if>
								<c:if test="${js.count == 3}"> 
								<c:set var="breakFlag" value="false"/></c:if> 
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(i[PlanKey]) > 3}">...</c:if>
					</div>
				</td>
				<td class="border  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.SAT}PLAN"  />
					<c:set var="breakFlag"  value ="true"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${breakFlag}">
								<c:if test="${!js.last }"><label>${j.VENDOR_NM},&nbsp;</label></c:if>
								<c:if test="${js.last}"><label>${j.VENDOR_NM}</label></c:if>
								<c:if test="${js.count == 3}"> 
								<c:set var="breakFlag" value="false"/></c:if> 
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(i[PlanKey]) > 3}">...</c:if>
					</div>
				</td>
			</tr>
			<tr class="cb">
				<td class="border border-right-0  ">
					<div class="">&nbsp;Purpose</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.SUN}PLANP"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${!js.last }"><label>${j},&nbsp;</label></c:if>
							<c:if test="${js.last}"><label>${j}</label></c:if>
						</c:forEach>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.MON}PLANP"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${!js.last }"><label>${j},&nbsp;</label></c:if>
							<c:if test="${js.last}"><label>${j}</label></c:if>
						</c:forEach>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.TUE}PLANP"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${!js.last }"><label>${j},&nbsp;</label></c:if>
							<c:if test="${js.last}"><label>${j}</label></c:if>
						</c:forEach>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.WED}PLANP"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${!js.last }"><label>${j},&nbsp;</label></c:if>
							<c:if test="${js.last}"><label>${j}</label></c:if>
						</c:forEach>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.THU}PLANP"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${!js.last }"><label>${j},&nbsp;</label></c:if>
							<c:if test="${js.last}"><label>${j}</label></c:if>
						</c:forEach>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.FRI}PLANP"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${!js.last }"><label>${j},&nbsp;</label></c:if>
							<c:if test="${js.last}"><label>${j}</label></c:if>
						</c:forEach>
					</div>
				</td>
				<td class="border  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.SAT}PLANP"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${!js.last }"><label>${j},&nbsp;</label></c:if>
							<c:if test="${js.last}"><label>${j}</label></c:if>
						</c:forEach>
					</div>
				</td>
			</tr>
			<tr class="cb  border-top border-dark">
				<td class="border border-right-0  " rowspan=2>
					<div class="">&nbsp;Actual</div>
				</td>
				<td class="border border-right-0  ">
					<div class="">&nbsp;Account</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.SUN}ACUT"  />
					<c:set var="breakFlag"  value ="true"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${breakFlag}">
								<c:if test="${!js.last }"><label>${j.VENDOR_NM},&nbsp;</label></c:if>
								<c:if test="${js.last}"><label>${j.VENDOR_NM}</label></c:if>
								<c:if test="${js.count == 3}"> 
								<c:set var="breakFlag" value="false"/></c:if> 
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(i[PlanKey]) > 3}">...</c:if>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.MON}ACUT"  />
					<c:set var="breakFlag"  value ="true"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${breakFlag}">
								<c:if test="${!js.last }"><label>${j.VENDOR_NM},&nbsp;</label></c:if>
								<c:if test="${js.last}"><label>${j.VENDOR_NM}</label></c:if>
								<c:if test="${js.count == 3}"> 
								<c:set var="breakFlag" value="false"/></c:if> 
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(i[PlanKey]) > 3}">...</c:if>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.TUE}ACUT"  />
					<c:set var="breakFlag"  value ="true"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${breakFlag}">
								<c:if test="${!js.last }"><label>${j.VENDOR_NM},&nbsp;</label></c:if>
								<c:if test="${js.last}"><label>${j.VENDOR_NM}</label></c:if>
								<c:if test="${js.count == 3}"> 
								<c:set var="breakFlag" value="false"/></c:if> 
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(i[PlanKey]) > 3}">...</c:if>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.WED}ACUT"  />
					<c:set var="breakFlag"  value ="true"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${breakFlag}">
								<c:if test="${!js.last }"><label>${j.VENDOR_NM},&nbsp;</label></c:if>
								<c:if test="${js.last}"><label>${j.VENDOR_NM}</label></c:if>
								<c:if test="${js.count == 3}"> 
								<c:set var="breakFlag" value="false"/></c:if> 
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(i[PlanKey]) > 3}">...</c:if>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.THU}ACUT"  />
					<c:set var="breakFlag"  value ="true"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${breakFlag}">
								<c:if test="${!js.last }"><label>${j.VENDOR_NM},&nbsp;</label></c:if>
								<c:if test="${js.last}"><label>${j.VENDOR_NM}</label></c:if>
								<c:if test="${js.count == 3}"> 
								<c:set var="breakFlag" value="false"/></c:if> 
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(i[PlanKey]) > 3}">...</c:if>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.FRI}ACUT"  />
					<c:set var="breakFlag"  value ="true"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${breakFlag}">
								<c:if test="${!js.last }"><label>${j.VENDOR_NM},&nbsp;</label></c:if>
								<c:if test="${js.last}"><label>${j.VENDOR_NM}</label></c:if>
								<c:if test="${js.count == 3}"> 
								<c:set var="breakFlag" value="false"/></c:if> 
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(i[PlanKey]) > 3}">...</c:if>
					</div>
				</td>
				<td class="border  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.SAT}ACUT"  />
					<c:set var="breakFlag"  value ="true"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${breakFlag}">
								<c:if test="${!js.last }"><label>${j.VENDOR_NM},&nbsp;</label></c:if>
								<c:if test="${js.last}"><label>${j.VENDOR_NM}</label></c:if>
								<c:if test="${js.count == 3}"> 
								<c:set var="breakFlag" value="false"/></c:if> 
							</c:if>
						</c:forEach>
						<c:if test="${fn:length(i[PlanKey]) > 3}">...</c:if>
					</div>
				</td>
			</tr>
			<tr class="cb">
				<td class="border border-right-0  ">
					<div class="">&nbsp;Purpose</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.SUN}ACUTP"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${!js.last }"><label>${j},&nbsp;</label></c:if>
							<c:if test="${js.last}"><label>${j}</label></c:if>
						</c:forEach>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.MON}ACUTP"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${!js.last }"><label>${j},&nbsp;</label></c:if>
							<c:if test="${js.last}"><label>${j}</label></c:if>
						</c:forEach>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.TUE}ACUTP"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${!js.last }"><label>${j},&nbsp;</label></c:if>
							<c:if test="${js.last}"><label>${j}</label></c:if>
						</c:forEach>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.WED}ACUTP"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${!js.last }"><label>${j},&nbsp;</label></c:if>
							<c:if test="${js.last}"><label>${j}</label></c:if>
						</c:forEach>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.THU}ACUTP"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${!js.last }"><label>${j},&nbsp;</label></c:if>
							<c:if test="${js.last}"><label>${j}</label></c:if>
						</c:forEach>
					</div>
				</td>
				<td class="border border-right-0  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.FRI}ACUTP"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${!js.last }"><label>${j},&nbsp;</label></c:if>
							<c:if test="${js.last}"><label>${j}</label></c:if>
						</c:forEach>
					</div>
				</td>
				<td class="border  ">
					<c:set var="PlanKey"  value ="${i.YM}${i.SAT}ACUTP"  />
					<div class="">
						<c:forEach items="${i[PlanKey]}" var="j" varStatus="js">
							<c:if test="${!js.last }"><label>${j},&nbsp;</label></c:if>
							<c:if test="${js.last}"><label>${j}</label></c:if>
						</c:forEach>
					</div>
				</td>
			</tr>
		</c:forEach>	
</table>	