
//==========================================================
//채팅창
//==========================================================

//채팅창
const includeChat = document.querySelector(".includeChat");
//채팅창에 최종적으로 적용된 style
const chatWrap = window.getComputedStyle(includeChat);
// 콘솔 텍스트 에리어 오브젝트
const textArea = document.getElementById("messageTextArea");
//채팅창 활성화 첫번째 버튼
const btnFirstImg = document.querySelector(".btnFirstImg");
//채팅창 비활성화 두번째 버튼
const btnSecondImg = document.querySelector(".btnSecondImg");
//채팅창 활성화 첫번째 버튼의 이미지
const firstImg =  document.querySelector(".btnFirstImg > img");
//채팅창 비활성화 두번째 버튼의 이미지
const secondImg = document.querySelector(".btnSecondImg > img");

//첫번째 버튼 클릭시 채팅창 활성화
btnFirstImg.addEventListener("click", function(){
//	채팅창 비활성화 상태일때
	if (chatWrap.display == "none") {
//		채팅창 활성화시 효과 추가
		includeChat.classList.add("puff-in-br");
//		채팅창 활성화
		includeChat.style.display = "block";
//		첫번째 버튼 비활성화시 효과 추가
		firstImg.classList.add("flip-out-hor-top");
//		두번째 버튼 활성화시 효과 추가
		secondImg.classList.add("flip-in-hor-bottom");
//		채팅 화면 최하단 이동
		textArea.scrollTop = messageTextArea.scrollHeight;
		
		setTimeout(function (){
//			채팅창 활성화 이후 효과 제거
			includeChat.classList.remove("puff-in-br");
//			두번째 버튼 활성화
			btnSecondImg.style.display = "flex";
//			두번째 버튼 활성화 이후 효과 제거
			secondImg.classList.remove("flip-in-hor-bottom");
//			첫번째 버튼 비활성화
			btnFirstImg.style.display = "none"; 
//			첫번째 버튼 비활성화 이후 효과 제거
			firstImg.classList.remove("flip-out-hor-top");
		}, 250);
	}
});

//두번째 버튼 클릭시 채팅창 비활성화
btnSecondImg.addEventListener("click", function(){
//	채팅창 활성화 상태일때
	if (chatWrap.display == "block") {
//		채팅창 비활성화시 효과 추가
		includeChat.classList.add("puff-out-br");
//		두번째 버튼 비활성화시 효과 추가
		secondImg.classList.add("flip-out-hor-top");
//		첫번째 버튼 활성화시 효과 추가
		firstImg.classList.add("flip-in-hor-bottom");
		
		setTimeout(function (){
//			채팅창 비활성화시 효과 제거
			includeChat.classList.remove("puff-out-br");
//			채팅창 비활성화
			includeChat.style.display = "none";
//			두번째 버튼 비활성화
			btnSecondImg.style.display = "none";
//			두번째 버튼 비활성화 이후 효과 추가
			secondImg.classList.remove("flip-out-hor-top");
//			첫번째 버튼 활성화
			btnFirstImg.style.display = "flex";
//			첫번째 버튼 활성화시 효과 추가
			firstImg.classList.remove("flip-in-hor-bottom");
		}, 250);
	}
});

//채팅창 활성화 상태에서 esc 키다운시 채팅창 비활성화
window.onkeydown = function(event) {
	if (event.keyCode == 27) {
		if (chatWrap.display == "block") {
//			채팅창 비활성화시 효과 추가
			includeChat.classList.add("puff-out-br");
//			두번째 버튼 비활성화시 효과 추가
			secondImg.classList.add("flip-out-hor-top");
//			첫번째 버튼 활성화시 효과 추가
			firstImg.classList.add("flip-in-hor-bottom");
			
			setTimeout(function (){
//				채팅창 비활성화시 효과 제거
				includeChat.classList.remove("puff-out-br");
//				채팅창 비활성화
				includeChat.style.display = "none";
//				두번째 버튼 비활성화
				btnSecondImg.style.display = "none";
//				두번째 버튼 비활성화 이후 효과 추가
				secondImg.classList.remove("flip-out-hor-top");
//				첫번째 버튼 활성화
				btnFirstImg.style.display = "flex";
//				첫번째 버튼 활성화시 효과 추가
				firstImg.classList.remove("flip-in-hor-bottom");
			}, 250);
		}
	}
}
