<%@page import="com.awoo.vo.CommutingVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/commuting/style.css">
<title>Insert title here</title>

</head>
<body>

	<div class="container-wrap">
		<div class="header">
			<div class="navbar__toogleBtn" id="mobile-btn">☰</div>
			<img src="${pageContext.request.contextPath}/resources/imges/logo.PNG"/>
            <div class="header-logout">	<a href="${pageContext.request.contextPath}/logout">로그아웃</a> </div>
		</div>
		<div class="container">
			<jsp:include page="../include/menu.jsp"></jsp:include>
			<div class="container-inner-bbs">
			<div class="intro">
				<h3>근무 기록</h3>
				<p></p>
			</div>
				
					<div class="container1">
						<section class="section1">
							<div class="sub-title-container">
								<p class="sub-title">이번 달 근무 현황 그래프</p>
								<p class="sub-title-rate">총 ${getWeekDays}일 중 ${countThisMonth}일 째 </p>
							</div>
							<div class="progress-container">
								<div class="progress-bar-container ">
									<div style="width:100%" class="progress-bar"></div>
									<div style="width:${countThisMonth/getWeekDays*100 >= 100? 100 : countThisMonth/getWeekDays*100}%" class="progress-bar progress-rate"></div>
								</div>
							</div>
							<div class="progress-per">
								<p>|&nbsp;0</p>
								<p>|&nbsp;50%</p>
								<p>|&nbsp;100%</p>
							</div>
							
						</section>
						<section class="section2">
<!-- 							<p class="sub-title">이번 달 근무 상세 현황</p> -->
							<div class="day-rates">
							 	<p>초과 근무 : <span class="work-rates">${overTime}</span></p>
				                <p>지각 : <span class="work-rates">${countLate}</span></p>
				                <p>정상 근무 횟수 : <span class="work-rates">${countNormalCommuting}</span></p>
			                </div>
						</section>					
					</div>
					<div class="container2">
						<div class="inner-div-bbs">
							<!-- 정렬 버튼 -->
								<div class="sorting">
									<p>◎ 출퇴근 관리</p>
									<div>
										<select name="sorting-year" id="sorting-year" onchange="OnChange();">
											<option value="0">전체 연도</option>
											<c:forEach items="${distinctYear}" var="year">
												<option value="${year}" <c:if test ="${year eq param.year}">selected="selected"</c:if>>${year}</option>
											</c:forEach>
										</select>
										<span>년</span>
										<select name="sorting-month" id="sorting-month" onchange="OnChange();">
											<option value="0">전체 월</option>
											<c:forEach begin="1" end="12" var="month">
												<option value="${month}" <c:if test ="${month eq param.month}">selected="selected"</c:if>>${month}</option>
											</c:forEach>
										</select>
										<span>월</span>
									</div>
								</div>
							
								<!-- 게시판 -->
								<div class="list">
					            	<table class="list-table" border="1" >
					            		<thead class="table-head">
						            		<tr>
						            			<th>순서</th>
						            			<th>근무일</th>
						            			<th>출근시간</th>
						            			<th>퇴근시간</th>
						            			<th>근무시간</th>
						            			<th>연장근무시간</th>
<!-- 						            			<th>테스트</th> -->
						            		</tr>
					            		</thead>
					            		<tbody class="table-body" id="table-body">
							            	<c:forEach items="${CommutingList}" var="cl" varStatus="status1">
							            		<tr id="tr${status1.count}">
								            		<td>${cl.id}</td>
								            		<td>${cl.workday}</td>
								            		<td>${cl.startTime}</td>
								            		<td>${cl.endTime != null? cl.endTime : "-"}</td>
								            		<td>${cl.workTime != null? cl.workTime : "-"}</td>
								            		<td>${cl.overTime != null? cl.overTime : "-"}</td>
<%-- 								            		<td>${cl.empno}</td> --%>
							            		</tr>	
							            	</c:forEach>
						            	</tbody>
					            	</table>
					            </div>
							
								<div class="select">
									<div class="num"><a id="prev">◀</a></div>
									
											<%
											int Ppage = Integer.parseInt((String)request.getParameter("page"));
											int begin = (Ppage-1)/10 <= 0 ? 1 : (int)Math.ceil((Ppage-1)/10)*10+1;
											
											
											List<CommutingVO> list = (List<CommutingVO>)request.getAttribute("CommutingList");
											
											int celi = (int)Math.ceil(list.size()/10);
											int endPage = list.size() == 0 ? 1 : celi - begin > 10 ? begin+9 : list.size()%10 == 0 ? celi : celi+1;
											%>
											<c:forEach begin="<%=begin%>" end="<%=endPage%>" varStatus="status" var="var">
									
									
<%-- 											<c:forEach begin="1" end="${CommutingList.size() == 0? 1 : CommutingList.size()%10 == 0? CommutingList.size()/10 :((CommutingList.size()/10)+(1-((CommutingList.size()/10)%1))%1)}" varStatus="status"> --%>
											<c:choose>
												<c:when test="${param.page eq var}">
													<div class="num checked"><span>${var}</span></div>
												</c:when>
												<c:otherwise>				
													<div class="num notchecked"><a href="Commuting?page=${var}&&year=${param.year}&&month=${param.month}">${var}</a></div>							
												</c:otherwise>
											</c:choose>
										</c:forEach>
									<div class="num">
										<a id="next">▶</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		<script type="text/javascript">
		let size = ${CommutingList.size()};
		let page = ${param.page};
		let year = document.getElementById("sorting-year").value;
    	let month = document.getElementById("sorting-month").value;
		
		 document.addEventListener("DOMContentLoaded", function(){

			// 페이지 이동
			for (var i = 0; i < size; i++) {
				if(i+1 > 10*page || i+1 <= 10*(page-1)){
					document.getElementById("tr"+(i+1)).style.display = "none";		
				}
			}
			
			// 순서 아이디 값으로 넣기
			let year = document.getElementById("sorting-year").value;
	    	let month = document.getElementById("sorting-month").value;
	    	let child = document.getElementById("table-body").children;
	    	
	    	
	    	var cnt = 0;
	    	for (let i = 0; i < child.length; i++) {
	    		
	    		// 순서
				child[i].children[0].innerHTML = i+1;
				
				//근무시간미달 표시
				let hourtext = child[i].children[4].innerHTML;
				if(hourtext.split("시간")[0] < 9){
					child[i].children[4].innerHTML = hourtext+"<span class=point>❗<span>";	
				}
				
				// 지각 표시
				let daytext = child[i].children[2].innerHTML;
				let time = daytext.split(":");
				if(time[0] > 9 || (time[0] == 9 && time[1] > 10)){
					child[i].children[2].innerHTML = daytext+"<span class=point>⚡<span>";
				}
	    	}
	    	
		 });
		 
		 
		 
		 
			// 버튼
			var prev = document.getElementById("prev");
			var next = document.getElementById("next");
			
			prev.addEventListener("click",function(){
				var page1 = page-1;
				if(page1 <= 0){
					page1 = 1;
				}
				location.href="${pageContext.request.contextPath}/Commuting?page="+page1+"&&year="+year+"&&month="+month;
			});
			next.addEventListener("click",function(){
				var page1 = page+1;
				if(page1 >= Math.ceil(size/10)){
					page1 = Math.ceil(size/10);
				}
				location.href="${pageContext.request.contextPath}/Commuting?page="+page1+"&&year="+year+"&&month="+month;
			});


		function OnChange(){    
			year = document.getElementById("sorting-year").value;
    		month = document.getElementById("sorting-month").value;
	    	location.href="${pageContext.request.contextPath}/Commuting?page="+1+"&&year="+year+"&&month="+month;
	    };
		
		</script>
	
	
</body>
</html>