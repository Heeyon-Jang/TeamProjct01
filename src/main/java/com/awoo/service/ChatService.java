package com.awoo.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.awoo.dao.ChatDAO;
import com.awoo.vo.ChatVO;

@Service
public class ChatService {
	
	private ChatDAO dao;
	
	public ChatService(ChatDAO dao) {
		super();
		this.dao = dao;
	}
	
	public int insertChatMethod(Map<String, String> map) {
		return dao.insertChat(map);
	}
	
	public List<ChatVO> selectChatMethod() {
		return dao.selectChat();
	}
}
