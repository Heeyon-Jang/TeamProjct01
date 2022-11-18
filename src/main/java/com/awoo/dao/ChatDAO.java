package com.awoo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.awoo.vo.ChatVO;

@Mapper
public interface ChatDAO {
	
	public int insertChat(Map<String, String> map);
	
	public List<ChatVO> selectChat();
	
//	public String selectEname(int empno);
	
}
