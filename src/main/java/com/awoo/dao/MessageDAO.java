package com.awoo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.awoo.vo.MessageVO;
import com.awoo.vo.PersonalInfoVO;

@Mapper
public interface MessageDAO {
	
	public List<MessageVO> getReceivedMessageList(Map<String, Object> map);
	public List<MessageVO> getSendMessageList(Map<String, Object> map);
	public List<PersonalInfoVO> getDistinctEmployees();
	public List<String> getRecieveDistinctYear(MessageVO vo);
	public List<String> getSendDistinctYear(MessageVO vo);
	public List<String> getRecieveDistinctSender(MessageVO vo);
	public List<String> getRecieveDistinctReceiver(MessageVO vo);
	
	
	public void insertSendMessage(MessageVO vo);
	public void deleteMessage(int[] checked);
	public MessageVO getDetailMessageReceive(int id);
	public MessageVO getDetailMessageSend(int id);
	public void viewMessage(Map<String, Object> map);
	
	public void updateEmail(Map<String, Object> map);
	
//	public List<MessageVO> selectList();
//	
//	public MessageVO selectBBS(String id);
//	
//	public void insertData(MessageVO vo);
//	
//	//체크박스삭제 - 받은 메세지함
//	public int deleteData1(@Param("ids") int[] ids);
//	
//	//체크박스삭제 - 보낸 메세지함
//	public int deleteData2(@Param("idss") int[] idss);
//	
//	//쪽지 보내기 추가
//	public int insertmessage(MessageVO vo);

	
}

