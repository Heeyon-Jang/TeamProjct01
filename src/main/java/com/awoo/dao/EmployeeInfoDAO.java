package com.awoo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.awoo.vo.EmployeeInfoVO;
import com.awoo.vo.HolidayVO;
import com.awoo.vo.InfoVO;
import com.awoo.vo.PositionDepartmentVO;

@Mapper
public interface EmployeeInfoDAO {
	public void insertDataE(EmployeeInfoVO vo); // 신규 직원 등록
	
	public void updateE(EmployeeInfoVO vo); // 인사정보 수정

	public List<EmployeeInfoVO> selectEmpno(); // 사원번호 지정(설정)
	/*리스트(직원 현황)*/
	public List<InfoVO> selectInfo1();
	/*부서(직원 현황)*/
	public List<InfoVO> edepartment();

	/*연관검색*/
	public List<InfoVO> AssociatedSearch(InfoVO vo);
	
	/*휴가*/
	public void updateUsedHoliday(HolidayVO vo); //사용한 휴가 계산

	public List<EmployeeInfoVO> selectHolidayTotal(int empno); // 연차 사용 계산을 위한 리스트

	public List<EmployeeInfoVO> HEdepartment(); // empno : 부서 식별
	
	/*부서 관리*/
	public List<PositionDepartmentVO> department(); // 부서 리스트
	public List<PositionDepartmentVO> countDepartment(); // 부서 사원수
	public void insertDepartment(PositionDepartmentVO vo); // 부서 추가
	public void updateDepartment(PositionDepartmentVO vo); // 부서 수정
	public void updateDepartment2(PositionDepartmentVO vo); // 부서 수정 및 삭제 후 해당 직원 재배치
	public void deleteDepartment(PositionDepartmentVO vo); // 부서 삭제
	
	/*직책 관리*/
	public List<PositionDepartmentVO> position(); // 직책 리스트
	public List<PositionDepartmentVO> countPosition(); // 직책 사원수
	public void insertPosition(PositionDepartmentVO vo); // 직책 추가
	public void updatePosition(PositionDepartmentVO vo); // 직책 수정
	public void updatePosition2(PositionDepartmentVO vo); // 직책 수정 및 삭제 후 해당 직원 재배치
	public void deletePosition(PositionDepartmentVO vo); // 직책 삭제
	
	
	/*내 정보*/
	public EmployeeInfoVO selectEmpPro(int empno);
}

