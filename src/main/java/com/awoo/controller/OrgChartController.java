package com.awoo.controller;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.awoo.service.EmployeeInfoService;
import com.awoo.service.MessageService;
import com.awoo.service.OrgChartService;
import com.awoo.service.PersonalInfoService;
import com.awoo.service.UploadfilesService;
import com.awoo.vo.BBSCommentVO;
import com.awoo.vo.InfoVO;
import com.awoo.vo.MessageVO;
import com.awoo.vo.PersonalInfoVO;
import com.awoo.vo.UploadfilesVO;

@Controller
public class OrgChartController {
	
	private OrgChartService service;
	private MessageService Mservice;
	private EmployeeInfoService Eservice;
	private UploadfilesService Uservice;
	
		public OrgChartController(OrgChartService service, MessageService mservice, EmployeeInfoService eservice,
			UploadfilesService uservice) {
		super();
		this.service = service;
		Mservice = mservice;
		Eservice = eservice;
		Uservice = uservice;
	}

		// 전체 리스트 + 상세검색 (+페이징)
		@GetMapping("/orgChart")
		public String OrgChart1(Model model,@RequestParam("page") String page,@RequestParam Map<String,String> map,UploadfilesVO uvo) {
			model.addAttribute("page", page);
			service.selectOrgDetail(model,map); /*tab1 페이지(직원 현황) + tab2 페이지(부서별 안내) */
			service.checkHoliday(model); // 휴가중 체크
			Eservice.department(model); // 부서 리스트
			Eservice.position(model); // 직책 리스트
			Uservice.selectFile(uvo, model); // 사원 사진 (사원번호 식별)
			return "/orgChart/OrgChart";
		}
		
		// 쪽지 보내기(비동기)
		@ResponseBody
		@PostMapping("/MessageInsert")
		public ResponseEntity<Map<String, String>> insert(@SessionAttribute("personalInfoVO") PersonalInfoVO vo,MessageVO mvo,
				@RequestParam("page") String page,Model model,@RequestBody Map<String, String> map) {
			
			model.addAttribute("page", page);
			
			int mreceiverId = Integer.parseInt((String) map.get("mreceiverId"));
			String mcontent = (String) map.get("mcontent");
			mvo.setMcontent(mcontent);
			mvo.setMreceiverId(mreceiverId);
			mvo.setMownerId(vo.getEmpno());
			
			Mservice.sendMessage(mvo);
			
			ResponseEntity<Map<String, String>> entity = new ResponseEntity<Map<String, String>>(map , HttpStatus.OK);
			return entity;
		}
	
}
