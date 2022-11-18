<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/main.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/admin/admin2.css">
<title>Insert title here</title>
<style type="text/css">
	.btnzip{
		display: flex;
		flex-direction: row;
		width: 100%;
	}
	.zip {
	    display: flex;
	    justify-content: flex-end;
	}
	.zipimg{
		
	}
/* 	table { */
/* 		table-layout: fixed; */
/* 	} */
	#total_holiday, #telNumber {
 		width: 80%; 
	}
	.label {
		user-select: none;
	}
	.blockInput {
		user-select: none;
		color: rgb(170, 170, 170);
		cursor: default;
 		width: 85%; 
	}
	.blockInput:focus {
		outline: none;
	}
	.inner-div-bbs {
		display: none;
	}
	.passCheck-wrap {
		width: 100%;
		height: 80%;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	}
	.passCheck {
	    width: 30%;
	    min-width: 250px;
	    height: 10%;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    border-radius: 10px;
	    background-color: #ffffff;
	    border: 1px solid black;
	}
	.passCheck > label {
		display: inline-block;
		width: 80px;
		padding-left: 10px;
	}
	.pCheck {
		background-color : none;
	}
	input:not(input[type="radio"]) {
		min-width: 100px;
	}
</style>
</head>
<body>
	<c:forEach var ="info" items="${info}">
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
					<!-- 각자 필요한 부분 넣기 -->
					<div class="scroll">
						<div class="intro">
							<h3>${info.name}님의 직원 정보</h3>
							<br />
							<p></p>
						</div>
						<form action="${pageContext.request.contextPath}/profile/updateData"
							class="form1" method="post" enctype="multipart/form-data">
							<input name="page" value="1" style="display: none;" />
							<div class="personal-wrap">
								<div class="prodiv">
										<c:forEach var="img" items="${fileList}">
												<c:if test="${not empty img.fileName}">
													<img id="showimg"
														src="${pageContext.request.contextPath}/upload/${img.fileName}">
												</c:if>
										</c:forEach>
										<label for="proimg" id="img">사진수정</label>
										<input type="file" name="proimg" id="proimg" accept="image/*">
								</div>
								<div id="personal">
									<table>
										<tr>
											<td class="label">이름</td>
											<td>
												<input type="text" name="name" id="name" class="blockInput" value="${info.name}" required readonly>
											</td>
											<td class="label">성별</td>
											<td>
												<input type="radio" name="gender" id="genderm" value="M"> 남자 
												<input type="radio" name="gender" id="genderf" value="F"> 여자
											</td>
										</tr>
										<tr>
											<td class="label">생년월일</td>
											<td colspan='3'>
												<input type="date" name=birthday id="birthday" class="blockInput" value="${info.birthday}" required readonly>
											</td>
										</tr>
										<tr>
											<td class="label">이메일</td>
											<td colspan='3'>
												<input type="text" name="email_id" id="email_id" value="${email_id}" required> @ 
												<input type="text" name="email_domain" id="email_domain" value="${email_domain}" required />
												<select class="select" id="email_select">
													<option value=" ">직접입력</option>
													<option value="naver.com">naver.com</option>
													<option value="gmail.com">gmail.com</option>
													<option value="hanmail.net">hanmail.net</option>
													<option value="hotmail.com">hotmail.com</option>
													<option value="korea.com">korea.com</option>
													<option value="nate.com">nate.com</option>
													<option value="yahoo.com">yahoo.com</option>
												</select>
											</td>
										</tr>
										<tr>
											<td id="noB" class="label">사원번호</td>
											<td id="noB">
												<input type="text" name="empno" id="empno" class="blockInput" value="${info.empno}" required readonly>
											</td>
											<td id="noB" class="label">비밀번호<span class="redspan">*</span></td>
											<td id="noB">
												<input type="password" name="password" id="password" value="${info.password}">
											</td>
										</tr>
									</table>
								</div>
							</div>

							<div id="employee" style="width: 100%;">
								<table>
									<tr>
										<td class="label">부서</td>
										<td>
											<select class="edepartment" id="edepartment" name="edepartment" disabled>
												<option value="${eVO.edepartment }">${eVO.edepartment }</option>
											</select>
										</td>
										<td class="label">직책</td>
										<td>
											<select name="eposition" id="eposition" required disabled>
												<option value="${eVO.eposition }">${eVO.eposition }</option>
											</select>
										</td>
										<td class="label">재직 상태</td>
										<td>
											<select name="estatus" id="estatus" required disabled>
												<option value="${eVO.estatus }">${eVO.estatus }</option>
											</select>
										</td>
									</tr>
									<tr>
										<td class="label">고용 형태</td>
										<td>
											<select name="ehiredType" id="ehiredType" required disabled>
												<option value="${eVO.ehiredType }">${eVO.ehiredType }</option>
											</select>
										</td>
										<td class="label">총 연차 수</td>
										<td>
											<input type="text" name="totalH" id="total_holiday" class="blockInput" value="${info.totalHoliday}" required readonly>
										</td>
										<td class="label">관리자 여부</td>
										<td>
											<input type="checkbox" name="checkAdmin" id="check_admin" value="1" disabled>
											<input type="checkbox" name="checkAdmin" id="check_admin2" value="2" style="display: none;" disabled>
										</td>
									</tr>
									<tr>
										<td class="label">입사일</td>
										<td colspan='5'>
											<input type="date" name="ehiredDate" id="ehiredDate" class="blockInput" value="${info.ehiredDate}" required readonly>
										</td>
									</tr>
									<tr>
										<td class="label">전화번호</td>
										<td colspan='1'>
											<input type="number" name="telNumber" id="telNumber" placeholder="번호만 입력해 주세요" value="${info.telNumber}" 
													oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
										</td>
										<td class="label">핸드폰<span class="redspan">*</span></td>
										<td colspan='3'>
											<input type="number" name="phoneNumber" id="phoneNumber" required placeholder="번호만 입력해 주세요" value="${info.phoneNumber}" 
													oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
										</td>
									</tr>
									<tr>
										<td id="noB" class="label">주소<span class="redspan">*</span></td>
										<td colspan='5'>
											<div style="display: flex; flex-direction: row;" >
												<input type="text" id="addre" name="addre" value="${info.address}" style="width: 100%"/>
												<div style="display: none;" id="addresszip" style="display: flex; flex-direction: row;">
													<input type="text" name="postcode" id="postcode" placeholder="우편번호">
													<input type="text" name="address" id="address" placeholder="주소"> 
													<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소"> 
													<input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목">
												</div>
													<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"/><br> 
											</div>
											<div id="wrap"
												style="display: none; border: 1px solid; width: 500px; height: 300px; margin: 5px 0; position: relative">
												<img
													src="//t1.daumcdn.net/postcode/resource/images/close.png"
													id="btnFoldWrap"
													style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1"
													onclick="foldDaumPostcode()" alt="접기 버튼">
											</div>
										</td>
									</tr>
								</table>
							</div>
				<!-- 주소 찾기  ------------------------------------------------------------------------------------------------------>
							<script
								src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js">
							</script>
							
							<script>
								document.getElementById('address').value="${info.address}";
								
								document.getElementById('addre').addEventListener("change",function(){
									document.getElementById('address').value = document.getElementById('addre').value;            
					            });
							
								document.getElementById('address').value="${info.address}";
								
								document.getElementById('addre').addEventListener("change",function(){
									document.getElementById('address').value=document.getElementById('addre').value;            
					            });
							
								var element_wrap = document.getElementById('wrap');
								
								function foldDaumPostcode() {
									element_wrap.style.display = 'none';
								}
								function execDaumPostcode() {
									// var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);

									var addresszip = document.getElementById('addresszip');
									var addre = document.getElementById('addre'); 
									
									document.getElementById('address').value="";
									addresszip.style.display = 'flex';
									addre.style.display = 'none';
								    
								    new daum.Postcode({
										oncomplete: function(data) {
											var addr = ''; 
											var extraAddr = ''; 
											
											if (data.userSelectedType === 'R') { 
												addr = data.roadAddress;
											}
											else { 
												addr = data.jibunAddress;
											}
											
											if(data.userSelectedType === 'R') {
												if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
													extraAddr += data.bname;
												}
												if(data.buildingName !== '' && data.apartment === 'Y') {
													extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
												}
												if(extraAddr !== '') {
													extraAddr = ' (' + extraAddr + ')';
												}
												document.getElementById("extraAddress").value = extraAddr;
											
											}
											else {
												document.getElementById("extraAddress").value = '';
											}
												
											document.getElementById('postcode').value = data.zonecode;
											document.getElementById("address").value = addr;
											document.getElementById("detailAddress").focus();
											
											element_wrap.style.display = 'none';
											
											document.body.scrollTop = currentScroll;
										},
										
										onresize : function(size) {
											element_wrap.style.height = size.height+'px';
										},
										
										width : '100%',
										height : '100%'
										}).embed(element_wrap);
										
										element_wrap.style.display = 'block';
								}
        					</script>
				<!-- 이메일 박스 -------------------------------------------------------------------------------------------------------->
							<script>
								document.getElementById("email_select").addEventListener("change",function(){
									const email_select = document.getElementById("email_select").value;
									const email = document.getElementById("email_domain");
									if(email_select != " ") {
										email.readonly  = true;   
										email.value = email_select; 
									}else {
										email.value = null; 
										email.readonly  = false;   
									}
								});
							</script>
	
							<br>
							<div class="btnzip"> 
								<div class="zip" style="width: 60%">
									<button type="button" class="insertbtn">수정하기</button>
									<button type="submit" class="realbtn" style="display: none">수정하기</button>
								</div>
								<div class="zip" style="width: 40%">
									<a style="font-size: 1.2rem;" href="${pageContext.request.contextPath}/admin?page=1">↩</a>
								</div>
							</div>
						</form>
						
	<script>
        
        /*프로필 사진 변경*/
        const InputFile = document.getElementById("proimg");
        document.getElementById("proimg").addEventListener("change", function(){
            const fileReader = new FileReader();
            const selectedFile = [...InputFile.files];
            fileReader.readAsDataURL(selectedFile[0]);

            fileReader.onload = function(){
                document.getElementById("showimg").src = fileReader.result;
            }
        });
		
		/*라디오버튼 선택*/
		const m = document.getElementById("genderm");
       	const f = document.getElementById("genderf");
       	
       	if(${info.gender eq "M"}){
       		m.checked = true;
       	}
       	if(${info.gender eq "F"}) {
       		f.checked = true;
       	}
       	
       	/*관리자 여부*/
		const check = document.getElementById("check_admin");
		
       	if(${info.checkAdmin eq "1"}){
       		check.checked = true;
       	}
       	
       	/*수정 버튼*/
		const insertbtn = document.querySelector(".insertbtn");
       	const realbtn = document.querySelector(".realbtn");
       	
       	let upCheck = false;
       	insertbtn.addEventListener("click", function(){
       		upCheck = confirm("정말로 수정하시겠습니까?");
       		
       		if(upCheck) {
       			sessionStorage.setItem("upCheck", upCheck);
       			realbtn.click();
       		}
       	});
       	
    </script>

<!-- -------------------------------------------------------------------------------- -->
					</div>
				</div>
				
				<div class="passCheck-wrap">
					<div class="passCheck">
						<label for="pCheck">비밀번호 : </label>
						<input type="password" name="pCheck" id="pCheck" placeholder="비밀번호를 입력해주세요"/>
					</div>
				</div>
				
			</div>
		</div>
	</div>

</c:forEach>
	
	<script type="text/javascript">
		const inputEnter = document.getElementById("pCheck");
		const passCheckWrap = document.querySelector(".passCheck-wrap");
		const innerDivBbs = document.querySelector(".inner-div-bbs");
		
// 		비밀번호 입력 후 엔터 키 다운시
		inputEnter.onkeydown = function(event) {
			if (event.keyCode == 13) {
				let pass = document.getElementById("pCheck").value;
				let emp = sessionStorage.getItem("empno");
				
				let passData = {
						empno: emp,
						password: pass
				};
				
				fetch("${pageContext.request.contextPath}/profile/passCheck",{
					method : "POST", // PUT, PATCH, DELETE
					headers : {"Content-Type" : "application/json"},
					body : JSON.stringify(passData)
				}).then(response => response.json())
				.then(data => {
// 					console.log("성공");
					let list = data;
					
					if(list == 1) {
						passCheckWrap.style.display = "none";
						innerDivBbs.style.display = "flex";
					}
					else {
						alert("비밀번호가 틀렸습니다.");
					}
				}).catch(error => {
					console.log("error");
				});
			}
		}
		
		upCheck = sessionStorage.getItem("upCheck");
		
		if(upCheck != null) {
			alert("성공적으로 변경되었습니다.");
			window.location.reload();
			sessionStorage.removeItem("upCheck");
		}
// 		sessionStorage.removeItem("upCheck");
// 		console.log(sessionStorage.getItem("upCheck"));
// 		const passCheck = window.getComputedStyle(passCheckWrap);
// // 		내 정보 접속시 비밀번호 입력화면에서 새로고침 금지
// 		if(passCheck.display == "flex") {
// 			window.addEventListener('keydown', function (e) {
// 				// F5 keyCode
// 				if (e.keyCode === 116) {
// 					e.preventDefault();
// 				}
// 			});
// 		}
	</script>
	
</body>
</html>