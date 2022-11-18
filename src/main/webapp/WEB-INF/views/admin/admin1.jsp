<%@page import="com.awoo.vo.InfoVO"%>
<%@page import="com.awoo.vo.PersonalInfoVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/admin/admin1.css">
<title>Insert title here</title>
</head>
<body>
	<div class="container-wrap">
		<div class="header">
			<div class="navbar__toogleBtn" id="mobile-btn">☰</div>
			<img src="${pageContext.request.contextPath}/resources/imges/logo.PNG" />
			<div class="header-logout">   <a href="${pageContext.request.contextPath}/logout">로그아웃</a> </div>
		</div>
		<div class="container">
			<jsp:include page="../include/menu.jsp"></jsp:include>
			<div class="container-inner-bbs">
				<div class="inner-div-bbs">
					<div class="select">
						<div class="intro">
							<h3>직원 정보 관리</h3>
							<p></p>
						</div>
						<form action="${pageContext.request.contextPath}/admin" method="get">
							<input name="page" value="1" style="display: none;" />
							<div class="div1">
								<h4>
									<img src="${pageContext.request.contextPath}/resources/imges/admin2.png"
										class="timg2" />직원 상세 검색
								</h4>
								<div class="selectD">
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
									</select> <select name="ehiredType" id="category">
										<option value="">고용 형태 선택</option>
										<option value="정규직">정규직</option>
										<option value="비정규직">비정규직</option>
									</select>
									<div id="category" onclick="test()">
										<p id="categoryA">상세조건</p>
										<img id="categoryA"
											src="${pageContext.request.contextPath}/resources/imges/down.JPG">
									</div>
									<button class="btn1">검색하기</button>
								</div>
								<div id="detailS">
									<table id="t1">
										<tr class="t1-tr">
											<td>재직상태</td>
											<td>
												<select name="estatus" id="estatus1">
													<option value="">재직 상태 선택</option>
													<option value="재직">재직</option>
													<option value="퇴직">퇴직</option>
													<option value="휴직">휴직</option>
												</select>
											</td>
											<td class="nametd">
												<span>이름</span>
												<input type="text" name="name" id="name" placeholder="이름을 검색해 주세요" style="ime-mode:active;"/>
											</td>
										</tr>
									</table>
									<table id="t2">
										<tr class="t2-tr">
											<td>입사기간</td>
											<td class="t2-td1">
											<div class="minput">
												<input type="date" name="ehiredDate" id="startDate"
													placeholder="(시작일)">&nbsp;&nbsp;~&nbsp;&nbsp;<input type="date"
													name="date" id="endDate" placeholder="(종료일)">
											</div>
												<div class="m3">
													<span id="s1" class="styleA" onclick="change()">최근 1개월</span>
													<span id="s2" class="styleA" onclick="change()">최근 2개월</span>
													<span id="s3" class="styleA" onclick="change()">최근 3개월</span>
												</div>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</form>
					</div>
					<div class="table" style="width: 100%;">
						<h4>
							<img src="${pageContext.request.contextPath}/resources/imges/total.png"
								class="timg" />총 <span id="count"></span>명 <span class="sp">(퇴사자 포함)</span>
						</h4>
						<form action="${pageContext.request.contextPath}/admin/updateD"
							method="get" id="form1">
							
							<div id="EpTable">
								<div class="tbtn1">
									<button id="modal_open" type="button">선택 직원 정보 수정</button>
									<button id="newEp" type="button">신규 직원 등록</button>
								</div>
								<div class="scroll">

									<table id="table1" class="table1">
										<tr>
											<th><input type="checkbox" name="allCheck" id="allCheck"
												onclick="checkAll()"></th>
											<th>No.</th>
											<th>이름</th>
											<th>사원번호</th>
											<th>부서</th>
											<th>직책</th>
											<th>입사일</th>
											<th>고용형태</th>
											<th>총 연차 수</th>
											<th>재직 상태</th>
											<th>상세보기</th>
										</tr>
										<c:forEach var="i" items="${list}" begin="${10*(page-1)}"
											end="${(10*(page-1))+9}">
											<tr>
												<td><input type="checkbox" name="empno" id="empno"
													value="${i.empno}" value1="${i.name}" value2="${i.edepartment}"></td>
												<td>${i.id}</td>
												<td>${i.name}</td>
												<td>${i.empno}</td>
												<td>${i.edepartment}</td>
												<td>${i.eposition}</td>
												<td>${i.ehiredDate}</td>
												<td>${i.ehiredType}</td>
												<td>${i.totalHoliday}</td>
												<td>${i.estatus}</td>
												<td><a
													href="${pageContext.request.contextPath}/admin/detail/${i.id}?empno=${i.empno}" style="color: #ababaf;"><img src="${pageContext.request.contextPath}/resources/imges/magni-icon.png" /></a></td>
											</tr>
											
											<script type="text/javascript">
												let c = ${list.size()};
												const count = document.getElementById("count");
												count.innerText = c;
											</script>
											
										</c:forEach>
									</table>
								</div>
								<!-- 페이징 처리 -->
									<div class="paging">
										
										<c:choose>
										<c:when test="${param.page == 1}">
											<div class="num">
												<span id="prev">◀</span>
											</div>
										</c:when>
										<c:otherwise>
											<div class="num">
												<a id="prev" href="${pageContext.request.contextPath}/admin?page=${param.page-1}
												&edepartment=${param.edepartment}
														&eposition=${param.eposition}&ehiredType=${param.ehiredType}
														&estatus=${param.estatus}&ehiredDate=${param.ehiredDate}&date=${param.date}">◀</a>
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
														<span>${var}</span>
													</div>
												</c:when>
												<c:otherwise>
													<div class="num notchecked">
														<a href="${pageContext.request.contextPath}/admin?page=${var}&edepartment=${param.edepartment}
														&eposition=${param.eposition}&ehiredType=${param.ehiredType}
														&estatus=${param.estatus}&ehiredDate=${param.ehiredDate}&date=${param.date}">
														${var}</a>
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
													<a id="next" href="${pageContext.request.contextPath}/admin?page=${param.page+1}
													&edepartment=${param.edepartment}
														&eposition=${param.eposition}&ehiredType=${param.ehiredType}
														&estatus=${param.estatus}&ehiredDate=${param.ehiredDate}&date=${param.date}">▶</a>
												</div>
											</c:otherwise>
										</c:choose>

									</div>
								
							</div>
						<!-- 선택 직원 정보 수정 -->
							<div class="modal_dim" id="modal_dim">
								<div class="modal_wrap">
									<div class="modal">
										<div class="mdiv1">
											<h4>선택 직원정보 수정</h4>
											<h5 id="exit">X</h5>
										</div>
										<div class="mdiv2">
											<h4>
												선택직원 <span id="mspan"></span>명
											</h4>
											<div class="mdiv2-1">
												<h5 style="color: #aaabad;">직원추가</h5>
												<div class="sdiv">
													<input type="text" name="userKeyWord" id="userKeyWord" class="minput" onclick="filter()"
													onkeyup="filter()" autocomplete='off' placeholder="입력해주세요" onsubmit="return false;">
													<div id="suggestdiv">
														<c:forEach var="j" items="${list}" varStatus="status">
															<div class="info">
																<span class="name" id="name${status.count}" style="color: black" 
																value1="${j.name}" value2="${j.edepartment}" value3="${j.empno}">${j.name}</span>
																(${j.edepartment})
															</div>
														</c:forEach>
													</div>
												</div>
											</div>
										</div>
										<div class="mdiv3">
											<ul id="ul"></ul>
										</div>
										<div class="mselect">
											<div class="sdiv1">
												<h4>부서</h4>
												<select name="edepartment" id="mcategory" class="m">
													<option value="">변경없음</option>
													<c:forEach var="d" items="${listD}">
														<option value="${d.department}">${d.department}</option>
													</c:forEach>
												</select>
											</div>
											<div class="sdiv2">
												<h4>직책</h4>
												<select name="eposition" id="mcategory" class="m">
													<option value="">변경없음</option>
													<c:forEach var="p" items="${listP}">
														<option value="${p.position}">${p.position}</option>
													</c:forEach>
												</select>
											</div>
											<div class="sdiv3">
												<h4>고용형태</h4>
												<select name="ehiredType" id="mcategory" class="m">
													<option value="">변경없음</option>
													<option value="정규직">정규직</option>
													<option value="비정규직">비정규직</option>
												</select>
											</div>
											<div class="sdiv4">
												<h4>재직상태</h4>
												<select name="estatus" id="mcategory" class="m">
													<option value="">변경없음</option>
													<option value="재직">재직</option>
													<option value="퇴직">퇴직</option>
													<option value="휴직">휴직</option>
												</select>
											</div>
										</div>
										<input name="page" value="1" style="display: none;" />
										<div class="bdiv">
											<button class="mbutton">수정하기</button>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
					<!-- ------------------------------------------------------------------------------ -->
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	
	function filter(){
  	  document.querySelector("#suggestdiv").style.display="block";
        let value = document.getElementById("userKeyWord").value;
        let name = document.getElementsByClassName("name");
        
        for(let i=0;i<name.length;i++){
     		if(name[i].innerHTML.indexOf(value) > -1){
     				name[i].parentNode.style.display = "block";
	            }else{
	            	name[i].parentNode.style.display = "none";
	            }
     	  }
        
     }	
		
		/*신규 직원 등록*/
		document.getElementById("newEp").addEventListener("click", function() {
			location.href = "${pageContext.request.contextPath}/admin/newE";
		});
		/*리스트 전체 체크*/
		function checkAll() {
			const checkboxes = document.getElementsByName("empno");
			if (document.getElementById("allCheck").checked == true) {
				for (var i = 0; i < checkboxes.length; i++)
					checkboxes[i].checked = true;
			}
			if (document.getElementById("allCheck").checked == false) {
				for (var i = 0; i < checkboxes.length; i++)
					checkboxes[i].checked = false;
			}
		}

		/*상세 보기 display*/
		function test() {
			var con = document.getElementById("detailS");
			con.style.display = (con.style.display != 'none') ? "none" : "flex";
		}

		/*버튼 변화 (1개월,2개월,3개월)*/
		var s = [ "s1", "s2", "s3" ];

		function change() {

			var save = "";
			var index = "";
			var month = "";

			for (let i = 0; i < s.length; i++) {
				document
						.getElementById(s[i])
						.addEventListener(
								"click",
								function() {
									if (document.getElementById(s[i]).classList
											.contains("styleA")) {
										document.getElementById(s[i]).classList
												.replace("styleA", "styleB");
										month = s[i].substring(1, 2);
										let d = new Date();
										d.setMonth(d.getMonth() - (month));
										document.getElementById("endDate").valueAsDate = new Date();
										document.getElementById("startDate").valueAsDate = d;
										save = s[i];
										index = i;
										s.splice(i, 1);
										for (let j = 0; j < s.length; j++) {
											if (document.getElementById(s[j]).classList
													.contains("styleB")) {
												document.getElementById(s[j]).classList
														.replace("styleB",
																"styleA");
											}
										}
										s.splice(index, 0, save);
									}
								});
			}
		}

		/*날짜 설정(1개월, 2개월,3개월)*/
		document.getElementById("startDate").addEventListener(
				"click",
				function() {
					for (let i = 0; i < s.length; i++) {
						if (document.getElementById(s[i]).classList
								.contains("styleB")) {
							document.getElementById(s[i]).classList.replace(
									"styleB", "styleA");
						}
					}
					document.getElementById("startDate").valueAsDate = null;
					document.getElementById("endDate").valueAsDate = null;
				});

		const checkboxes = document.getElementsByName("empno");
		const ul = document.getElementById("ul");
		const mspan = document.getElementById("mspan");
		const li1 = document.getElementsByName("li1");
		
		/*------------------------------------------------------------------------------------------------*/
		/*모달창 켜기*/
		document
				.getElementById("modal_open")
				.addEventListener(
						"click",
						function() {
							const checkboxes = document
									.getElementsByName("empno");
							var j = 0;
							for (var i = 0; i < checkboxes.length; i++) {
								if (checkboxes[i].checked == true) {
									j++;
								}
							}
							if (j > 0) {
								document.getElementById("modal_dim").style.display = "flex";
							} else {
								alert("정보를 수정할 직원을 선택해 주세요.");
							}

						});
		/*------------------------------------------------------------------------------------------------*/
	/* 모달창 끄기*/
			
			document.getElementById("exit").addEventListener("click", function() {
				document.getElementById("modal_dim").style.display = "none";	
					
					const checkboxes = document.getElementsByName("empno");
					
					for (var i = 0; i < checkboxes.length; i++){							
					if (checkboxes[i].checked == true) {
							checkboxes[i].checked = false;
						}
					}

					const ul = document.getElementById("ul");
		
					while(ul.hasChildNodes()){
						ul.removeChild( ul.firstChild );  
					}
					
					document.getElementById("userKeyWord").value="";
	                	  suggestdiv.style.display = "none";
					  while(document.getElementById("suggest").firstChild)  {
						  document.getElementById("suggest").firstChild.remove()
					  }
		
			});
			/*------------------------------------------------------------------------------------------------*/
		/*모달창 div에 li추가*/
		let num = 0;

		document.getElementById("modal_open").addEventListener(
				"click",
				function() {
					const ul = document.getElementById("ul");
					const checkboxes = document.getElementsByName("empno");
					const mspan = document.getElementById("mspan");
					for (var i = 0; i < checkboxes.length; i++) {
						if (checkboxes[i].checked) {
							const li = document.createElement("li");
							const name = checkboxes[i].getAttribute("value1");
							const edepartment = checkboxes[i]
									.getAttribute("value2");
							const span = document.createElement("span");

							span.innerText = "X";
							span.setAttribute("value", name);
							span.setAttribute("name", "span1");
							
							li.innerText = name + "(" + edepartment + ")";
							li.setAttribute("name", "li1");
							li.setAttribute("value", name);
							li.append(span);
							
							ul.append(li); 
						}						
					}

					/*------------------------------------------------------------------------------------------------*/
					/*모달창 span 삭제*/
					const span1 = document.getElementsByName("span1");
					for (var i = 0; i < span1.length; i++) {
					span1[i].addEventListener("click", function(e) {
						const checkboxes = document.getElementsByName("empno");
						const del = e.target;  // span ("X")
			 			const deleteAll = del.parentNode; // <li><span></span></li>				 			
			 			for (var j = 0; j < checkboxes.length; j++) {
							if(del.getAttribute("value") == checkboxes[j].getAttribute("value1")){
				 					checkboxes[j].checked = false;
				 					deleteAll.remove();
							}	
						}
			 				const li1 = document.getElementsByName("li1");
							num = li1.length;
							mspan.innerText = num;
						});
					}
					/*------------------------------------------------------------------------------------------------*/
					const li1 = document.getElementsByName("li1");
					num = li1.length;
					mspan.innerText = num;					
				});
		
		/*------------------------------------------------------------------------------------------------*/
		/*검색 이름 추가*/
			let name = document.getElementsByClassName("name");
			
			for (var i = 1; i < name.length; i++) {
				document.getElementById("name"+i).addEventListener("click",function(e){
					const ul = document.getElementById("ul");
					const li = document.createElement("li");
					const name1 = e.target.getAttribute("value1");
					const department1 = e.target.getAttribute("value2");
					const empno1 = e.target.getAttribute("value3");
					li.innerText = name1 + "(" + department1 + ")";
					li.setAttribute("name", "li1");
					li.setAttribute("value", name1);

					const input = document.createElement("input");
				    input.setAttribute("type","checkbox");
				    input.setAttribute("name","empno");
				    input.setAttribute("value",empno1);
				    input.style.display='none';
					input.checked=true;
					
					const span = document.createElement("span");
					span.innerText = "X";
					span.setAttribute("value", name1);
					span.setAttribute("name", "span1");
					span.setAttribute("value1", empno1);
					li.append(span);
					li.append(input);
					ul.append(li);
					
					const checkboxes = document.getElementsByName("empno");
					for (var j = 0; j < checkboxes.length; j++) {
					if(span.getAttribute("value") == checkboxes[j].getAttribute("value1")){
		 					checkboxes[j].checked = true;
					}
					
				}
					
				/*------------------------------------------------------------------------------------------------*/
				/*모달창 span 삭제*/
					const span1 = document.getElementsByName("span1");
				for (var i = 0; i < span1.length; i++) {
				span1[i].addEventListener("click", function(e) {
					const checkboxes = document.getElementsByName("empno");
					const del = e.target;  // span ("X")
		 			const deleteAll = del.parentNode; // <li><span></span></li>				 			
		 			for (var j = 0; j < checkboxes.length; j++) {
						if(del.getAttribute("value") == checkboxes[j].getAttribute("value1")){
			 					checkboxes[j].checked = false;
						}	
					}

				 	deleteAll.remove();
		 			const li1 = document.getElementsByName("li1");
					num = li1.length;
					mspan.innerText = num;
					});
				}
// 				console.log(arr);
				/*------------------------------------------------------------------------------------------------*/
				
				const li1 = document.getElementsByName("li1");
				num = li1.length;
				mspan.innerText = num;
				
					/*선택 후 div 정리*/
              	 document.getElementById("userKeyWord").value="";
              	 suggestdiv.style.display = "none";
              	 
              	 var checkNum = 0;
              	for (var k = 0; k < num; k++) {
					if(li1[k].innerText == li.innerText){
						checkNum ++;
				}
		 
				}
              	if(checkNum != 1){
              		li.remove();
              		const li1 = document.getElementsByName("li1");
    				num = li1.length;
    				mspan.innerText = num;
              	}
              	
				});
			}
	</script>

</body>
</html>