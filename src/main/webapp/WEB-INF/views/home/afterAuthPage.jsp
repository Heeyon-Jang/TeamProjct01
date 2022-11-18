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
	.container{
	animation:none;
	}
	.modal-header{
	display: flex;
    justify-content: space-between;
    padding: 0 30px;
	}
	
	.active{
	text-align: start;
    font-size: 20px;
	
	}
	.header{
	display: flex;
    justify-content: space-between;
    width: 100%;
    align-items: center;
	}
	.info{
	display: flex;
    flex-direction: column;
    align-items: start;
	}
	from{
    height: 65%;
	}
	form label{
	width: 85%;
    text-align: start;
	}
</style>
</head>
<body>
	<div class="wrapper fadeInDown" >
		<div class="container" style="display:flex">
		<img src="${pageContext.request.contextPath}/resources/imges/logo-white.png" class="login-logo"/>
			<div id="formContent">
				<div class="modal-header">
					<div class="header">
						<p class="active"><b>초기 비밀번호 변경</b></p>
						<div class="info">
							<p><b>사원번호 :</b> ${userInfo.empno}</p>
							<p><b>이름 :</b> ${userInfo.name}</p>
						</div>
					</div>
					<div>
						<h5 class="close-button"></h5>
					</div>
				</div>
				<form action="${pageContext.request.contextPath}/resetPassword" method="post" id="modal-form" name="modal-form">
					<label for="text">현재 비밀번호:</label><input type="text" name="nowPW" id="nowPW" value="${userInfo.password}" readonly><br />
					<label for="text">새 비밀번호:</label><input type="password" name="newPW" id="newPW" placeholder="영문자+숫자+특수문자 조합 8~25자리"><br />
					<button id="submit">비밀번호 바꾸기</button>
				</form>
			</div>
		</div>
		
	</div>

</body>

<!-- 신규 사원 비밀번호 변경 유도 -->
<script type="text/javascript">

 
 window.addEventListener("DOMContentLoaded",function(){
	alert("인증되었습니다");
});

 
 //비밀번호 변경 조건
 document.querySelector("#submit").addEventListener("click", function(e){
    let newPW = document.querySelector('#newPW');
    //비밀번호 영문자+숫자+특수조합(8~25자리 입력) 정규식
    let pwCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
    
	if(newPW.value =="" || newPW.value == 0){
		e.preventDefault();
		alert("새 비밀번호를 입력해주세요.(영문자+숫자+특수문자 조합으로 8~25자리)");
		newPW.focus();
		return false;
	}else if(!pwCheck.test(newPW.value)){
		e.preventDefault();
		alert("비밀번호는 영문자+숫자+특수문자 조합으로 8~25자리 사용해야 합니다.");
		newPW.focus();
		return false;
	}else{
		alert("비밀번호가 성공적으로 변경되었습니다.");
		$("#submit").submit();
	}

 });
 

    
  </script>
</html>