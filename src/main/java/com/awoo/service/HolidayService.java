package com.awoo.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.awoo.dao.EmployeeInfoDAO;
import com.awoo.dao.HolidayDAO;
import com.awoo.vo.EmployeeInfoVO;
import com.awoo.vo.HolidayVO;

@Service
public class HolidayService {
	
	private HolidayDAO dao;
//	private EmployeeInfoDAO Edao;
	
	public HolidayService(HolidayDAO dao, EmployeeInfoDAO edao) {
		super();
		this.dao = dao;
//		Edao = edao;
	}
	
	public void selectHoliday(Model model){
		int empno = (int)model.getAttribute("empno");
		String year = (String)model.getAttribute("year");
		if(year.equals("0") || year == "0") {
			year = null;
		}
		HolidayVO vo = new HolidayVO();
		vo.setEmpno(empno);
		vo.setHwriteDate(year);
		
		model.addAttribute("holidayList", dao.selectHoliday(vo));
		model.addAttribute("distinctYear", dao.distinctYear(vo)); 
		model.addAttribute("countHoliday", dao.getholidayCount(vo));
	}
	public void insertHoliday(Model model) throws ParseException {
		String leaveType = (String)model.getAttribute("leaveType");
		String leaveStartDate = (String)model.getAttribute("leaveStartDate");
		String leaveEndDate = (String)model.getAttribute("leaveEndDate");
		String content = (String)model.getAttribute("content");
		String halfType = (String)model.getAttribute("halfType");
		String userName = (String)model.getAttribute("userName");
		int empno = (int)model.getAttribute("empno");
		
		double diff;
		
		if(leaveType.equals("월차") || !leaveType.equals("반차")) {
			Date format1 = new SimpleDateFormat("yyyy-MM-dd").parse(leaveStartDate);
	        Date format2 = new SimpleDateFormat("yyyy-MM-dd").parse(leaveEndDate);
	        
	        long diffSec = (format1.getTime() - format2.getTime()) / 1000; //초 차이
	        long diffDays = ((diffSec / (24*60*60))*-1)+1; //일자수 차이
	        
	        diff = Long.valueOf(diffDays).intValue();
		}else {
			//반차로 endDate가 없을 때 1
			leaveEndDate = leaveStartDate;
			diff = 0.5;
		}
        
		HolidayVO vo = new HolidayVO();
		vo.setHuserName(userName);
		vo.setHtype(leaveType);
		vo.setHstartDate(leaveStartDate);
		vo.setHendDate(leaveEndDate);
		vo.setHcontent(content);
		vo.setHalfDay(halfType);
		vo.setCountDate(diff);
		vo.setApproval("요청중");
		vo.setEmpno(empno);
		vo.setApprovalDate(null);
		vo.setRejectionReason(null);
		dao.insertHoliday(vo);
	}
	
	public HolidayVO getDetailHoliday(Model model) {
		HolidayVO vo = new HolidayVO();
		int empno = (int)model.getAttribute("empno");
		int id = (int)model.getAttribute("id");
		vo.setEmpno(empno);
		vo.setId(id);
		
		return dao.getDetailHoliday(vo);
	}
	
	/*혜은---------------------------------------------*/

	// 전체 리스트 + 상세 검색
	public void selectH(Model model,Map<String,String> map) {
		model.addAttribute("list",dao.selectH(map)); // 전체 리스트 + 상세 검색
		model.addAttribute("year",dao.holidayY()); // 휴가 신청 연도 리스트
	}
	// 휴가 승인,반려
	public void updateApproval(HolidayVO vo) {
		dao.updateApproval(vo);
	}
}
