<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/main.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bbs/setstyle.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<!-- ckeditor 적용 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>	
</head>
<body>
	<div class="header">
		<img src="${pageContext.request.contextPath}/resources/imges/logo.PNG" />
		<div class="header-logout">
			<a href="${pageContext.request.contextPath}/logout">로그아웃</a>
		</div>
	</div>
	<div class="container">
		<jsp:include page="../include/menu.jsp"></jsp:include>
		<div class="container-inner-bbs">
			<div class="inner-div-bbs">

				<form:form modelAttribute="BBSVO" action="${pageContext.request.contextPath}/bbsNotice/set" method="post" enctype="multipart/form-data" name="form">
					<form:hidden path="ownerId" value="${sessionScope.personalInfoVO.empno}" />
					<form:hidden path="owner" value="${sessionScope.personalInfoVO.name}" />
					<form:hidden path="filelist" />

					<div class="set-header">
						<h2>공지사항</h2>
					</div>

					<div class="set-subtitle">
						<div>
							<h3>글쓰기</h3>
						</div>
						<div>
							<button id="return">목록</button>
						</div>
					</div>

					<div class="set-main">
						<table>
							<tbody>
								<tr>
									<th>작성자</th>
									<td>${sessionScope.personalInfoVO.name}</td>
								</tr>
								<tr>
									<th>카테고리</th>
									<td><form:select path="category">
											<c:forEach var="vo" items="${categories}">
												<form:option value="${vo.category}" class="category">${vo.category}</form:option>
											</c:forEach>
										</form:select></td>
								</tr>
								<tr>
									<th>제목</th>
									<td>
										<div class="set-title">
											<form:input path="title" />
										</div>
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td><form:textarea path="content" id="textarea" /></td>
								</tr>
								<tr>
									<th>파일첨부</th>
									<td><input type="file" name="upload" id="upload" multiple /></td>
								</tr>
							</tbody>
						</table>
					</div>
				</form:form>
				<div class="set-footer">
					<button id="cancle">취소</button>
					<button id="submit">전송</button>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	//뒤로가기
	document.getElementById("return").addEventListener("click",function(e){
		e.preventDefault();
		let yn = confirm("작성한 내용들은 저장되지 않습니다. 목록으로 이동하시겠습니까?");
		if(yn){
			location.href = "${pageContext.request.contextPath}/bbsNotice/bbs";
		}
	});
	//취소
	document.getElementById("cancle").addEventListener("click",function(e){
		e.preventDefault();
		let yn = confirm("작성한 내용들은 저장되지 않습니다. 목록으로 이동하시겠습니까?");
		if(yn){
			location.href = "${pageContext.request.contextPath}/bbsNotice/bbs";
		}
	});
	
	//취소하기
	document.getElementById("cancle").addEventListener("click", function(e){
		e.preventDefault();
		let yn = confirm("작성한 내용들은 저장되지 않습니다. 목록으로 이동하시겠습니까?");
		if(yn){
			location.href = "${pageContext.request.contextPath}/bbsNotice/bbs";
		}
	});
	
	//이지윅즈 적용
	CKEDITOR.replace("textarea", {
		height : 400,
		filebrowserUploadUrl: "${pageContext.request.contextPath}/bbsNotice/uploadimage"
	});
	
	//submit(유효성 검사+파일 보내기)
	document.getElementById("submit").addEventListener("click", function(e){
		e.preventDefault();
		if(form.title.value=="" || form.title.value==0 || CKEDITOR.instances.textarea.getData() ==""){
			if(form.title.value=="" || form.title.value==0){
				alert("제목을 입력해주세요.");
				form.title.focus();
			}else if(CKEDITOR.instances.textarea.getData() =="" || CKEDITOR.instances.textarea.getData().length ==0){
				alert("내용을 입력해주세요.");
			}
			return false;
		}else{
			let yn = confirm("작성한 내용을 저장하시겠습니까?");
			if(yn){
				const formData = new FormData();
				const $upload = $("#upload");
				let files = $upload[0].files;
				
				for (var i = 0; i < files.length; i++) {
					formData.append("uploadFile", files[i])	
			}
			$.ajax({
				url : "${pageContext.request.contextPath}/bbsNotice/uploadfile",
				processData : false,
				contentType : false,
				data : formData,
				type : "post",
				datatype : "json",
				success: function(result){
					console.log(JSON.stringify(result));
					$("#filelist").val(JSON.stringify(result));
					$("#BBSVO").submit();
				}
			});
			}
			alert("저장되었습니다.");
		};
	});
	</script>
</body>
</html>