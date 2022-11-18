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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/admin/kakaoSendStyle.css">
<script id="javascript-sdk" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<title>Insert title here</title>
<style>
#detailpop .pop-container{
	 background-image: url("${pageContext.request.contextPath}/resources/imges/kakao.png");
 	 background-size : cover; 
	 height: 816px;
	 padding:0;
	 justify-content: flex-start;
}
.button-kakao{
    width: 300px;
    z-index: 10;
    height: 100%;
    background-size: contain;
    background-repeat: no-repeat;
	background-image: url("${pageContext.request.contextPath}/resources/imges/kakao-button.png");
}
.no-button-kakao{
	width: 300px;
    z-index: 10;
    height: 100%;
    background-size: contain;
    background-repeat: no-repeat;
	background-image: url("${pageContext.request.contextPath}/resources/imges/kakao-mb.png");
}

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

					
				</div>
				
					<!-- 쪽지 보내기 -->
			<div id="applypop">
				<div class="pop-container">
						<div class="pop1">
							<div class="pop-titleContainer">
								<span class="pop-title">카카오톡 공지</span>
								<p>◎ 아래 카카오톡 아이콘을 눌러 전송하세요</p>
							</div>
							<div>
								<a href=""></a>
							</div>
						</div>
						<div class="pop1-1">
							<div class="writeToMeContainer">
								<button type="button" id="prev-show"><img src="${pageContext.request.contextPath}/resources/imges/prev-show.png"/>미리보기</button>
								
							</div>	
							<div class="pop2">
								<label for="img">1. 이미지 url : </label><input type="text" id="img" name="img" value="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNuvafpok1f34VfmtLMX_0RYNYnJ-aSpv0qQ&usqp=CAU"/>
								<label for="title">2. 제목 : </label><input type="text" id="title" name="title" value="공지제목입니다"/>
								<label for="content">3. 본문 : </label><input type="text" id="content" name="content" value="공지본문입니다" />
								<label for="button">4. 버튼 : </label><input type="text" id="button" name="button" value=""/>
								<label for="buttonURL">5. 버튼 이동 url : </label><input type="text" id="buttonURL" name="buttonURL" value=""/>
								<a id="kakao-link-btn" href="javascript:sendLink()">
							 	 <img src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"/>
								</a>	
							</div>
						</div>
						<div class="empty-div">
						</div>
					</div>
				</div>
				
				
				<div id="detailpop" style="display:none">
				<div class="pop-container">
					<a id="backbtn" class="pop1"></a>
					<div class="detail-container">
						<div class="button-kakao" id="button-kakao" style="display:none">
							<img src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png" class="kakao-message-img" id="kbi"/>
							<p class="kakao-title" id="kbt">제목입니다</p>
							<p class="kakao-content" id="kbc">본문입니다</p>	
							<p class="kakao-button" id="kbb">버튼입니다</p>		
						</div>
						<div class="no-button-kakao" id="no-button-kakao" style="display:none">
							<img src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png" class="kakao-message-img" id="knbi"/>
							<p class="kakao-title" id="knbt">제목입니다</p>
							<p class="kakao-content" id="knbc">본문입니다</p>
						</div>
					</div>
				</div>
			</div>
				
				
				
<!-- 		        <section class="modal modal-section type-confirm" id="confirm-block"> -->
<!-- 		            <div class="enroll_box"> -->
<!-- 		                <p class="menu_msg" id="real-submit-message">쪽지를 전송하시겠습니까?</p> -->
<!-- 		            </div> -->
<!-- 		            <div class="enroll_btn"> -->
<!-- 		                <button class="btn pink_btn btn_ok" id="btn_ok">확인</button> -->
<!-- 		                <button class="btn gray_btn modal_close" id="btn_cancle">취소</button> -->
<!-- 		            </div> -->
<!-- 		        </section> -->
				</div>
			</div>
		</div>
	
	
<script type="text/javascript">
 Kakao.init('88f4903fdd2bacd47c43abc82d37273c');
  function sendLink() {
	  let img1 = document.getElementById("img").value;
	  let title1 = document.getElementById("title").value;
	  let content1 = document.getElementById("content").value;
	  let button1 = document.getElementById("button").value;
	  let buttonURL1 = document.getElementById("buttonURL").value;
	  
    Kakao.Link.sendDefault({
      objectType: 'feed',
      content: {
        title: title1,
        description: content1,
        imageUrl:img1,
        link: {
          mobileWebUrl: 'https://www.naver.com',
          webUrl: 'https://www.naver.com',
        },
      },
//       social: {
//         likeCount: 9999, //99999가 최대입니다
//         commentCount: 9999, //99999가 최대입니다
//         sharedCount: 9999, //99999가 최대입니다
//       },
      buttons: [
        {
          title: button1,
          link: {
            mobileWebUrl: buttonURL1,
            webUrl: buttonURL1,
          },
        },
      ],
    })
  }
  
  
  document.getElementById("prev-show").addEventListener("click",function(){
	  let img1 = document.getElementById("img").value;
	  let title1 = document.getElementById("title").value;
	  let content1 = document.getElementById("content").value;
	  let button1 = document.getElementById("button").value;
	  let buttonURL1 = document.getElementById("buttonURL").value;
		document.getElementById("detailpop").style.display = "flex";
		
		if(button1 == "" || button1 == null){
			document.getElementById("no-button-kakao").style.display = "block";
			document.getElementById("button-kakao").style.display = "none";
			document.getElementById("knbi").src = img1;
			document.getElementById("knbt").innerHTML = title1;
			document.getElementById("knbc").innerHTML = content1;
			
		}else{
			document.getElementById("button-kakao").style.display = "block";
			document.getElementById("no-button-kakao").style.display = "none";
			document.getElementById("kbi").src = img1;
			document.getElementById("kbt").innerHTML = title1;
			document.getElementById("kbc").innerHTML = content1;
			document.getElementById("kbb").innerHTML = button1;
		}
	
  })
    document.getElementById("backbtn").addEventListener("click",function(){
	  document.getElementById("detailpop").style.display = "none";
	})
  

</script>
</body>
</html>