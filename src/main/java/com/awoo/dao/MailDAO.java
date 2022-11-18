package com.awoo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.awoo.vo.MailVO;
import com.awoo.vo.MessageVO;
import com.awoo.vo.PersonalInfoVO;

@Mapper
public interface MailDAO {
	
	public List<MailVO> getmailList(Map<String, Object> map);
	public List<String> getMailDistinctYear(Map<String, Object> map);
	public List<String> getMailDistinctSender(Map<String, Object> map);
	public void insertMail(MailVO vo);
	
	public MailVO getDetailMail(int id);

	
}

