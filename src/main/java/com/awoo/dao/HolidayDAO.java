 package com.awoo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.awoo.vo.EmployeeInfoVO;
import com.awoo.vo.HolidayVO;

@Mapper
public interface HolidayDAO {
	public List<HolidayVO> selectHoliday(HolidayVO vo);
	public void insertHoliday(HolidayVO vo);
	public List<String> distinctYear(HolidayVO vo);
	public EmployeeInfoVO getholidayCount(HolidayVO vo);
	public HolidayVO getDetailHoliday(HolidayVO vo);
	
	/*혜은*/
	public List<HolidayVO> selectH(Map<String, String> map); // 전체 리스트 + 상세 검색
	public List<HolidayVO> holidayY(); // 휴가 신청 연도(select - option)
	public void updateApproval(HolidayVO vo); // 휴가 승인, 반려
}
