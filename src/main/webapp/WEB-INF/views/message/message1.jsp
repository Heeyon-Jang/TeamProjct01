<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" --%>
<%-- 	pageEncoding="UTF-8"%> --%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- <head> -->
<!-- <meta charset="UTF-8"> -->
<!-- <link rel="stylesheet" -->
<%-- 	href="${pageContext.request.contextPath}/resources/main.css"> --%>

<!-- <title>Insert title here</title> -->
<!-- <style type="text/css"> -->
/* #table1 { */
/* 	text-align: center; */
/* } */

/* th, td { */
/* 	padding: 7px; */
/* } */

/* tr:nth-child(odd) { */
/* 	background-color: #f8f8f9; */
/* } */

/* th { */
/* 	background-color: #e3edf7; */
/* } */

/* #table1 { */
/* 	width: 100%; */
/* } */

/* a { */
/* 	color: black; */
/* } */

/* /*스크롤 css 주석 */
/* .scroll { */
/* 	padding: -10px; */
/* } */

/* .scroll::-webkit-scrollbar { */
/* 	width: 10px; */
/* } */

/* .scroll::-webkit-scrollbar-thumb { */
/* 	background-color: #f2f4f5; */
/* 	border-radius: 10px; */
/* 	background-clip: padding-box; */
/* 	border: 2px solid transparent; */
/* } */

/* .scroll::-webkit-scrollbar-track { */
/* 	background-color: white; */
/* 	border-radius: 10px; */
/* 	box-shadow: inset 0px 0px 5px white; */
/* }*/ */
/* .intro { */
/* 	display: flex; */
/* 	justify-content: space-between; */
/* 	padding-bottom: 4%; */
/* } */

/* .intro>p { */
/* 	color: #c0c5c9; */
/* } */

/* .intro { */
/* 	display: flex; */
/* 	justify-content: space-between; */
/* 	padding-bottom: 2%; */
/* } */

/* .intro>p { */
/* 	color: #c0c5c9; */
/* } */

/* #note_bt { */
/* 	margin-top: 15px; */
/* } */

/* #note_bt ul li { */
/* 	float: left; */
/* 	margin-left: 100px; */
/* } */

/* #btn1 { */
/* 	padding: 10px 20px 10px 20px; */
/* 	background: #272454; */
/* 	border: 0; */
/* 	color: white; */
/* 	font-size: 12px; */
/* 	border-radius: 5px; */
/* 	margin-left: -670px; */
/* } */

/* #btn1:hover { */
/* 	background: #08298A; */
/* 	color: white; */
/* } */

/* #btn1 { */
/* 	margin-top: 30px; */
/* } */

/* #btn2 { */
/* 	padding: 10px 20px 10px 20px; */
/* 	background: #272454; */
/* 	border: 0; */
/* 	color: white; */
/* 	font-size: 12px; */
/* 	border-radius: 5px; */
/* 	width: 85px; */
/* } */

/* #btn2:hover { */
/* 	background: #08298A; */
/* 	color: white; */
/* } */

/* #btn2 { */
/* 	margin-left: 10px; */
/* } */

/* h1 { */
/* 	font-family: 'Oswald', sans-serif; */
/* 	font-size: 30px; */
/* } */

/* label { */
/* 	display: block; */
/* 	margin-top: 20px; */
/* 	letter-spacing: 2px; */
/* } */

/* form { */
/* 	margin: 0 auto; */
/* 	width: 459px; */
/* } */

/* #mreciever, #mcontent, #mtitle { */
/* 	width: 439px; */
/* 	height: 27px; */
/* 	background-color: #e3edf7; */
/* 	border-radius: 6px; */
/* 	border: 1px solid #dedede; */
/* 	padding: 10px; */
/* 	margin-top: 3px; */
/* 	font-size: 0.9em; */
/* 	color: #3a3a3a; */
/* } */

/* #mreciever:focus, #mcontent:focus, #mtitle:focus { */
/* 	border: 1px solid #97d6eb; */
/* } */

/* textarea { */
/* 	height: 60px; */
/* 	background-color: #efefef; */
/* } */

/* #btn-save { */
/* 	width: 127px; */
/* 	height: 48px; */
/* 	text-align: center; */
/* 	border: none; */
/* 	margin-top: 20px; */
/* 	cursor: pointer; */
/* 	border-radius: 4px; */
/* 	background-color: #e3edf7; */
/* } */

/* #btn-save:hover { */
/* 	color: #fff; */
/* 	background-color: #272454; */
/* 	opacity: 0.9; */
/* } */

/* #cancel { */
/* 	width: 127px; */
/* 	height: 48px; */
/* 	text-align: center; */
/* 	border: none; */
/* 	margin-top: 20px; */
/* 	cursor: pointer; */
/* 	border-radius: 4px; */
/* 	background-color: #e3edf7; */
/* } */

/* #cancel:hover { */
/* 	color: #fff; */
/* 	background-color: #272454; */
/* 	opacity: 0.9; */
/* } */

/* .modal { */
/* 	position: fixed; */
/* 	left: 0; */
/* 	top: 0; */
/* 	width: 100%; */
/* 	height: 100%; */
/* 	background-color: rgba(0, 0, 0, 0.5); */
/* 	opacity: 0; */
/* 	visibility: hidden; */
/* 	transform: scale(1.1); */
/* 	transition: visibility 0s linear 0.25s, opacity 0.25s 0s, transform */
/* 		0.25s; */
/* } */

/* .modal-content { */
/* 	position: absolute; */
/* 	top: 50%; */
/* 	left: 50%; */
/* 	transform: translate(-50%, -50%); */
/* 	background-color: white; */
/* 	padding: 1rem 1.5rem; */
/* 	width: 500px; */
/* 	height: 410px; */
/* 	border-radius: 0.5rem; */
/* } */

/* .close-button { */
/* 	float: right; */
/* 	width: 1.5rem; */
/* 	line-height: 1.5rem; */
/* 	text-align: center; */
/* 	cursor: pointer; */
/* 	border-radius: 0.25rem; */
/* 	background-color: lightgray; */
/* } */

/* .close-button:hover { */
/* 	background-color: darkgray; */
/* } */

/* .show-modal { */
/* 	opacity: 1; */
/* 	visibility: visible; */
/* 	transform: scale(1.0); */
/* 	transition: visibility 0s linear 0s, opacity 0.25s 0s, transform 0.25s; */
/* } */
<!-- </style> -->
<!-- </head> -->
<!-- <body> -->

<!-- 	<div class="container-wrap"> -->
<!-- 		<div class="header"> -->
<!-- 			<div class="navbar__toogleBtn" id="mobile-btn">☰</div> -->
<%-- 			<img src="${pageContext.request.contextPath}/resources/imges/logo.PNG" /> --%>
<!-- 			<div class="header-logout"> -->
<%-- 				<a href="${pageContext.request.contextPath}/logout">로그아웃</a> --%>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="container"> -->
<%-- 			<jsp:include page="../include/menu.jsp"></jsp:include> --%>
<!-- 			<div class="container-inner-bbs"> -->
<!-- 				<div class="inner-div-bbs"> -->
<!-- 					각자 필요한 부분 넣기 -->
<!-- 					<div class="intro"> -->
<!-- 						<h1 class="hh1">받은 쪽지함</h1> -->
<!-- 					</div> -->
<!-- 					스크롤<div class="scroll"
<!-- 						style="overflow: auto; width: 100%; height: 500px;">  --> -->
<!-- 					<table id="table1"> -->

<!-- 						<thead> -->
<!-- 							<tr> -->
<!-- 								<th><input type="checkbox" onclick="checkAll()" -->
<!-- 									name="allCheck" id="allCheck" /></th> -->
<!-- 								<th>NO.</th> -->
<!-- 								<th>보낸사람</th> -->
<!-- 								<th>제목</th> -->
<!-- 								<th>날짜</th> -->
<!-- 								<th>받는사람</th> -->
<!-- 							</tr> -->
<!-- 						</thead> -->
<!-- 						<tbody id="table-body"> -->
<%-- 							<c:forEach var="vo" items="${list}"> --%>
<!-- 								<tr> -->

<!-- 									<td><input type="checkbox" name="RowCheck" id="chkObj" -->
<%-- 										value="${vo.id}"></td> --%>
<%-- 									<td>${vo.id}</td> --%>
<%-- 									<td>${vo.mreciever}</td> --%>
<!-- 									<td><a -->
<%-- 										href="${pageContext.request.contextPath}/message/messageValue/${vo.id}">${vo.mtitle}</a></td> --%>
<%-- 									<td>${vo.createDate}</td> --%>
<%-- 									<td>${vo.mowner}</td> --%>
<!-- 								</tr> -->
<%-- 							</c:forEach> --%>
<!-- 								팝업 될 레이어 -->
<!-- 								<div class="modal"> -->
<!-- 									<div class="modal-content"> -->
<!-- 										<span class="close-button">&times;</span> -->
<!-- 										<h1 class="title">쪽지 보내기</h1> -->

<!-- 										<form -->
<%-- 											action="${pageContext.request.contextPath}/message/insert/${vo.mowner}" --%>
<!-- 											method="POST"> -->
<!-- 											<label for="mreciever">받는이:</label> <input type="text" -->
<!-- 												name="mreciever" placeholder="받는이를 입력하세요." id="mreciever"> -->

<!-- 											<label for="mtitle">제목:</label> <input type="text" -->
<!-- 												name="mtitle" placeholder="제목을 입력하세요." id="mtitle"> -->

<!-- 											<label for="mcontent">내용:</label> -->
<!-- 											<textarea name="mcontent" class="form-control summernote" -->
<!-- 												placeholder="내용을 입력하세요." id="mcontent"></textarea> -->

<!-- 											<input type="button" id="cancel" value="취소"> <input -->
<!-- 												type="submit" id="btn-save" class="btn btn-info" value="보내기"> -->
<!-- 										</form> -->
<!-- 									</div> -->

<!-- 								</div> -->

<!-- 						</tbody> -->
<!-- 					</table> -->

<!-- 					<div class="buttun"> -->
<!-- 						<button class="trigger" id="btn1">쪽지 보내기</button> -->
<!-- 						<input type="button" value="삭제" class="btn btn-outline-info" -->
<!-- 							id="btn2" onclick="chkDel();"> -->
<!-- 					</div> -->

<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- 	<!--</div> 스크롤 --> -->

<!-- 	<script type="text/javascript"> -->
// 	 let index = {
// 			 init:function(){
// 				 $("#btn-save").on("click",()=>{
// 					 this.save();
// 				 });
// 			 },
			 
// 			save:function(){
// 				let data = {
// 						mreciever:$("#mreciever").val(),
// 						mtitle:$("#mtitle").val(),
// 						mcontent:$("#mcontent").val()
// 				};
				
// 				$.ajax({
// 					url : '${pageContext.request.contextPath}/message/insert',
// 					type : 'POST',
// 					contentType: 'application/json; charset=utf-8',
// 					data : JSON.stringify(data),
// 			}).done(function(resp){
// 				alert("쪽지 보내기가 완료되었습니다.");
// 				location.replace("message")
// 			}).fail(function(error){
// 				alert(JSON.stringify(error));
// 			});
				
// 			},
// 	 }
<!-- 	</script> -->

<!-- 	<script> -->
// 		function checkAll() {
// 			var is_checked = document.getElementById("allCheck").checked;
// 			var RowCheck = document.getElementsByName("RowCheck");
// 			var rowCnt = RowCheck.length;
// 			if (is_checked == true) {
// 				for (var i = 0; i <= rowCnt; i++) {
// 					document.getElementsByName("RowCheck")[i].checked = true;
// 				}
// 			} else {
// 				for (var i = 0; i <= rowCnt; i++) {
// 					document.getElementsByName("RowCheck")[i].checked = false;
// 				}
// 			}
// 		}

// 		function chkDel() {
// 			var url = "";
// 			var valueArr = new Array();
// 			var list = $("input[name='RowCheck']");
// 			for (var i = 0; i < list.length; i++) {
// 				if (list[i].checked) {
// 					valueArr.push(list[i].value);
// 					console.log(valueArr);
// 				}
// 			}
// 			if (valueArr.length == 0) {
// 				alert("삭제할 쪽지가 없습니다.");
// 			} else {
// 				var chk = confirm("정말 삭제하시겠습니까?");
// 				$.ajax({
// 					url : '${pageContext.request.contextPath}/message/delete',
// 					type : 'POST',
// 					contentType: 'application/json; charset=utf-8',
// 					data : JSON.stringify(valueArr),
// 					success : function(jdata) {
// 						if (jdata = 1) {
// 							alert("삭제가 완료되었습니다.");
// 							location.replace("message")
// 						} else {
// 							alert("삭제 실패");
// 						}
// 					},
// 					error : function(err){
// 						console.log('실패');
// 					}
// 				});
// 			}
// 		}
<!-- 	</script> -->

<!-- 	<script type="text/javascript">  -->
//          var modal = document.querySelector(".modal"); 
//          var trigger = document.querySelector(".trigger"); 
//          var closeButton = document.querySelector(".close-button"); 
//          var cancelButton = document.querySelector("#cancel");

//         //console.log(modal);

//         function toggleModal() { 
//              modal.classList.toggle("show-modal"); 
//          }

//         function windowOnClick(event) { 
//              if (event.target === modal) { 
//                  toggleModal(); 
//              } 
//          }

//         trigger.addEventListener("click", toggleModal); 
//          closeButton.addEventListener("click", toggleModal); 
//          cancel.addEventListener("click", toggleModal); 
//          window.addEventListener("click", windowOnClick); 
         
//          //var anText_sub1 = document.getElementById('category').value;
//          //var anText_sub2 = document.getElementById('title').value;
//          //var anText_sub3 = document.getElementById('content').value;
<!--      </script> -->

<!-- 	<script src="https://code.jquery.com/jquery-3.5.1.js"></script> -->
<!-- </body> -->
<!-- </html> -->