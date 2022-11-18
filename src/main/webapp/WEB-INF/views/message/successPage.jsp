<%@page import="com.awoo.vo.MessageVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/message/successPageStyle.css">

<title>Insert title here</title>
<style>

</style>
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
				<div class="inner-div-bbs">
					<h3 class="sub-title">보내기 성공</h3> 
						<div class="wrap">
					      <div class="container1">
					        <div class="heading">
					          <span class="big-message"></span>
					        </div>
					         <p class="content send-message">이메일이 성공적으로 전송되었습니다.</p>
					        <div class="img-container">
					          <img src="${pageContext.request.contextPath}/resources/imges/mailsuccess.png"/>
					        </div>
					        <div class="content-div">
					            <p class="content button"><a href="${pageContext.request.contextPath}/SendEmail?page=1&&name=0&&year=0&&month=0">뒤로가기</a></p>
					        </div>
					      </div>
					    </div>
					</div>
				</div>
			</div>
		</div>
	<script>
	
	</script>
</body>
</html>