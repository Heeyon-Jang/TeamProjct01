package com.awoo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.awoo.vo.CalendarVO;

@Mapper
public interface CalendarDAO {
//	일정 조회
	public List<CalendarVO> selectSchedule(int empno);
//	비동기 일정 조회
	public List<CalendarVO> selectRestData(Map<String, String> map);
//	일정 범위 여부 조회
	public int selectRange(int id);
//	일정 등록
	public int insertSchedule(CalendarVO vo);
//	일정 수정
	public void updateSchedule(CalendarVO vo);
//	일정 삭제
	public void deleteSchedule(int id);
	
}
