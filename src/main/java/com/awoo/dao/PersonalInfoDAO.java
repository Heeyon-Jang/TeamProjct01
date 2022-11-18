    package com.awoo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.awoo.vo.InfoVO;
import com.awoo.vo.PersonalInfoVO;

@Mapper
public interface PersonalInfoDAO {
	
	// 인사정보 : 신규직원 등록
	public void insertDataP(PersonalInfoVO vo);
	// 인사정보 : 수정하기
	public void updateP(PersonalInfoVO vo);
	// 인사정보 : 상세보기
	public List<InfoVO> selectInfo(InfoVO vo);
	// 전체 리스트 + 상세검색
	public List<InfoVO> selectDetail(Map<String,String> map);
	

	// 내 정보
	public PersonalInfoVO selectPerPro(int empno);	
	// 내 정보
	public int passCheck(Map<String,String> map);
}

