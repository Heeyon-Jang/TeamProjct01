<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Web Socket Example</title>
</head>
<style>
*{
	margin: 0;
	padding: 0;
	font-family: 'Noto Sans KR', sans-serif;
}
/* textarea { */
/* 	resize: none; */
/* 	width: 500px; */
/* 	height: 100px; */
/* } */
#messageTextArea {
	width: 400px;
	height: 300px;
	border: 1px solid black;
	overflow: auto;
}
#conn, #disconn {
	display: none;
}
#user {
	display: none;
}

.leftDiv {
	margin: 0 0 10px 10px;
}
.rightDiv {
	text-align:right;
	margin: 0 0 10px 10px;
}
.leftText, .rightText {
	padding: 5px;
	display: inline-block;
	max-width: 250px;
	word-break: break-all;
	background-color: #eee;
	border-radius: 5px;
	font-size: 15px;
}
.centerText {
	display: inline-block;
	background-color: #eee;
	border-radius: 5px;
	font-size: 14px;
}

</style>
<body>
	<div id="messageTextArea">
	
	</div>
	
	<br />
	
	<form>
		<!-- 유저 명을 입력하는 텍스트 박스(기본 값은 anonymous(익명)) -->
		<input id="user" type="text" value="" readonly>
		<!-- 송신 메시지를 작성하는 텍스트 박스 -->
		<input id="textMessage" type="text">
		<!-- 메세지를 송신하는 버튼 -->
		<input onclick="sendMessage()" value="Send" type="button" id="send">
		<!-- WebSocket 접속 종료하는 버튼 -->
		<input onclick="disconnect()" value="Disconnect" type="button" id="disconn">

		<input onclick="connect()" value="connect" type="button" id="conn">

	</form>
	<br />
	
	<script type="text/javascript">
// 		접속한 유저 이름 자동 기입
		var user = document.getElementById("user");
		user.value = sessionStorage.getItem("ename");
		var empno = sessionStorage.getItem("empno");
	</script>
	
	<script type="text/javascript">
		// 콘솔 텍스트 에리어 오브젝트
		const messageTextArea = document.getElementById("messageTextArea");
		
		// 웹 소켓 접속 함수, url 뒤의 파라미터는 callback 함수를 받는다.
		function connectWebSocket(url, message, open, close, error) {
			// WebSocket 오브젝트 생성 (자동으로 접속 시작한다. - onopen 함수 호출)
			let webSocket = new WebSocket(url);
			// 함수 체크하는 함수
			function call(cb, msg) {
				// cb가 함수 타입인지 확인
				if (cb !== undefined && typeof cb === "function") {
					// 함수 호출
					cb.call(null, msg);
				}
			}
			// WebSocket 서버와 접속이 되면 호출되는 함수
			webSocket.onopen = function() {
				// callback 호출
				call(open);
			};
			// WebSocket 서버와 접속이 끊기면 호출되는 함수
			webSocket.onclose = function() {
				// callback 호출
				call(close);
			};
			// WebSocket 서버와 통신 중에 에러가 발생하면 요청되는 함수
			webSocket.onerror = function() {
				// callback 호출
				call(error);
			};
			// WebSocket 서버로 부터 메시지가 오면 호출되는 함수
			webSocket.onmessage = function(msg) {
				// callback 호출
				call(message, msg);
			};
			// 웹 소켓 리턴
			return webSocket;
		}

		
		// 연결 발생 때 사용할 callback 함수
		var open = function() {
			fetch("${pageContext.request.contextPath}/selectChat",{
				method : "POST", // PUT, PATCH, DELETE
				headers : {"Content-Type" : "application/json"},
// 				body : JSON.stringify(msgData)
			}).then(response => response.json())
			.then(data => {
// 				console.log("성공");
				
				let list = data;
				let temp = "";
				
				for (var i = 0; i < list.length; i++) {
//	 				접속한 유저와 empno가 같을때
					if (list[i].empno == empno) {
//		 				콘솔 텍스트에 메시지를 출력한다.
						temp += '<div class="rightDiv">';
//			 			temp += '<p>' + user.value + '</p>';
						temp += '<span style="font-size:11px;color:#777;">' + list[i].chTime + '</span>';
						temp += '<span class="rightText">' + list[i].chContent + '</span>';
						temp += '</div>';
					}
					else {
						temp += '<div class="leftDiv">';
						temp += '<p>' + list[i].ename + '</p>';
						temp += '<span class="leftText">' + list[i].chContent + '</span>';
						temp += '<span style="font-size:11px;color:#777;">' + list[i].chTime + '</span>';
						temp += '</div>';
					}
				}
				
				messageTextArea.innerHTML += temp;
//	 			채팅 화면 최하단 이동
				messageTextArea.scrollTop = messageTextArea.scrollHeight;
				
			}).catch(error => {
				console.log("error");
			});
			
			// 콘솔 텍스트에 메시지를 출력한다
			openPrint(user.value, " 님이 입장했습니다.");
			
// 			채팅 화면 최하단 이동
			messageTextArea.scrollTop = messageTextArea.scrollHeight;
			
			// WebSocket 서버에 메시지를 전송(형식 「{{유저명}}메시지」)  
			webSocket.send("{{" + "1#"+user.value+"#" + "}}");
		}
		// 종료 발생 때 사용할 callback 함수
		var close = function() {
			// 콘솔 텍스트에 메시지를 출력한다
			closePrint(user.value, " 님이 퇴장했습니다.");
			
// 			채팅 화면 최하단 이동
			messageTextArea.scrollTop = messageTextArea.scrollHeight;
			
// 			// 재 접속을 시도한다.
// 			setTimeout(function() {
// 				// 재접속
// 				webSocket = connectWebSocket(
// 						"ws://localhost:8080/Awoo/chatServer", message, open,
// 						close, error);
// 			});

		}
		// 에러 발생 때 사용할 callback 함수
		var error = function() {
			messageTextArea.innerHTML += "error...\n";
		}
		// 메세지를 받을 때 사용할 callback 함수
		var message = function(msg) {
// 	    	console.log("서버로 부터 받은 메시지");
// 	    	ex) 1#김석호#220204#message
// 	    	console.log(msg.data);

			let indexSer = msg.data.indexOf("#", 2);
			let noSer = msg.data.substring(0, 1); 
			let userSer = msg.data.substring(2, indexSer);
			let txtSer = msg.data.substring(indexSer + 1);
			
			
			let indexEmp = msg.data.indexOf("#", 10);
			let userEmp = msg.data.substring(indexSer+1, indexEmp);
			let txtEmp = msg.data.substring(indexEmp + 1);
			
			if (noSer == "1") {		// client 접속
				openPrint(userSer, " 님이 접속하셨습니다.");
			} else if (noSer == "2") {	// 메시지 전송
				msgPrint(userSer, userEmp, txtEmp);
			} else if (noSer == "3") {	// client 접속 종료
				closePrint(userSer, " 님이 퇴장하셨습니다.");
			}
		};
		// 웹 소켓 생성
		var webSocket = connectWebSocket("ws://localhost:8080/Awoo/chatServer",
// 		var webSocket = connectWebSocket("ws://192.168.12.37:8080/Awoo/chatServer",
				message, open, close, error);

		// Send 버튼을 누르면 호출되는 함수  
		function sendMessage() {
			// 송신 메시지를 작성하는 텍스트 박스 오브젝트를 취득  
			var message = document.getElementById("textMessage");
			// 콘솔 텍스트에 메시지를 출력한다.
			let temp = "";
			temp += '<div class="rightDiv">';
// 			temp += '<p>' + user.value + '</p>';
			temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
			temp += '<span class="rightText">' + message.value + '</span>';
			temp += '</div>';
			
			messageTextArea.innerHTML += temp;
// 			채팅 화면 최하단 이동
			messageTextArea.scrollTop = messageTextArea.scrollHeight;
			
			// WebSocket 서버에 메시지를 전송(형식 「{{유저명}}메시지」)  
// 			webSocket.send("{{" + "2#"+user.value+"#" + "}}" + message.value);
			webSocket.send("{{" + "2#"+user.value+"#"+empno+"#" + "}}" + message.value);
			// 송신 메시지를 작성한 텍스트 박스를 초기화한다.  
			message.value = "";
		}
		
// 		입장시 서버로 메시지 전송
		function openPrint(user, txt) {
			let temp = "";
			temp += '<div style="margin-bottom:3px;text-align:center;">';
			temp += '<span class="centerText">';
			temp += '[' + user + '] ';
			temp += txt;
			temp += '</span>';
// 			temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
			temp += '</div>';
			
			messageTextArea.innerHTML += temp;
// 			채팅 화면 최하단 이동
			messageTextArea.scrollTop = messageTextArea.scrollHeight;
		}
		// 메세지 전송 및 아이디
		function msgPrint(user, empno, txt) {
			const tempDate = new Date().toLocaleDateString();
			const tempTime = new Date().toLocaleTimeString();
			let temp = "";
			temp += '<div class="leftDiv">';
			temp += '<p>' + user + '</p>';
			temp += '<span class="leftText">' + txt + '</span>';
			temp += '<span style="font-size:11px;color:#777;">' + tempTime + '</span>';
			temp += '</div>';
			
			messageTextArea.innerHTML += temp;
// 			채팅 화면 최하단 이동
			messageTextArea.scrollTop = messageTextArea.scrollHeight;
			
			let msgData = {
					ename : user,
					empno : empno,
					chContent : txt,
					chDate : tempDate,
					chTime : tempTime
			}
			fetch("${pageContext.request.contextPath}/insertChat",{
				method : "POST", // PUT, PATCH, DELETE
				headers : {"Content-Type" : "application/json"},
				body : JSON.stringify(msgData)
			}).then(response => response.json())
			.then(data => {
// 				console.log("성공");
			}).catch(error => {
				console.log("error");
			});
			
		}
// 		client 접속 종료
		function closePrint(user, txt) {
			let temp = "";
			temp += '<div style="margin-bottom:3px;text-align:center;">';
			temp += '<span class="centerText">';
			temp += '[' + user + '] ';
			temp += txt;
			temp += '</span>';
// 			temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
			temp += '</div>';
			
			messageTextArea.innerHTML += temp;
// 			채팅 화면 최하단 이동
			messageTextArea.scrollTop = messageTextArea.scrollHeight;
		}
		
		
		
		// Disconnect 버튼을 누르면 호출되는 함수  
		function disconnect() {
			webSocket.send("{{" + "3#"+user.value+"#" + "}}");
			
			// WebSocket 접속 해제
			webSocket.close();

			console.log("실행 222");
		}
		function connect() {
			// 재 접속을 시도한다.
			setTimeout(function() {
				// 재접속
				webSocket = connectWebSocket(
						"ws://localhost:8080/Awoo/chatServer", message, open,
// 						"ws://192.168.12.37:8080/Awoo/chatServer", message, open,
						close, error);
			});
		}
		
		document.getElementById("textMessage").addEventListener("keydown", function(e){
			if (e.keyCode == 13) {
				document.getElementById("send").click();
			}
		});
	</script>
	
	
</body>
</html>