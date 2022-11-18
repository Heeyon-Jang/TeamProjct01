package com.awoo.server;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

//WebSocket 호스트 설정
@ServerEndpoint("/chatServer")
public class ChatServer {
	// 접속 된 클라이언트 WebSocket session 관리 리스트
	private static List<Session> sessionUsers = Collections.synchronizedList(new ArrayList<>());
	// 메시지에서 유저 명을 취득하기 위한 정규식 표현
	private static Pattern pattern = Pattern.compile("^\\{\\{.*?\\}\\}");
	// WebSocket으로 브라우저가 접속하면 요청되는 함수	
	@OnOpen
	public void handleOpen(Session userSession) {
		// 클라이언트가 접속하면 WebSocket세션을 리스트에 저장한다.
		sessionUsers.add(userSession);
		// 콘솔에 접속 로그를 출력한다.
//		System.out.println("client is now connected...");
	}
	// WebSocket으로 메시지가 오면 요청되는 함수
	@OnMessage
	public void handleMessage(String message, Session userSession) throws IOException {
		// 메시지 내용을 콘솔에 출력한다.
//		System.out.println(message);
		// 초기 유저 명
		String name = "anonymous";
		// 메시지로 유저 명을 추출한다.
		Matcher matcher = pattern.matcher(message);
		
		// 메시지 예: {{유저명}}메시지
		if (matcher.find()) {
			name = matcher.group();
		}
		// 클로져를 위해 변수의 상수화
		final String msg = message.replaceAll(pattern.pattern(), "");
		String tempName = name.replaceFirst("^\\{\\{", "").replaceFirst("\\}\\}$", "");
		String no = tempName.split("#")[0];
		
//		내가 아닌 client가 입장했을때
		if (no.equals("1")) {
//			replaceFirst(기존문자, 바뀔문자) 변경되며, replace와는 다르게 처음으로 만난 문자만 변경된다.
			final String username1 = tempName.split("#")[1];
			
//			session관리 리스트에서 Session을 취득한다.
			for (Session session : sessionUsers) {
				try {
					if (session != userSession) {
						session.getBasicRemote().sendText("1#" + username1 + "#");
					}
				} catch (IOException e2) {
					e2.printStackTrace();
				}
			}
		}
//		client가 메시지를 보냈을때
		else if (no.equals("2")) {
//			replaceFirst(기존문자, 바뀔문자) 변경되며, replace와는 다르게 처음으로 만난 문자만 변경된다.
			final String username2 = tempName.split("#")[1];
			final String userEmano = tempName.split("#")[2];
			
//			session관리 리스트에서 Session을 취득한다.
			for (Session session : sessionUsers) {
				try {
					if (session != userSession) {
						session.getBasicRemote().sendText("2#" + username2 + "#" + userEmano + "#" + msg);
					}
				} catch (IOException e2) {
					e2.printStackTrace();
				}
			}
		}
//		client가 퇴장했을때
		else if (no.equals("3")) {
//			replaceFirst(기존문자, 바뀔문자) 변경되며, replace와는 다르게 처음으로 만난 문자만 변경된다.
			final String username3 = tempName.split("#")[1];
			
//			session관리 리스트에서 Session을 취득한다.
			for (Session session : sessionUsers) {
				try {
					if (session != userSession) {
						session.getBasicRemote().sendText("3#" + username3 + "#");

					}
				} catch (IOException e2) {
					e2.printStackTrace();
				}
			}
			
		}
		
		
//		아래와 같이 쓸 수도 있음
//		forEach에서 return forEach만 벗어나지만 forin문에서의 return은 그 상위의 메서드가 종료되는 차이점이 있다.
//		sessionUsers.forEach(session -> {
//		// 리스트에 있는 세션과 메시지를 보낸 세션이 같으면 메시지 송신할 필요없다.
//		if (session == userSession) {
//			return;
//		}
//		try {
//			// 리스트에 있는 모든 세션(메시지 보낸 유저 제외)에 메시지를 보낸다. (형식: 유저명 => 메시지)
//			session.getBasicRemote().sendText(username + " => " + msg);
//		} catch (IOException e) {
//			// 에러가 발생하면 콘솔에 표시한다.
//			e.printStackTrace();
//		}
//	});

	}
	
	
	// WebSocket과 브라우저가 접속이 끊기면 요청되는 함수
	@OnClose
	public void handleClose(Session userSession) {
		// session 리스트로 접속 끊은 세션을 제거한다.
		sessionUsers.remove(userSession);
		// 콘솔에 접속 끊김 로그를 출력한다.
//		System.out.println("client is now disconnected...");
	}
}
