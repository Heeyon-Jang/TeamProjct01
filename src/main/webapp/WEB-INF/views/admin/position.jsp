<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/admin/admin1.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/admin/department.css">	
<title>Insert title here</title>
<style type="text/css">
	.modal_wrap{
		max-height: 260px;
		min-height: 260px;
	}
</style>
</head>
<body>

	<div class="container-wrap">
		<div class="header">
			<div class="navbar__toogleBtn" id="mobile-btn">☰</div>
			<img src="${pageContext.request.contextPath}/resources/imges/logo.PNG"/>
            <div class="header-logout">로그아웃 버튼</div>
		</div>
		<div class="container">
			<jsp:include page="../include/menu.jsp"></jsp:include>
			<div class="container-inner-bbs">
				<div class="inner-div-bbs">
					<div class="intro">
						<h2>직책 관리</h2>
						<p></p>
					</div>
					<div class="tbtn1">
						<button type="button" id="insertBtn">직책 등록</button>
					</div>
					<div class="table" style="width: 100%;">
						<table id="table1" class="table1">
							<tr class="table1Tr">
								<th>No.</th>
								<th style="width: 50%;">직책명(필수)</th>
								<th>사원수</th>
								<th colspan="2" style="width: 10%;"></th>
								<th></th>
							</tr>
							<c:forEach var="i" items="${listP}" varStatus="status">
								<tr>
									<td>${status.count}</td>
									<td><input type="text" class="inputText" name="position" id="position${i.id}" value="${i.position}"/></td>
										<c:forEach var="c" items="${count}">
											<c:if test="${i.position eq c.position}">
												<td>${c.count}</td>
											</c:if>
										</c:forEach>
									<td>
										<div class="abtn">
											<a href="#" id="update${i.id}">수정</a>
											<a href="#" id="del${i.id}">삭제</a>
										</div>
									</td>
								</tr>
								
								<form
									action="${pageContext.request.contextPath}/admin/insertPosition" method="get">
									<div class="modal_dim" id="modal_dim">
										<div class="modal_wrap">
											<div class="modal">
												<div class="mdiv1">
													<h4>직책 등록</h4>
													<h5 id="exit">X</h5>
												</div>
												<div class= "mcontents">
													<p>[<span class="requirement">*</span>]항목은 필수 입력 정보입니다.</p>
													<h4><span class="requirement">*</span>직책명</h4>
													<input type="text" name="position" id="position" required/>
												</div>
												<div class="bdiv">
													<button class="mbutton" id="mbutton">등록하기</button>
												</div>
											</div>
										</div>
									</div>
								</form>
								
								<script type="text/javascript">
									/*update*/
									document.getElementById("update"+${i.id}).addEventListener("click", function(){
										let value = document.getElementById("position"+${i.id}).value;
										let isUpdate = confirm(" 직책을 "+value+"로 바꾸시겠습니까?");
										if(isUpdate){
											alert("성공적으로 바뀌었습니다.");				
											location.href = "${pageContext.request.contextPath}/admin/updatePosition/"+${i.id}+"?position="+value;
										}
									});
									/*delete*/
									document.getElementById("del"+${i.id}).addEventListener("click", function(){
										let isDelete = confirm("해당 직책을 지우시겠습니까?");
										if(isDelete){
											alert("해당 직책이 성공적으로 지워졌습니다.");				
											location.href = "${pageContext.request.contextPath}/admin/deletePosition?id="+${i.id};
										}
									});
									/*insert(modal)*/
									document.getElementById("insertBtn").addEventListener("click", function(){
										document.getElementById("modal_dim").style.display = "flex";
									});
									document.getElementById("exit").addEventListener("click", function() {
										document.getElementById("modal_dim").style.display = "none";
									});
								</script>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
</body>
</html>