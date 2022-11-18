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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bbs/setstyle.css" />
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

				<form:form modelAttribute="bbsVO" action="${pageContext.request.contextPath}/bbsPage/put" method="post">
					<form:hidden path="id" />
					<form:hidden path="filelist"/>
					
					<div class="set-title">
						<h2>사내 게시판</h2>
					</div>
					<div class="set-subtitle">
						<div>
							<h3>수정하기</h3>
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
									<td>${bbsVO.owner}</td>
								</tr>
								<tr>
									<th>카테고리</th>
									<td>
										<form:select path="category">
											<c:forEach var="vo" items="${categories}">
												<form:option value="${vo.category}">${vo.category}</form:option>
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
									<td><form:textarea path="content" id="textarea" class="ckeditor"/></td>
								</tr>
								<tr>
									<th>파일첨부<span><img src=""></span></th>
									<td>
										<c:forEach var="file" items="${filelist}">
										<div class="file-item">
											<a href="${pageContext.request.contextPath}/bbsPage/downloadFile/${file.localname}/${file.servername}">${file.localname}</a>
											<button data-id="${file.id}" class="deleteFile">
											 <span><img src="${pageContext.request.contextPath}/resources/imges/cancle.png"/></span>
											</button>
										</div>
										</c:forEach>			
										<button class="alldelete" data-bbsId="${bbsVO.id}">전체삭제</button><br>
										<input type="file" id="upload" name="upload" multiple>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="set-footer">
						<button id="cancle">취소</button>
						<button type="button" id="modify">수정하기</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>

<script type="text/javascript">

	//뒤로가기
	document.getElementById("return").addEventListener("click",function(e){
		e.preventDefault();
		let yn = confirm("작성한 내용들은 저장되지 않습니다. 목록으로 이동하시겠습니까?");
		if(yn){
			location.href = "${pageContext.request.contextPath}/bbsPage/bbs";
		}
	});
	//취소하기
	document.getElementById("cancle").addEventListener("click", function(e){
		e.preventDefault();
		let yn = confirm("작성한 내용들은 저장되지 않습니다. 목록으로 이동하시겠습니까?");
		if(yn){
			location.href = "${pageContext.request.contextPath}/bbsPage/bbs";
		}
	});
	
	//이지윅즈 적용
	CKEDITOR.replace('textarea', {
		height : 600
	});
	
	//파일 수정, 삭제
	$(function(){
		let flagSingle = false;
		let flagAll = false;
		let bbsId = 0;
		let id = [];
		
		//파일 전체 삭제
		$(".alldelete").click(function(e){
			e.preventDefault();
			let yn = confirm("파일을 전부 삭제하시겠습니까?");
			if(yn){
				flagAll = true;
				bbsId = this.dataset.bbsId;
				$(".file-item").remove();
			}
		});
		
		//파일 하나씩 삭제
		$(".deleteFile").click(function(e){
			e.preventDefault();
			let yn = confirm("파일을 삭제하시겠습니까?");
			if(yn){
				flagSingle = true;
				id.push({id : this.dataset.id});
				$(this).parent().remove();
			}
		});
		
		//파일 수정
		$("#modify").click(function(){
			let yn = confirm("수정하시겠습니까?");
			// 파일 삭제
			if(flagAll){
				$.ajax({
					url : "${pageContext.request.contextPath}/bbsPage/deleteFileAll",
					data : JSON.stringify({bbsId : bbsId}),
					type : "post",
					contentType:"application/json; charset=utf-8",
					datatype : "json",
					success: function(result){
						console.log(JSON.stringify(result));
					}	
				});	
			}else if(flagSingle){
				$.ajax({
					url : "${pageContext.request.contextPath}/bbsPage/deleteFile",
					data : JSON.stringify(id),
					type : "post",
					contentType:"application/json; charset=utf-8",
					datatype : "json",
					success: function(result){
						console.log(JSON.stringify(result));
					}
				});		
			}
			
			const formData = new FormData();
			const $upload = $("#upload");
			let files = $upload[0].files;
			
			//console.log(files);
			// 파일 추가
			if(files.length != 0){
				for (var i = 0; i < files.length; i++) {
					formData.append("uploadFile", files[i])	
				}
				
				$.ajax({
					url : "${pageContext.request.contextPath}/bbsPage/uploadfile",
					processData : false,
					contentType : false,
					data : formData,
					type : "post",
					datatype : "json",
					success: function(result){
						//console.log(JSON.stringify(result));
						$("#filelist").val(JSON.stringify(result));
						console.log(result);
						//$("#BBSVO").submit();
						$("#bbsVO").submit();
					}
				});
			}else{
				$("#bbsVO").submit();
			}
		});
	});
</script>
</body>
</html>