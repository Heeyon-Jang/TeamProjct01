package com.awoo.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.awoo.vo.EmployeeInfoVO;
import com.awoo.vo.PersonalInfoVO;

@Mapper
public interface LoginDAO {
	public PersonalInfoVO selectUser(PersonalInfoVO vo);
	
	public int updatePassword(Map<String, Object> map);

	//이메일 인증을 위해 사용자 정보 가져옴
	public PersonalInfoVO getUserInfo(int empno);
	public void setMailAuth(Map<String, Object> map);
	public int getMailAuth(Map<String, Object> map);
	
	//관리자 확인
	public String checkAdmin(PersonalInfoVO vo);
}
