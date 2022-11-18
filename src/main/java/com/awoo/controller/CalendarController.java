package com.awoo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.awoo.service.CalendarService;
import com.awoo.vo.CalendarVO;
import com.awoo.vo.PersonalInfoVO;

@Controller
@RequestMapping("/calendar")
public class CalendarController {
	
	private CalendarService service;
	private int empno;
	private String ename;
	
	public CalendarController(CalendarService service) {
		super();
		this.service = service;
	}
	
//	첫 화면 로딩시 calendar 메서드로 들어와서 redirect
	@GetMapping
	public String calendar() {
		return "redirect:/calendar/selectData";
	}
	
//	extract에서 일정 데이터 가져오는 로직 수행후에 달력 화면으로 이동 
	@GetMapping("/selectData")
		public String selectData(@SessionAttribute("personalInfoVO") PersonalInfoVO vo,
								Model model) {
//		세션에 저장되어있는 사원번호(로그인한 사원)를 vo로 넘기기위해 private으로 저장
		empno = vo.getEmpno();
		ename = vo.getName();
//		자바스크립트의 sessionStorage에 넣기위해 model로 넘김
//		jsp에서 el태그로 sessionStorage에 삽입
		model.addAttribute("empno", vo.getEmpno());
		model.addAttribute("ename", vo.getName());
		service.selectDataMethod(model);
		return "calendar/calendar";
	}
	
//	비동기로 일자별 일정 출력하기 위한 데이터 추출
	@PostMapping("/restData")
	@ResponseBody
	public List<CalendarVO> restData(@RequestBody Map<String, String> map) {
		return service.restDataMethod(map);
	}
	
//	일정을 DB에 저장
	@PostMapping("/insertData")
	public String insertData(CalendarVO vo) {
//		세션에 저장되어있는 사원번호(로그인한 사원)를 vo로 넘김
		vo.setEmpno(empno);
		service.insertDataMethod(vo);
		return "redirect:/calendar/selectData";
	}
	
	@PostMapping("/updateDate/{checkId}/{checkRange}")
	public String updateDate(CalendarVO vo,
							@PathVariable("checkId") int id,
							@PathVariable("checkRange") String range){
		vo.setEmpno(empno);
		service.updateDateMethod(vo, id, range);
		return "redirect:/calendar/selectData";
	}
	
//	팝입 일정에서 x 표시 눌렀을때 삭제
	@GetMapping("/deleteData/{calId}")
	public String deleteData(CalendarVO vo) {
		service.deleteDataMethod(vo);
		return "redirect:/calendar/selectData";
	}
	
	
}












