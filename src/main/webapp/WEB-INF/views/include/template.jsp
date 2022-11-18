<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/main.css">
<title>Insert title here</title>

</head>
<body>
	
	<div class="container-wrap">
		<div class="header">
			<div class="navbar__toogleBtn" id="mobile-btn">☰</div>
			<img src="${pageContext.request.contextPath}/imges/logo.PNG"/>
            <div class="header-logout">로그아웃 버튼</div>
		</div>
		<div class="container">
			<jsp:include page="../include/menu.jsp"></jsp:include>
			<div class="container-inner">
				
				<section class="section1">
					<div class="section1-1">
						<p>이번 달 근무 현황</p>
						
					</div>
					<div class="section1-2">
						<p>이벌 달 근무기록 상세 현황</p>
					</div>
				</section>
				
				<section class="section2">
					<div class="section2-1">
						<p>정렬</p>
					</div>
					<div class="section2-2">
						<p>테이블</p>
					</div>
				</section>
			</div>
		</div>
	</div>
	
	
</body>
</html>