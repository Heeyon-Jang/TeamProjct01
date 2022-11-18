package com.awoo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.awoo.service.ChatService;
import com.awoo.vo.CalendarVO;
import com.awoo.vo.ChatVO;

@Controller
public class ChatController {
	
	private ChatService service;

	public ChatController(ChatService service) {
		super();
		this.service = service;
	}

	@GetMapping("/chat")
	public String chat (HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		return "chat/chat";
	}
	
	@PostMapping("/insertChat")
	@ResponseBody
	public int insertChat (@RequestBody Map<String, String> map) {
		return service.insertChatMethod(map);
	}
	
	@PostMapping("/selectChat")
	@ResponseBody
	public List<ChatVO> selectChat () {
		return service.selectChatMethod();
	}
}
