<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/exception/style.css" />
<title>Insert title here</title>
<script>
    const backFunc = function (){
        history.back();
    }
</script>
</head>
<body>
	<div class="error-wrapper">
		<img src="${pageContext.request.contextPath}/resources/imges/404error.jpg">
        <button onclick="backFunc()" id="errorBtn">뒤로 가기</button>
	</div>
</body>
</html>