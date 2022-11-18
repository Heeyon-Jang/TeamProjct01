<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/login/style.css">
<title>Insert title here</title>
<style type="text/css">
	
</style>
</head>
<body>
	<div class="wrapper fadeInDown">
		<div class="container">
		<img src="${pageContext.request.contextPath}/resources/imges/logo-white.png" class="login-logo"/>
			<div id="formContent">
				<h2 class="active">LOGIN</h2>
				<form:form modelAttribute="personalInfoVO" action="${pageContext.request.contextPath}/login" method="post" name="loginForm">
					<p>아이디</p>
					<form:input path="empno" placeholder="아이디를 입력하세요" id="empno" value="220204" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
					<p>패스워드</p>
					<form:password path="password" placeholder="패스워드를 입력하세요" id="pw" value="abc6"/>
					<button id="loginValidation">Log in</button>
				</form:form>
			</div>
			<div class="emptydiv"></div>
		</div>
		
	</div>
</body>

<script type="text/javascript">
	document.getElementById("loginValidation").addEventListener("click", function(e){
	    let empno = document.querySelector('#empno').value;
	    let pw = document.querySelector('#pw').value;
	    
	    if(empno == "" || empno == 0){
			e.preventDefault();
			alert("아이디를 입력하세요.");
			loginForm.empno.focus();
			return false;
		}else if(pw == "" || pw == 0){
			e.preventDefault();
			loginForm.pw.focus();
			alert("비밀번호를 입력하세요");
			return false;
		}else{
			$("#loginValidation").submit();
		}
	 });
</script>
</html>