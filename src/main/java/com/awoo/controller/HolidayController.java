package com.awoo.controller;

import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.awoo.service.EmployeeInfoService;
import com.awoo.service.HolidayService;
import com.awoo.vo.EmployeeInfoVO;
import com.awoo.vo.HolidayVO;
import com.awoo.vo.PersonalInfoVO;

@Controller
public class HolidayController {
	
	private HolidayService service;
	private EmployeeInfoService Eservice;
	
	public HolidayController(HolidayService service, EmployeeInfoService eservice) {
		super();
		this.service = service;
		Eservice = eservice;
	}
	
	@GetMapping("Holiday")
	public String moveToHoliday(@RequestParam("page") String page,
								@RequestParam("year") String year,
								@SessionAttribute("personalInfoVO") PersonalInfoVO vo,
								Model model) {
		model.addAttribute("page", page);
		//임시empno
		model.addAttribute("empno", vo.getEmpno());
		model.addAttribute("year", year);
		service.selectHoliday(model);
		return "holiday/holiday";
	}
	@PostMapping("ApplyHoliday")
	public String ApplyHoliday(
							   @RequestParam("leaveType") String leaveType,	
							   @RequestParam("leaveStartDate") String leaveStartDate,
							   @RequestParam("leaveEndDate") String leaveEndDate,
							   @RequestParam("content") String content,
							   @RequestParam("halfType") String halfType,
							   @SessionAttribute("personalInfoVO") PersonalInfoVO vo,
							   Model model) {
		if(leaveType.equals("연차")) {
			halfType = null;
		}
		
		model.addAttribute("leaveType", leaveType);
		model.addAttribute("leaveStartDate", leaveStartDate);
		model.addAttribute("leaveEndDate", leaveEndDate);
		model.addAttribute("content", content);
		model.addAttribute("userName", vo.getName());
		model.addAttribute("halfType", halfType);
		//임시empno
		model.addAttribute("empno", vo.getEmpno());
		
		try {
			service.insertHoliday(model);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return "redirect:/Holiday?page=1&&year=0";
	}
	
	// 휴가 상세보기
	@ResponseBody   
	@PostMapping("/holiday/detail")
	public HolidayVO holidaydetail(@RequestBody Map<String, String> map,
			 								@SessionAttribute("personalInfoVO") PersonalInfoVO vo,
											Model model) {
		
		int id = Integer.parseInt((String)map.get("id"));
		model.addAttribute("empno", vo.getEmpno());
		model.addAttribute("id", id);
		service.getDetailHoliday(model);
		
		return service.getDetailHoliday(model);
	}
	
	
	
	
/*혜은---------------------------------------------------------------------*/
	
	// 전체 리스트 + 상세 검색 (+페이징)
	@GetMapping("/holidayAdmin")
	public String holidayAdmin(Model model,@RequestParam("page") String page,@RequestParam Map<String,String> map) {
		model.addAttribute("page", page);
		service.selectH(model,map); // 전체 리스트 + 상세 검색
		Eservice.HEdepartment(model); // empno : 부서 식별
 		Eservice.department(model); // 부서 리스트
		 
		return "/admin/holidayAdmin";
	}
		
	// 승인
	@GetMapping("holiday/Ok/{id}")
	public String holidayOk(HolidayVO vo,@PathVariable("id") int id,
			@RequestParam("empno") int empno,@RequestParam("countDate") double countDate,@RequestParam("page") String page,Model model) {
		vo.setId(id);
		vo.setEmpno(empno);
		model.addAttribute("page", page);

		double totalH = Eservice.selectHolidayTotal(empno).getTotalHoliday(); // 연차 사용 계산을 위한 리스트에서 추출
		double usedH = Eservice.selectHolidayTotal(empno).getUsedHoliday(); // 연차 사용 계산을 위한 리스트에서 추출
		if(totalH >= (usedH+countDate)) {
			vo.setApproval("승인");
			Eservice.updateUsedHoliday(vo);	// 사용한 휴가 계산		
			service.updateApproval(vo);	// 휴가 승인, 반려
		} else if(totalH < (usedH+countDate)) {
			vo.setApproval("반려");
			vo.setRejectionReason("잔여 연차 : " + (totalH-usedH));
			service.updateApproval(vo);	// 휴가 승인, 반려
		}
		
		return "redirect:/holidayAdmin";
	}
		
	// 반려
		@GetMapping("/holiday/No/{id}")
		public String holidayNo(Model model,HolidayVO vo,@PathVariable("id") int id
				,@RequestParam("page") String page,@RequestParam("rejectionReason") String reject) {
			model.addAttribute("page", page);
			vo.setId(id);
			vo.setApproval("반려");
			vo.setRejectionReason(reject);
			service.updateApproval(vo); // 휴가 승인, 반려
			
			return "redirect:/holidayAdmin";
		}
		
		// 휴가 상세보기
		@ResponseBody   
		@PostMapping("/holiday/detailAdmin")
		public HolidayVO holidaydetailAdmin(@RequestBody Map<String, String> map,Model model) {
			
			int id = Integer.parseInt((String)map.get("id"));
			int empno = Integer.parseInt((String)map.get("empno"));

			model.addAttribute("empno", empno);
			model.addAttribute("id", id);
			service.getDetailHoliday(model);
			
			return service.getDetailHoliday(model);
		}
}
