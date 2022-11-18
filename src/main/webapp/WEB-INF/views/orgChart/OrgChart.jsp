<%@page import="com.awoo.vo.InfoVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/main.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/admin/admin1.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/orgChart/orgChart.css">

<title>Insert title here</title>
<style type="text/css">
.org1-img {
	width: 15%;
	padding-right: 1%;
}
#showimg {
	width: 100%;
    height: 100%;
    border-radius: 100%;
	border: 1px solid #dfe7ee;
	box-sizing: content-box;
}
</style>
</head>
<body>
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
					<!-- ------------------------------------------------------------------------------------------- -->
					<div class="tab_wrap">
						<div class="tab_menu">
							<ul class="list">
								<li class="is_on"><a href="#tab1" class="btn" id="tab1">직원 현황</a></li>
								<li><a href="#tab2" class="btn" id="tab2">부서별 안내</a></li>
							</ul>
						</div>
						<!-- ------------------------------------------------------------------------------------- -->
						<div class="tab_div">
							<div class="div_list">
								<div class="main2" id="main2">
									<div class="org">
										<div class="intro">
											<h3>부서별 안내</h3>
											<p></p>
										</div>
										<h3>전체 <span id="count1"></span>명</h3>
										
										<c:forEach var="i" items="${edepartment}">
											<div class="org1-1">
												<h4>${i.edepartment}</h4>
											</div>
											<div class="org1">
												<c:forEach var="j" items="${list1}" varStatus="status">
												<script type="text/javascript">
													let c1 = ${list1.size()};
													const count1 = document.getElementById("count1");
													count1.innerText = c1;
												</script>
													<c:if test="${i.edepartment eq j.edepartment}">
														<div class="org1-main">
															<div class="org1-img">
																<c:choose>
																	<c:when test="${!empty fileList}">
																		<c:forEach var="img" items="${fileList}">
																			<c:if test="${j.empno eq img.ownerId and not empty img.fileName}">
																				<img id="showimg"
																					src="${pageContext.request.contextPath}/upload/${img.fileName}">
																			</c:if>
																		</c:forEach>
																	</c:when>
																</c:choose>
															</div>
															<div class="org1-content">
																<p class="main1p">이름 : ${j.name}(${j.eposition})</p>
																<p class="main1p">번호 : ${j.phoneNumber}</p>
																<p style="white-space: pre-line;">이메일 : ${j.email}</p>
																<div class="main2div">
																	<a class="message" id="modal_open${status.count}">쪽지보내기</a>
																	<c:forEach var="h" items="${checkH}">
																		<c:choose>
																			<c:when
																				test="${(h.countDate > 0) and (h.empno eq j.empno)}">
																				<p style="color: red; margin-left: 15%;">휴가중🖐</p>
																			</c:when>
																			<c:otherwise>
																				<p style="display: none;">휴가중</p>
																			</c:otherwise>
																		</c:choose>
																	</c:forEach>
																</div>

															</div>
														</div>

														<!-- 모달창 -->
															<input name="page" value="${param.page}"
																style="display: none;" />
															<div class="modal_dim" id="modal_dim${status.count}">
																<div class="modal_wrap">
																	<div class="modal">
																		<!-- ---------------------------------------- -->
																		<div class="mdiv1">
																			<h4>${j.name}(${j.eposition})님께쪽지 보내기</h4>
																			<h5 id="exit${status.count}" style="cursor: pointer;">X</h5>
																		</div>
																		<div class="mdiv2">
																				<input id="mreceiverId${status.count}" name="mreceiverId" value="${j.empno}"style="display: none;" />
																			<ul class="mul">
																				<li><label for="mreciever">받는 사람 : </label><br />
																					<input type="text" name="mreciever" id="mreciever${status.count}"
																					value="${j.name}" /></li>
																				<li><label for="mcontent">내용: </label><br /> <textarea
																				 name="mcontent" placeholder="내용을 입력하세요." id="mcontent${status.count}" style="width: 98%;
																					    height: 170px;">
																				</textarea></li>
																			</ul>
																		</div>

																		<div class="mselect"></div>
																		<div class="bdiv">
																			<button class="mbutton" id="mbutton${status.count}">쪽지보내기</button>
																		</div>
																		<script type="text/javascript">
													// 비동기로 쪽지 보내기
										          	
										          	document.getElementById("mbutton"+${status.count}).addEventListener("click", function(){
//											    			alert("쪽지가 	
//											          		성공적으로 보내졌습니다.");
										          		
										    	      		const mreceiverId1 = document.getElementById("mreceiverId"+${status.count}).value;
										    	      		const mcontent1 = document.getElementById("mcontent"+${status.count}).value;
										    					
										    	      		console.log(mreceiverId1);
										    	      		
											    				let simple_data = {
											    									mreceiverId:mreceiverId1,
											    									mcontent:mcontent1
											    									};
										          			
											    				fetch("${pageContext.request.contextPath}/MessageInsert?page=1",{
											    					method : "POST", // PUT, PATCH, DELETE
											    					headers : {"Content-Type" : "application/json"},
											    					body : JSON.stringify(simple_data)
											    				}).then(response => response.json())
										    			
											    				.then(data => {
											    						alert("쪽지가 성공적으로 보내졌습니다.");
											    						document.getElementById("modal_dim"+${status.count}).style.display = "none";
											    					}).catch(error => {
											    					console.log("error");
											    				});
										    			}); 
													</script>
																		<!-- ----------------------------------- -->

																	</div>
																</div>
															</div>
													</c:if>
													<script type="text/javascript">
						/* 모달창 */
						document.getElementById("modal_open"+${status.count}).addEventListener("click",function() {
							document.getElementById("modal_dim"+${status.count}).style.display = "flex";
						});
														
						document.getElementById("exit"+${status.count}).addEventListener("click", function() {
							document.getElementById("modal_dim"+${status.count}).style.display = "none";
						});									
						 
						</script>
												

												</c:forEach>
												<!-- --------------------------------------------------------------------------- -->
											</div>
										</c:forEach>
									</div>
								</div>
								<div class="main1" id="main1">
									<div class="select">
										<div class="intro">
											<h3>직원 현황</h3>
											<p>⏏홈>조직도</p>
										</div>
										<form action="${pageContext.request.contextPath}/orgChart"
											method="get" class="t">
											<input name="page" value="1" style="display: none;" />
											<div class="div1">
												<h4>
													<img
														src="${pageContext.request.contextPath}/resources/imges/admin2.png"
														class="timg2" />직원 상세 검색
												</h4>
												<div class="selectD" style="height: 40px;">
													<select name="edepartment" id="category">
														<option value="">부서 선택</option>
														<c:forEach var = "d" items="${listD}">
															<option value="${d.department}">${d.department}</option>
														</c:forEach>
													</select> <select name="eposition" id="category">
														<option value="">직책 선택</option>
														<c:forEach var = "p" items="${listP}">
															<option value="${p.position}">${p.position}</option>
														</c:forEach>
													</select> <input type="text" name="name" id="category"
														placeholder="이름 검색" />
													<button class="btn1">검색하기</button>
												</div>
											</div>
										</form>
									</div>
									<div class="table" style="width: 100%;">
										<h4>
											<img src="${pageContext.request.contextPath}/resources/imges/total.png"
												class="timg" />총 <span id="count"></span>명
										</h4>
										<div id="EpTable">
											<div class="scroll">
												<table id="table1" class="table1">
													<tr class="table1Tr">
														<th>부서</th>
														<th>직책</th>
														<th>이름</th>
														<th>전화번호</th>
														<th style="width: 20%;">이메일</th>
													</tr>
													<c:forEach var="i" items="${list}" begin="${10*(page-1)}"
														end="${(10*(page-1))+9}">
														<tr class="table1Tr2">
															<td>${i.edepartment}</td>
															<td>${i.eposition}</td>
															<td>${i.name}</td>
															<td>${i.phoneNumber}</td>
															<td>${i.email}</td>
														</tr>

												<script type="text/javascript">
													let c = ${list.size()};
													const count = document.getElementById("count");
													count.innerText = c;
												</script>

												</c:forEach>
											</table>
												<!-- --------------------------------------------------------------  -->
											</div>
											<!-- 페이지 처리 -->
												<div class="paging">

													<c:choose>
														<c:when test="${param.page == 1}">
															<div class="num">
																<span id="prev" class="t">◀</span>
															</div>
														</c:when>
														<c:otherwise>
															<div class="num">
																<a id="prev"
																	href="${pageContext.request.contextPath}/orgChart?page=${param.page-1}&edepartment=${param.edepartment}&eposition=${param.eposition}&name=${param.name}" class="t">◀</a>
															</div>
														</c:otherwise>
													</c:choose>
													<%
													int Ppage = Integer.parseInt((String) request.getParameter("page"));
													int begin = (Ppage - 1) / 10 <= 0 ? 1 : (int) Math.ceil((Ppage - 1) / 10) * 10 + 1;

													List<InfoVO> list = (List<InfoVO>) request.getAttribute("list");

													int celi = (int) Math.ceil(list.size() / 10);
													int endPage = list.size() == 0 ? 1 : celi - begin > 10 ? begin + 9 : celi + 1;
													%>
													<c:forEach begin="<%=begin%>" end="<%=endPage%>"
														varStatus="status" var="var">
														<c:choose>
															<c:when test="${param.page eq var}">
																<div class="num checked">
																	<span class="t">${var}</span>
																</div>
															</c:when>
															<c:otherwise>
																<div class="num notchecked">
																	<a
																		href="${pageContext.request.contextPath}/orgChart?page=${var}&edepartment=${param.edepartment}&eposition=${param.eposition}&name=${param.name}" class="t">${var}</a>
																</div>
															</c:otherwise>
														</c:choose>
														<c:set var="lastNum" value="${status.end}" />
													</c:forEach>
													<c:choose>
														<c:when test="${param.page eq lastNum}">
															<div class="num">
																<span id="next" class="t">▶</span>
															</div>
														</c:when>
														<c:otherwise>
															<div class="num">
																<a id="next"
																	href="${pageContext.request.contextPath}/orgChart?page=${param.page+1}&edepartment=${param.edepartment}&eposition=${param.eposition}&name=${param.name}" class="t">▶</a>
															</div>
														</c:otherwise>
													</c:choose>

												</div>
											<!-- -------------------------------------------------------------------------------------------- -->
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- ----------------------------------------------------------------------------------------- -->

					</div>
					<!-- --------------------------------------------------------------------------------------------- -->
				</div>
			</div>
		</div>
	</div>

	<script>
		/*탭메뉴*/
        const tabList = document.querySelectorAll('.tab_menu .list li');
        const main1 = document.getElementById("main1");
        const main2 = document.getElementById("main2");

        for(var i = 0; i < tabList.length; i++){
          tabList[i].querySelector('.btn').addEventListener('click', function(e){
            e.preventDefault();
            for(var j = 0; j < tabList.length; j++){
              tabList[j].classList.remove('is_on');              
            }
            this.parentNode.classList.add('is_on');
          });
        }

        document.getElementById("tab1").addEventListener("click",function(){
            main1.style.display="block";
            main2.style.display="none";
        });
        
        document.getElementById("tab2").addEventListener("click",function(){
            main1.style.display="none";
            main2.style.display="block";
        });
        
      </script>
      
</body>
</html>