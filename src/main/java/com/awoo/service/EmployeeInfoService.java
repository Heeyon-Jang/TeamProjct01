package com.awoo.service;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.awoo.dao.EmployeeInfoDAO;
import com.awoo.vo.EmployeeInfoVO;
import com.awoo.vo.HolidayVO;
import com.awoo.vo.InfoVO;
import com.awoo.vo.PersonalInfoVO;
import com.awoo.vo.PositionDepartmentVO;

@Service
public class EmployeeInfoService {
	
	private EmployeeInfoDAO dao;
	private PersonalInfoService service;
	
	public EmployeeInfoService(EmployeeInfoDAO dao, PersonalInfoService service) {
		super();
		this.dao = dao;
		this.service = service;
	}	
	// 사원번호 지정(설정)
	public void selectEmpno(Model model,HttpServletRequest request){
		int j = 1;
		
		DecimalFormat df = new DecimalFormat("00");
		String em = 
				LocalDate.now().format(DateTimeFormatter.ofPattern("yy")) +
				LocalDate.now().format(DateTimeFormatter.ofPattern("MM")) +
				String.valueOf(df.format(j)); 
		
		for (int i = 0; i < dao.selectEmpno().size(); i++) {
			if(Integer.parseInt(em) == dao.selectEmpno().get(i).getEmpno()) {
				j++;
				em = LocalDate.now().format(DateTimeFormatter.ofPattern("yy")) +
					 LocalDate.now().format(DateTimeFormatter.ofPattern("MM")) +
					 String.valueOf(df.format(j)); 
			}
		}
		
		
		model.addAttribute("empno", em);
	}

	// 신규 직원 등록
	public void insertDataE(PersonalInfoVO vop,EmployeeInfoVO vo, HttpServletRequest request) {
		
		int empno = Integer.parseInt(request.getParameter("empno"));		
		vo.setEmpno(empno);
		
		dao.insertDataE(vo);
		service.insertDataP(request,vop); // 인사정보 : 신규직원 등록 (personalInfo)
	}

	// 인사정보 수정
	public void updateE(PersonalInfoVO vop,EmployeeInfoVO vo, HttpServletRequest request) {
		dao.updateE(vo);
		service.updateP(request,vop); // 인사정보 (personalInfo 수정)
	}
	
	/* 연관검색 ------------------------------------------------------------------------*/
		
		public List<InfoVO> AssociatedSearch(InfoVO vo,Model model){
			String name = (String)model.getAttribute("name");
			vo.setName(name);
			model.addAttribute("list",dao.AssociatedSearch(vo));
			return dao.AssociatedSearch(vo);
		}
	
	/*휴가-------------------------------------------------------------------------*/
	/*사용한 휴가 계산*/
	public void updateUsedHoliday(HolidayVO vo) {
		dao.updateUsedHoliday(vo);
	}
	/*연차 사용 계산을 위한 리스트*/
	public EmployeeInfoVO selectHolidayTotal(int empno){
		
		EmployeeInfoVO list = new EmployeeInfoVO();
		
		for (int i = 0; i < dao.selectHolidayTotal(empno).size() ; i++) {			
			if (empno == dao.selectHolidayTotal(empno).get(i).getEmpno()) {
				list = dao.selectHolidayTotal(empno).get(i);
			}
		}
		return list;
	}
	
	/*empno : 부서 식별*/
	public void HEdepartment(Model model) {
		 model.addAttribute("depart",dao.HEdepartment());
	}
	
	/* 부서관리 -----------------------------------------------------------------*/
	// 부서 리스트
	public void department(Model model){
		model.addAttribute("listD",dao.department()); // 부서 리스트
		model.addAttribute("count",dao.countDepartment()); // 부서 사원수
	}
	// 부서 수정
	public void updateDepartment(PositionDepartmentVO vo) {
		dao.updateDepartment2(vo); //부서 수정 및 삭제 후 해당 직원 재배치
		dao.updateDepartment(vo); // 부서 수정
	}
	// 부서 삭제
	public void deleteDepartment(PositionDepartmentVO vo) {
		dao.updateDepartment2(vo); // 부서 수정 및 삭제 후 해당 직원 재배치
		dao.deleteDepartment(vo); // 부서 삭제
	}
    // 부서 추가
	public void insertDepartment(PositionDepartmentVO vo) {
		dao.insertDepartment(vo);
	}
	
	/* 직책관리 -----------------------------------------------------------------*/
	// 직책 리스트 
	public void position(Model model){
		model.addAttribute("listP",dao.position()); // 직책 리스트
		model.addAttribute("count",dao.countPosition()); // 직책 사원수
	}
	// 직책 수정
	public void updatePosition(PositionDepartmentVO vo) {
		dao.updatePosition2(vo); // 직책 수정 및 삭제 후 해당 직원 재배치
		dao.updatePosition(vo); // 직책 수정
	}
	// 직책 삭제
	public void deletePosition(PositionDepartmentVO vo) {
		dao.updatePosition2(vo); // 직책 수정 및 삭제 후 해당 직원 재배치
		dao.deletePosition(vo); // 직책 삭제
	}
	// 직책 추가
	public void insertPosition(PositionDepartmentVO vo) {
		dao.insertPosition(vo);
	}

	
	/* 내 정보 -----------------------------------------------------------------*/
	public void selectPerPro(int empno, Model model) {
		model.addAttribute("eVO", dao.selectEmpPro(empno));
	}
}
