<%@page import="com.awoo.vo.HolidayVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/main.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/admin/admin1.css">
<title>Insert title here</title>
<style type="text/css">

	.modal_wrap{
		max-height: 200px;
		min-height: 200px;
	}
	
	#rejec{
		margin-top: 15px;
	    border: 10p;
	    padding: 5px;
	    border: 1px solid #afb7bc;
	}
</style>
</head>
<body>
<script type="text/javascript">
	</script>
	<div class="container-wrap">
		<div class="header">
			<div class="navbar__toogleBtn" id="mobile-btn">☰</div>
			<img src="${pageContext.request.contextPath}/resources/imges/logo.PNG" />
			<div class="header-logout">
				<a href="${pageContext.request.contextPath}/logout">로그아웃</a>
			</div>
		</div>
		<div class="container">
			<jsp:include page="../include/menu.jsp"></jsp:include>
			<div class="container-inner-bbs">
				<div class="inner-div-bbs">
					<div class="select">
						<div class="intro">
							<h3>휴가 신청 관리</h3>
							<p></p>
						</div>
							<form action="${pageContext.request.contextPath}/holidayAdmin">
							<input name="page" value="1" style="display: none;"/>
							<div class="div1 holidayAdminCss">
								<div class="selectD">
									<select name="hwriteDate" id="hwriteDate" class="category">
										<option value="">전체 연도</option>
										<c:forEach var = "y" items="${year}">
											<option value="${y.hwriteDate}">${y.hwriteDate}</option>
										</c:forEach>
									</select> <select name="htype" id="htype" class="category">
										<option value="">휴가 종류</option>
										<option value="연차">연차</option>
										<option value="반차">반차</option>
									</select> <select name="edepartment" id="edepartment" class="category">
										<option value="">부서</option>
										<c:forEach var = "d" items="${listD}">
											<option value="${d.department}">${d.department}</option>
										</c:forEach>
									</select>
									<button class="btn1" id="btn1">검색하기</button>
								</div>
							</div>
						</form>
					</div>

					<!-- 리스트 --------------------------------------------------------------------------------- -->
					<div class="table1 tablecss">
<!-- 						<div id="EpTable"> -->
							<div class="scroll">
								<table id="table1" class="table1">
									<tr>
										<th>신청일</th>
										<th>이름</th>
										<th>유형</th>
										<th>종류</th>
										<th>기간</th>
										<th>일수</th>
										<th>내용</th>
										<th></th>
										<th></th>
										<th></th>
										<th>상세보기</th>
									</tr>
									<c:forEach var="i" items="${list}" begin="${10*(page-1)}"
										end="${(10*(page-1))+9}" varStatus="status">
										<tr>
											<td>${i.hwriteDate}</td>
											<c:set var="loof_flag" value="false" />
											<c:forEach var="j" items="${depart}">
												<c:if test="${not loof_flag}">
													<c:choose>
														<c:when test="${i.empno eq j.empno}">
															<td>${i.huserName}(${j.edepartment})</td>
															<c:set var="loof_flag" value="true" />
														</c:when>
													</c:choose>
												</c:if>
											</c:forEach>
											<c:choose>
												<c:when test="${i.approval eq '요청중'}">
													<td><div class="req">신청</div></td>
												</c:when>
												<c:when test="${i.approval eq '승인'}">
													<td><div class="req1">${i.approval}</div></td>
												</c:when>
												<c:otherwise>
													<td><div class="req2">${i.approval}</div></td>
												</c:otherwise>
											</c:choose>
											<td>${i.htype}</td>
											<td>${i.hstartDate}~${i.hendDate}</td>
											<td>${i.countDate}</td>
											<td
												style="max-width: 120px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${i.hcontent}</td>
											<td></td>
											<td></td>
											<td><c:choose>
													<c:when test="${i.approval eq '요청중'}">
														<a class="rbtn1" id="modal_open${status.count}" value1="${i.id}">반려</a>
														<a class="rbtn2"
															href="${pageContext.request.contextPath}/holiday/Ok/${i.id}?empno=${i.empno}&countDate=${i.countDate}&page=${param.page}">승인</a>
														<!-- 모달창 -------------------------------------------------------------------------------- -->
															<form action="${pageContext.request.contextPath}/holiday/No/${i.id}" method="get" id="form">
																<input name="page" value="${param.page}" style="display: none;"/>
																<div class="modal_dim" id="modal_dim${status.count}">
																	<div class="modal_wrap">
																		<div class="modal">
																			<div class="mdiv1">
																				<h4>반려 사유</h4>
																				<h5 id="exit${status.count}">X</h5>
																			</div>
																			<div>
																				<input type="text" name="rejectionReason" id="rejec" placeholder="반려사유를 입력해주세요." required/>
																			</div>
																			<div class="bdiv">
																				<button class="mbutton" id="mbutton">등록하기</button>
																			</div>
																		</div>
																	</div>
																</div>
															</form>
															<script type="text/javascript">
															/* 반려모달창 */																
																	document.getElementById("modal_open"+${status.count}).addEventListener("click",function() {
															 			document.getElementById("modal_dim"+${status.count}).style.display = "flex";
															 		});
															
																	document.getElementById("exit"+${status.count}).addEventListener("click", function() {
																		document.getElementById("modal_dim"+${status.count}).style.display = "none";
																	});
															</script>
															<!-- ----------------------------------------------------------------------------------------- -->
													</c:when>
													<c:when test="${i.approval eq '승인'}">
														${i.approvalDate}
													</c:when>
													<c:when test="${i.approval eq '반려'}">
														${i.rejectionReason}
													</c:when>
												</c:choose></td>
											<td id="detail${status.count}" class="detail"
												value1="${i.id}" value2="${i.empno}" style="color: #ababaf;"><img src="${pageContext.request.contextPath}/resources/imges/magni-icon.png" /></a></td>
										</tr>
									</c:forEach>
								</table>
								<!-- 상세보기 모달 -->
								<div class="modal_dim" id="modal_dim_detail">
									<div class="modal_wrap"
										style="width: 30%;min-height: 60%;">
										<div class="modal">
											<div class="mdiv1">
												<div style="display: flex; width: 80%">
													<h4 style="margin-right: 5%;">휴가 신청 상세보기</h4>
													<span id="pop-approval"></span>
												</div>
												<div>
													<h5 id="detailExit">X</h5>
												</div>
											</div>
											<div class="detail-container">

												<div></div>
												<table class="DTable">
													<tr>
														<td>휴가 신청일</td>
														<td><span id="pop-writeDate"></span></td>
													</tr>
													<tr>
														<td>휴가 종류</td>
														<td><span id="pop-halfDay"></span><span
															id="pop-htype"></span></td>
													</tr>
													<tr>
														<td>기간</td>
														<td><span id="pop-hstartDate"></span>&nbsp;~&nbsp;<span
															id="pop-hendDate"></span></td>
													</tr>
													<tr>
														<td>일수</td>
														<td><span id="pop-countDate"></span></td>
													</tr>
													<tr>
														<td style="height: 50%;">신청 내용</td>
														<td
															style="max-width: 120px; overflow: hidden; text-overflow: ellipsis; white-space: normal;"><span
															id="pop-hcontent"></span></td>
													</tr>
												</table>

												<div class="approval-container">
													<div class="approvalDate">
														결재일: <span id="pop-approvalDate">넣을 예정</span>
													</div>
													<div id="reject" class="reject">
														반려사유: <span id="pop-rejection_reason">넣을 예정</span>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								
							</div>
							<!-- 페이지 처리 -->
							<div class="paging">
								<c:choose>
									<c:when test="${param.page == 1}">
										<div class="num">
											<span id="prev">◀</span>
										</div>
									</c:when>
									<c:otherwise>
										<div class="num">
											<a id="prev" href="${pageContext.request.contextPath}/holidayAdmin?page=${param.page-1}&hwriteDate=${param.hwriteDate}&htype=${param.htype}&edepartment=${param.edepartment}">◀</a>
										</div>
									</c:otherwise>
								</c:choose>
									<%
									int Ppage = Integer.parseInt((String) request.getParameter("page"));
									int begin = (Ppage - 1) / 10 <= 0 ? 1 : (int) Math.ceil((Ppage - 1) / 10) * 10 + 1;

									List<HolidayVO> list = (List<HolidayVO>) request.getAttribute("list");

									int celi = (int) Math.ceil(list.size() / 10);
									int endPage = list.size() == 0 ? 1 : celi - begin > 10 ? begin + 9 : celi + 1;
									%>
									<c:forEach begin="<%=begin%>" end="<%=endPage%>"
										varStatus="status" var="var">
										<c:choose>
											<c:when test="${param.page eq var}">
												<div class="num checked">
													<span>${var}</span>
												</div>
											</c:when>
											<c:otherwise>
												<div class="num notchecked">
													<a href="${pageContext.request.contextPath}/holidayAdmin?page=${var}&hwriteDate=${param.hwriteDate}&htype=${param.htype}&edepartment=${param.edepartment}">${var}</a>
												</div>
											</c:otherwise>
										</c:choose>
										<c:set var="lastNum" value="${status.end}" />
									</c:forEach>
									<c:choose>
										<c:when test="${param.page eq lastNum}">
											<div class="num">
												<span id="next">▶</span>
											</div>
										</c:when>
										<c:otherwise>
											<div class="num">
												<a id="next" href="${pageContext.request.contextPath}/holidayAdmin?page=${param.page+1}&hwriteDate=${param.hwriteDate}&htype=${param.htype}&edepartment=${param.edepartment}">▶</a>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
						</div>
					<!-- ------------------------------------------------------------------------------ -->
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">

		let size = ${list.size()};
		
		 // 비동기로 상세보기 가져옴
	 	 for (let k = 1; k <= size; k++) {
	 		 
	 		 document.getElementById("detail"+k).addEventListener("click",function(){
				document.getElementById("modal_dim_detail").style.display = "flex";
				
				document.getElementById("detailExit").addEventListener("click", function() {
					document.getElementById("modal_dim_detail").style.display = "none";
				});
				
				let id1 = document.getElementById("detail"+k).getAttribute("value1");
				let empno1 = document.getElementById("detail"+k).getAttribute("value2");
				
				let simple_data = {
									id:id1,
									empno:empno1
									};
				
				fetch("${pageContext.request.contextPath}/holiday/detailAdmin",{
					method : "POST", // PUT, PATCH, DELETE
					headers : {"Content-Type" : "application/json"},
					body : JSON.stringify(simple_data)
				}).then(response => response.json())
			
				.then(data => {

					document.getElementById("pop-writeDate").innerHTML=data.hwriteDate;
					document.getElementById("pop-htype").innerHTML=data.htype;
					document.getElementById("pop-halfDay").innerHTML=data.halfDay;
					document.getElementById("pop-hstartDate").innerHTML=data.hstartDate;
					document.getElementById("pop-hendDate").innerHTML=data.hendDate;
					document.getElementById("pop-countDate").innerHTML=data.countDate+"일";
					document.getElementById("pop-hcontent").innerHTML=data.hcontent;
					document.getElementById("pop-approval").innerHTML=data.approval;
					if(data.rejectionReason == null || data.rejectionReason == ""){
						document.getElementById("reject").style.visibility = "hidden";
					}else{
						document.getElementById("pop-rejection_reason").innerHTML=data.rejectionReason;
					}	
					if(data.approvalDate == null || data.approvalDate == ""){
						document.getElementById("pop-approvalDate").innerHTML="미확인";
					}else{
						document.getElementById("pop-approvalDate").innerHTML=data.approvalDate;
					}
				}).catch(error => {
					console.log("error");
				});
			}); 
	 		
	 	 }
		
	</script>
	
</body>
</html>