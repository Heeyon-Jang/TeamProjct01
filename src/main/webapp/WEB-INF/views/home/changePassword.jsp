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
	.container, .modal{
	animation:none;
	}
	.modal-header{
	display: flex;
    justify-content: space-between;
    padding: 0 30px;
	}
	.modal-header .info{
	text-align: start;
    margin-top: 10px;
    display: flex;
    flex-direction: column;
    font-size: 0.9em;
	}
	.modal #formContent{
	opacity:1;
	height:40vh;
	}
	.modal form{
	    height: 55%;
	}
	.modal input{
	    height: 50px;
	}
	.modal label{
	width: 85%;
    text-align: start;
	}
	.active{
	text-align: start;
	}
</style>
</head>
<body>
	<div class="wrapper fadeInDown" >	
		<div class="modal" style="display:flex;">
	<!-- 	<div class="modal" style="display:none;"> -->
			<div id="formContent">
				<div class="modal-header">
					<div>
						<h3 class="active">이메일 인증</h3>
	<!-- 					<p>초기비밀번호를 변경하여주세요</p> -->
					</div>
					<div>
						<h5 class="close-button"></h5>
					</div>
				</div>
				<form action="${pageContext.request.contextPath}/EmailAuth" method="post" id="modal-form" name="modal-form">
					<label for="text">받는 이메일 :</label><input type="email" name="userMail" id="userMail" value="${userInfo.email}" readonly><br />
					<button id="mail-auth">인증번호 받기</button>
					<p style="font-size:2px">※본인 이메일이 아닐 경우 관리자에 연락부탁드립니다</p>
				</form>
			</div>
		</div>
		
		<div class="modal mail-auth" style="display:none;" id="mail-auth-madal">
	<!-- 	<div class="modal" style="display:none;"> -->
			<div id="formContent">
				<div class="modal-header">
					<div>
						<h3 class="active">인증번호를 전송하였습니다</h3>
					</div>
					<div>
						<h5 class="close-button"></h5>
					</div>
				</div>
				<form action="${pageContext.request.contextPath}/EmailAuth/EmailKey" method="post" id="modal-form" name="modal-form">
					<label for="text">인증번호 4자리:</label><input type="text" name="mailAuth" id="mailAuth" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"><br />
					<button id="submit-mail-auth">확인</button>
				</form>
			</div>
		</div>
	</div>
</body>

<!-- 신규 사원 비밀번호 변경 유도 -->
<script type="text/javascript"> 
 // 비동기로 메일 인증 번호 받아옴
	 
	document.getElementById("mail-auth").addEventListener("click",function(e){
		e.preventDefault();
		document.getElementById("mail-auth-madal").style.display="flex";
		let usermail = document.getElementById("userMail").value
		let empno1 = ${sessionScope.personalInfoVO.empno};
		let simple_data = {empno:empno1, mail:usermail};
		
		fetch("${pageContext.request.contextPath}/EmailAuth",{
			method : "POST", // PUT, PATCH, DELETE
			headers : {"Content-Type" : "application/json"},
			body : JSON.stringify(simple_data)
		}).then(response => response.json())
	
		.then(data => {
			console.log("")
		}).catch(error => {
			console.log("error");
		});
	});
    
    
  </script>
</html>