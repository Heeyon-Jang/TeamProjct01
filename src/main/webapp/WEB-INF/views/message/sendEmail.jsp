<%@page import="com.awoo.vo.MailVO"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/holiday/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/message/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/message/sendEmailStyle.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>

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
					<h3 class="sub-title">메일 보내기</h3> 
					<div class="table-head">
						
						<button type="button" id="writeMessage">메일 작성</button>
						
						<div class="sortings">
							<select name="sorting-year" id="sorting-name" onchange="OnChange();">
								<option value="0">보낸사람 전체</option>
								<c:forEach items="${distinctSender}" var="sender">
									<option value="${sender}" <c:if test ="${sender eq param.name}">selected="selected"</c:if>>${sender}</option>
								</c:forEach>
							</select>
							<span>님</span>
							<select name="sorting-year" id="sorting-year" onchange="OnChange();">
								<option value="0">전체 연도</option>
								<c:forEach items="${distinctYear}" var="year">
									<option value="${year}" <c:if test ="${year eq param.year}">selected="selected"</c:if>>${year}</option>
								</c:forEach>
							</select>
							<span>년</span>
							<select name="sorting-month" id="sorting-month" onchange="OnChange();">
								<option value="0">전체 월</option>
								<c:forEach begin="1" end="12" var="month">
									<option value="${month}" <c:if test ="${month eq param.month}">selected="selected"</c:if>>${month}</option>
								</c:forEach>
							</select>
							<span>월</span>
						</div>
					</div>
					 
					<div class="div2">
						<table border="1" class="holiday-list">
							<thead class="thead">
								<tr>
									<th>id</th>
									<th>보낸사람</th>
									<th>보낸 이메일</th>
									<th>보낸 날짜</th>
									<th>제목</th>
									<th>본문</th>
									<th>첨부 파일 개수</th>
									<th>공개여부</th>
									<th>상세보기</th>
								</tr>
							</thead>
							<tbody class="tbody" id="htable-body">
								<c:forEach items="${mailDataList}" var="ml" varStatus="status1">
									<tr id="tr${status1.count}">
										<td>${ml.id}</td>
										<td>${ml.name}</td>
										<td>${ml.sendTo}</td>
										<td>${ml.sendDate}</td>
										<td>${ml.title}</td>
										<td>${ml.content }</td>
										<td>${ml.countFiles}</td>
										<td>${ml.showHide == 1? "<span>공개</span>" : "<span class='hidespan'>비공개</span>"}</td>
										<td><a class="${ml.id}" id="atag${status1.count}"><img src="${pageContext.request.contextPath}/resources/imges/magni-icon.png" /></a></td>
									</tr>
								</c:forEach>
							</tbody>	
						</table>
					</div>
					<div class="select">
						<div class="num"><a id="prev">◀</a></div>
							<%
							int Ppage = Integer.parseInt((String)request.getParameter("page"));
							int begin = (Ppage-1)/10 <= 0 ? 1 : (int)Math.ceil((Ppage-1)/10)*10+1;
							
							
							List<MailVO> list = (List<MailVO>)request.getAttribute("mailDataList");
							
							int celi = (int)Math.ceil(list.size()/10);
							int endPage = list.size() == 0 ? 1 : celi - begin > 10 ? begin+9 : list.size()%10 == 0 ? celi : celi+1;
							%>
							<c:forEach begin="<%=begin%>" end="<%=endPage%>" varStatus="status" var="var">
								<c:choose>
									<c:when test="${param.page eq var}">
										<div class="num checked"><span>${var}</span></div>
									</c:when>
									<c:otherwise>				
										<div class="num notchecked"><a href="SendEmail?page=${var}&&name=${param.name}&&year=${param.year}&&month=${param.month}">${var}</a></div>							
									</c:otherwise>
								</c:choose>
							</c:forEach>
						<div class="num"><a id="next">▶</a></div>
					</div>
				</div>
			</div>
		
					<div id="applypop">
						<div class="pop-container">
								<div class="pop1">
									<div class="pop-titleContainer">
										<span class="pop-title">AWOOGOF@GMAIL.COM</span>
									</div>
									<div>
										<a href="" id="cancle">✖️</a>
									</div>
								</div>
								<div class="pop1-1">
									<form action="WebSendMail" method="post" enctype="multipart/form-data" class="popFrom">
										<div class="mail-select-container">
											<div class="select-showHide">
												<input id="input1" type="radio" value="1" name="showHide" checked="checked"/><label for="input1" id="show">공개</label>
												<input id="input2" type="radio" value="0" name="showHide"/><label for="input2" id="hide" >비공개</label>
											</div>
											<div class="send-container-warp">
												<div>
												<button type="button" id="addid">➕</button>
												<button type="button" id="delid">➖</button>
												</div>
												<div id="send-container">
													<div>
														<label for="">EMAIL :</label>
													    <input type="email" name="email" class="email" required autocomplete='off'>
												   </div>
												</div>
											</div>
										</div>		
										<label for="title" >Title</label>
										   <input type="text" name="title" required class="mail-input" id="title">
										<label for="file">File</label>
										   <input type="file" name="attachment" multiple class="mail-input" id="file">
										<label for="content" >Content</label>
											<textarea name="content" class="ckeditor" required="required" id="content"></textarea>
									 	<div class="pop5">
									 		<button type="button" value="Submit" id="empty-send">전송</button>
											<button type="submit" value="Submit" id="real-send" style="display:none">전송</button>
<!-- 											<button type="submit" value="Submit" id="real-send">전송</button> -->
										</div>
									</form>
								</div>
							</div>
				
		        <section class="modal modal-section type-confirm" id="confirm-block">
		            <div class="enroll_box">
		                <p class="menu_msg" id="real-submit-message">메일을 보내시겠습니까?</p>
		            </div>
		            <div class="enroll_btn">
		                <button class="btn pink_btn btn_ok" id="btn_ok">확인</button>
		                <button class="btn gray_btn modal_close" id="btn_cancle">취소</button>
		            </div>
		        </section>
			</div>
		    <!-- 상세보기 -->
			<div id="detailpop">
				<div class="pop-container">
					<div class="pop1">
						<div class="pop-titleContainer">
							<span class="pop-title">메일 상세보기</span>
							<span id="pop-approval"></span>
						</div>
						<div>
							<a href="">✖️</a>
						</div>
					</div>
					<div class="detail-container">
						<div class="approval-container">
						<div></div>
						<table border="1">
							<tr>
								<td>보낸사람</td>
								<td><span id="pop-name"></span></td>
							</tr>
							<tr>
								<td>보낸이메일</td>
								<td><span id="pop-sendto"></span></td>
							</tr>
							<tr>
								<td>제목</td>
								<td><span id="pop-title"></span></td>
							</tr>
							<tr>
								<td>내용</td>
								<td><span id="pop-content"></span></td>
							</tr>
							<tr>
								<td>첨부파일 개수</td>
								<td><span id="pop-countFiles"></span></td>
							</tr>
						</table>
						
						<div class="sub-info-container">
							<div class="approvalDate">보낸 날짜: <span id="pop-sendDate"></span></div>
							<div id="reject" class="reject">공개여부: <span id="pop-showHide"></span></div>
						</div>
						<button type="button" id="btn-check">확인</button>
<!-- 							<div class="message-owner">보낸사람: <span id="pop-mownerId">-</span></div> -->
<!-- <!-- 							<div class="message-receiver">받는사람: <span id="pop-mreceiverId">-</span></div> --> 
<!-- 							<div class="message-content">내용: <span id="pop-mcontent">-</span></div> -->
<!-- 							<div class="message-date">보낸일자: <span id="pop-msendDate">-</span></div> -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<script>
		CKEDITOR.replace('textarea');
	
		document.getElementById("writeMessage").addEventListener("click",function(){
			document.getElementById("applypop").style.display = "flex";
		});
		
		const container = document.getElementById("send-container");
		document.getElementById("addid").addEventListener("click",function(){
			const div = document.createElement("div");
			div.innerHTML = "<label for=''>EMAIL :</label><input type='email' name='email' class='email' required autocomplete='off'>" 
			container.appendChild(div);
		});
		
		document.getElementById("delid").addEventListener("click",function(){
			console.log(container.fistChild);
			console.log(container.lastChild);
			if(container.children.length > 1){
				container.removeChild(container.lastChild);				
			}
		});
		
		
		
		let size = ${mailDataList.size()};
		let page = ${param.page};
		let year = ${param.year};
		let month = ${param.month};
		let name = "${param.name}";
		
		 document.addEventListener("DOMContentLoaded", function(){
		
			// 페이지 이동
			for (var i = 0; i < size; i++) {
				if(i+1 > 10*page || i+1 <= 10*(page-1)){
					document.getElementById("tr"+(i+1)).style.display = "none";		
				}
			}
			
		 });
		 
			var prev = document.getElementById("prev");
			var next = document.getElementById("next");
			
			prev.addEventListener("click",function(){
				var page1 = page-1;
				if(page1 <= 0){
					page1 = 1;
				}
				location.href="${pageContext.request.contextPath}/SendEmail?page="+page1+"&&name="+name+"&&year="+year+"&&month="+month;
			});
			next.addEventListener("click",function(){
				var page1 = page+1;
				if(page1 >= Math.ceil(size/10)){
					page1 = Math.ceil(size/10);
				}
				location.href="${pageContext.request.contextPath}/SendEmail?page="+page1+"&&name="+name+"&&year="+year+"&&month="+month;
			});
			
			
			function OnChange(){    
				let name = document.getElementById("sorting-name").value;
				let year = document.getElementById("sorting-year").value;
				let month = document.getElementById("sorting-month").value;
		    	location.href="${pageContext.request.contextPath}/SendEmail?page="+1+"&&name="+name+"&&year="+year+"&&month="+month;
		    };
		    
		    
		    document.getElementById("empty-send").addEventListener("click",function(){
		    	let emails = document.getElementsByClassName("email");
		    	let title = document.getElementById("title").value;
		    	let file = document.getElementById("file").value;
		    	let content = document.getElementById("content").value;
		    	console.log(content != "");
		    	console.log(title != "");
		    	for (var i = 0; i < emails.length; i++) {
		    		console.log(emails[i].value)
		    		if(emails[i].value != "" && title != ""){
		    			document.getElementById("confirm-block").style.display = "block";
		    		}
		    		else{
		    			document.getElementById("real-send").click();
		    		}
				}
		    	
		    	
		   	});
		    document.getElementById("btn_ok").addEventListener("click",function(){
		    	document.getElementById("real-send").click();
// 		    	alert("메일이 성공적으로 전송되었습니다");
		   	});
		    document.getElementById("btn_cancle").addEventListener("click",function(){
		    	document.getElementById("confirm-block").style.display = "none";
		   	});
		    document.getElementById("btn-check").addEventListener("click",function(){
				location.href="";
			});
		    
		 // 비동기로 상세보기 가져옴
			 for (let k = 1; k <= size; k++) {
				document.getElementById("atag"+k).addEventListener("click",function(){
					document.getElementById("detailpop").style.display = "flex";
				
					let classname = document.getElementById("atag"+k).className;
					let simple_data = {id:classname};
					
					fetch("${pageContext.request.contextPath}/mail/detail",{
						method : "POST", // PUT, PATCH, DELETE
						headers : {"Content-Type" : "application/json"},
						body : JSON.stringify(simple_data)
					}).then(response => response.json())
				
					.then(data => {
						
						document.getElementById("pop-name").innerHTML=data.name;
						
						
						document.getElementById("pop-sendto").innerHTML=data.sendTo;
						document.getElementById("pop-countFiles").innerHTML=data.countFiles;
						document.getElementById("pop-title").innerHTML=data.title;
						document.getElementById("pop-content").innerHTML=data.content;
						document.getElementById("pop-sendDate").innerHTML=data.sendDate;
						
						if(data.showHide == 1){
							document.getElementById("pop-showHide").innerHTML= "<span>공개</span>";
						}else{
							document.getElementById("pop-showHide").innerHTML= "<span class='hidespan'>비공개</span>";
						}
					}).catch(error => {
						console.log("error");
					});
				});
			 }		
	</script>
</body>
</html>