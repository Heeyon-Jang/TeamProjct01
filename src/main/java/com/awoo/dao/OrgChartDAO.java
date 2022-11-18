package com.awoo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.awoo.vo.HolidayVO;
import com.awoo.vo.InfoVO;

@Mapper
public interface OrgChartDAO {
	
	/*인사정보 : 부서,직책,이름 관련(상세 검색) */
	public List<InfoVO> selectOrgDetail(Map<String, String> map);
	
	/*휴가중 체크 : COUNT(empno) as count_date, empno*/
	public List<HolidayVO> checkHoliday();
}
