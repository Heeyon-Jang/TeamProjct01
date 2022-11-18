<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 스타일 적용 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bbs/contentstyle.css" />
<title>Insert title here</title>
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
                <div class="content-title">
                    <h3>공지사항</h3>
                </div>

                <div class="content-nav">
                        <button id="return">목록</button>
                    <div class="adminbtn">
                        <c:if test="${personalInfoVO.empno == 220102}">
                            <button id="modify">수정</button>
                            <button id="delete">삭제</button>
                        </c:if>
                    </div>
                </div>

                <div class="content-head">
                    <h3><span>[${bbsVO.category}]</span> &nbsp; ${bbsVO.title}</h3>
                    <div class="head-inner">
                        <div class="first-inner">
                            <p>작성자 ${bbsVO.owner}</p>
                        </div>
                        <div>
                            <p>작성일 ${bbsVO.createDate}</p>
                        </div>
                    </div>
                </div>

                <div class="content-text">
                    <p>${bbsVO.content}</p>
                </div>

                <div class="content-footer">
                    <h4>첨부파일<span><img src="https://uinnout.com/employee/images/clip.svg"></span></h4>
						<div>
							<h4>${countFiles} 개</h4>
						</div>
						<div>
							<c:forEach var="file" items="${filelist}">
								<a href="${pageContext.request.contextPath}/bbsNotice/downloadFile/${file.localname}/${file.servername}">${file.localname}</a><br>
							</c:forEach>							
						</div>
                </div>
              
               </div>
           </div>
       </div>
	
<script type="text/javascript">
	//뒤로가기 버튼 이벤트------------------------------
	document.getElementById("return").addEventListener("click", function() {
		location.href = "${pageContext.request.contextPath}/bbsNotice/bbs";
	});
	//수정하기 버튼 이벤트-------------------------------
	document.getElementById("modify").addEventListener("click", function() {
		location.href = "${pageContext.request.contextPath}/bbsNotice/put/${bbsVO.id}";
	});
	//삭제하기 버튼 이벤트-------------------------------
	document.getElementById("delete").addEventListener("click", function() {
		if(confirm('정말로 삭제하시겠습니까?')){
		location.href = "${pageContext.request.contextPath}/bbsNotice/delete/${bbsVO.id}";
		}
	});
</script>

</body>
</html>