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
					<!-- 각자 필요한 부분 넣기 -->
					<h3 class="sub-title">받은 쪽지함</h3> 
					<div class="table-head">
						
						<button type="button" id="writeMessage">쪽지쓰기</button>
<!-- 						<button type="button" id="deleteMessage">삭제</button> -->
						
						<div class="sortings">
							<select name="sorting-year" id="sorting-name" onchange="OnChange();">
								<option value="0">보낸사람 전체</option>
								<c:forEach items="${rdistinctSender}" var="sender">
									<option value="${sender}" <c:if test ="${sender eq param.name}">selected="selected"</c:if>>${sender}</option>
								</c:forEach>
							</select>
							<span>님</span>
							<select name="sorting-year" id="sorting-year" onchange="OnChange();">
								<option value="0">전체 연도</option>
								<c:forEach items="${rdistinctYear}" var="year">
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
					<div class="color-info">
						<p>🟢 읽음 </p>
						<p>🟠 읽지 않음 </p>
					</div>	
					<div class="div2">
						<table class="holiday-list message-List">
							<thead class="thead">
								<tr>
									<th class="checkbox-table"><input type="checkbox" name="allCheck" id="allCheck" onclick="checkAll()"></th>
									<th>보낸사람</th>
									<th>내용</th>
									<th>보낸날짜</th>
									<th>상세보기</th>
								</tr>
							</thead>	
							<tbody class="tbody" id="htable-body">
								<c:forEach items="${rmessageList}" var="rl" varStatus="status1">
									<tr id="tr${status1.count}">
										<td class="checkbox-table"><input type="checkbox" class="checkbox" name="checkbox" id="checkbox" value="${rl.id}"/></td>
										<td>${rl.ownerName}</td>
										<td>${rl.mcontent}</td>
										<td>${rl.msendDate}</td>
										<td><a class="${rl.id}" id="atag${status1.count}"><img src="${pageContext.request.contextPath}/resources/imges/magni-icon.png" /></a>
										<c:if test="${rl.view != 1}"><span style="color: #299cff">🟠</span></c:if>
										<c:if test="${rl.view == 1}"><span style="color: #299cff">🟢</span></c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="bottom-div">
						<button type="button" id="deleteMessage">삭제</button>
					</div>		
					
						<div class="select">
							<div class="num"><a id="prev">◀</a></div>
							
									<%
									int Ppage = Integer.parseInt((String)request.getParameter("page"));
									int begin = (Ppage-1)/10 <= 0 ? 1 : (int)Math.ceil((Ppage-1)/10)*10+1;
									
									
									List<MessageVO> list = (List<MessageVO>)request.getAttribute("rmessageList");
									
									int celi = (int)Math.ceil(list.size()/10);
									int endPage = list.size() == 0 ? 1 : celi - begin > 10 ? begin+9 : list.size()%10 == 0 ? celi : celi+1;
									%>
									<c:forEach begin="<%=begin%>" end="<%=endPage%>" varStatus="status" var="var">
							
							
<%-- 											<c:forEach begin="1" end="${CommutingList.size() == 0? 1 : CommutingList.size()%10 == 0? CommutingList.size()/10 :((CommutingList.size()/10)+(1-((CommutingList.size()/10)%1))%1)}" varStatus="status"> --%>
									<c:choose>
										<c:when test="${param.page eq var}">
											<div class="num checked"><span>${var}</span></div>
										</c:when>
										<c:otherwise>				
											<div class="num notchecked"><a href="ReceivedMessage?page=${var}&&name=${param.name}&&year=${param.year}&&month=${param.month}">${var}</a></div>							
										</c:otherwise>
									</c:choose>
								</c:forEach>
							<div class="num">
								<a id="next">▶</a>
							</div>
						</div>
				</div>
			</div>
			<!-- 쪽지 보내기 -->
			<div id="applypop">
				<div class="pop-container">
					<form action="${pageContext.request.contextPath}/sendMessage/sendMessage" class="pop-form" method="post">
						<div class="pop1">
							<div class="pop-titleContainer">
								<span class="pop-title">쪽지쓰기</span><span><span class="important">*</span>필수 입력란입니다</span>
							</div>
							<div>
								<a href="">✖️</a>
							</div>
						</div>
						<div class="pop1-1">
							<div class="writeToMeContainer">
								<button type="button" id="writeToMe">내게쓰기</button>
							</div>	
							<div class="pop2">
								<p class="p"><span class="important">*</span>보낼사람 (사원번호)</p>
								<input type="text" id="mreceiverId" name="mreceiverId" onkeyup="filter()" required autocomplete='off' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>
								<!-- 이름검색 -->
								<div class="person-info-container">
									 <c:forEach items="${employees}" var="em">
									 	<div class="emp-info">${em.name}<span class="name">${em.empno}</span></div>
									 </c:forEach>
								</div>
							</div>
							
							<div class="pop2-1">
								<div class="pop3">
									<p class="p"><span class="important">*</span>내용</p>
									<textarea placeholder="내용을 입력해주세요" name="mcontent" id="mcontent" required></textarea>
								</div>
							</div>
							<div class="pop2">
								<button id="submit-btn" type="button">전송</button>
								<button type="submit" id="real-submit-btn" style="display: none">전송</button>
							</div>
						</div>
					</form>
				</div>
		        <section class="modal modal-section type-confirm" id="confirm-block">
		            <div class="enroll_box">
		                <p class="menu_msg" id="real-submit-message">쪽지를 전송하시겠습니까?</p>
		            </div>
		            <div class="enroll_btn">
		                <button class="btn pink_btn btn_ok" id="btn_ok">확인</button>
		                <button class="btn gray_btn modal_close" id="btn_cancle">취소</button>
		            </div>
		        </section>
			</div>
		
			<!-- 쪽지 상세보기 -->
			<div id="detailpop">
				<div class="pop-container">
					<div class="pop1">
						<div class="pop-titleContainer">
							<span class="pop-title">받은 쪽지 상세보기</span>
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
								<td><span id="pop-mownerId"></span></td>
							</tr>
							<tr>
								<td>확인여부</td>
								<td><span id="pop-halfDay"></span></td>
							</tr>
							<tr>
								<td>보낸일자</td>
								<td><span id="pop-hstartDate"></span><span id="pop-msendDate"></span></td>
							</tr>
							<tr>
								<td>내용</td>
								<td><span id="pop-mcontent"></span></td>
							</tr>
						</table>
						
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
	let size = ${rmessageList.size()};
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
			location.href="${pageContext.request.contextPath}/ReceivedMessage?page="+page1+"&&name="+name+"&&year="+year+"&&month="+month;
		});
		next.addEventListener("click",function(){
			var page1 = page+1;
			if(page1 >= Math.ceil(size/10)){
				page1 = Math.ceil(size/10);
			}
			location.href="${pageContext.request.contextPath}/ReceivedMessage?page="+page1+"&&name="+name+"&&year="+year+"&&month="+month;
		});
		
	
		document.getElementById("writeMessage").addEventListener("click",function(){
			document.getElementById("applypop").style.display = "flex";
		});
		document.getElementById("writeToMe").addEventListener("click",function(){
			document.getElementById("mreceiverId").value = "${empno}";
			document.querySelector(".person-info-container").style.display="none";
		});
		document.getElementById("submit-btn").addEventListener("click",function(){
			let recieverId = document.getElementById("mreceiverId").value;
			let content = document.getElementById("mcontent").value;
			console.log(recieverId);
			if(recieverId != "" && content != ""){
				document.getElementById("confirm-block").style.display= "block";			
			}else{
				document.getElementById("real-submit-btn").click();
			}
		});
		document.getElementById("mreceiverId").addEventListener("click",function(){
			 document.querySelector(".person-info-container").style.display="block";
		});
		document.getElementById("btn_ok").addEventListener("click",function(){
			document.getElementById("real-submit-btn").click();
		});
		document.getElementById("btn_cancle").addEventListener("click",function(){
			document.getElementById("confirm-block").style.display= "none";
		});
		document.getElementById("deleteMessage").addEventListener("click",function(){
			let ck = document.getElementsByClassName("checkbox");

				
				var url = "";
				var valueArr = new Array();
				var list = ck;
				
				for (var i = 0; i < list.length; i++) {
					if (list[i].checked) {
						valueArr.push(list[i].value);
						console.log(valueArr);
					}
				}
				if (valueArr.length == 0) {
					alert("삭제할 쪽지가 없습니다.");
				} else {
					var chk = confirm("정말 삭제하시겠습니까?");	
					if(chk){
						fetch("${pageContext.request.contextPath}/sendMessage/deleteMessage",{
							method : "POST", // PUT, PATCH, DELETE
							headers : {"Content-Type" : "application/json"},
							body : JSON.stringify(valueArr)
						}).then(response => response.json())
					
						.then(data => {
							
							alert("삭제가 완료되었습니다.");
						}).catch(error => {
							console.log("error");
						});	
					}
					
			}		
			location.reload();
		});		
	
		document.getElementById("btn-check").addEventListener("click",function(){
			location.href="";
		});	
			
      function filter(){
    	  document.querySelector(".person-info-container").style.display="block";
          let value = document.getElementById("mreceiverId").value;
          let name = document.getElementsByClassName("name");
          
          for(let i=0;i<name.length;i++){
       		if(name[i].innerHTML.indexOf(value) > -1){
      				name[i].parentNode.style.display = "block";
 	            }else{
 	            	name[i].parentNode.style.display = "none";
 	            }
       		
       	  }
       }
      
      
      let infos = document.querySelectorAll(".emp-info");
      for (var j = 0; j < infos.length; j++) {
    	  infos[j].addEventListener("click",function(){
			document.getElementById("mreceiverId").value = this.children[0].innerHTML;
			document.querySelector(".person-info-container").style.display="none";
		});
	  }
      
  	function checkAll() {
		const checkboxes = document.getElementsByName("checkbox");
		if (document.getElementById("allCheck").checked == true) {
			for (var i = 0; i < checkboxes.length; i++)
				checkboxes[i].checked = true;
		}
		if (document.getElementById("allCheck").checked == false) {
			for (var i = 0; i < checkboxes.length; i++)
				checkboxes[i].checked = false;
		}
	}

      

 // 비동기로 상세보기 가져옴
	 for (let k = 1; k <= size; k++) {
		document.getElementById("atag"+k).addEventListener("click",function(){

			document.getElementById("detailpop").style.display = "flex";
		
			let classname = document.getElementById("atag"+k).className;
			let simple_data = {id:classname};
			
			fetch("${pageContext.request.contextPath}/message/detail/receive",{
				method : "POST", // PUT, PATCH, DELETE
				headers : {"Content-Type" : "application/json"},
				body : JSON.stringify(simple_data)
			}).then(response => response.json())
		
			.then(data => {
				
				document.getElementById("pop-mownerId").innerHTML=data.ownerName;
				document.getElementById("pop-mcontent").innerHTML=data.mcontent;
				
				if(data.view == 1){
					document.getElementById("pop-halfDay").innerHTML= "읽음";	
				}else{
					document.getElementById("pop-halfDay").innerHTML= "읽지 않음";
				}
				document.getElementById("pop-msendDate").innerHTML=data.msendDate;
				
			
			}).catch(error => {
				console.log("error");
			});
		});
	 }		
 
 
		function OnChange(){    
			let name = document.getElementById("sorting-name").value;
			let year = document.getElementById("sorting-year").value;
			let month = document.getElementById("sorting-month").value;
	    	location.href="${pageContext.request.contextPath}/ReceivedMessage?page="+1+"&&name="+name+"&&year="+year+"&&month="+month;
	    };
	</script>
	
</body>
</html>