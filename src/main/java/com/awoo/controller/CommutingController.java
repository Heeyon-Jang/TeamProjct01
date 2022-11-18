package com.awoo.controller;

import java.net.http.HttpRequest;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.awoo.service.CommutingService;
import com.awoo.vo.CommutingVO;
import com.awoo.vo.PersonalInfoVO;

@Controller
public class CommutingController {
	
	private CommutingService service;
	
	public CommutingController(CommutingService service) {
		super();
		this.service = service;
	}


	@GetMapping("/Commuting")
	public String moveToCommuting(@RequestParam("page") String page,
								  @RequestParam("year") String sortingYear, 
								  @RequestParam("month") String sortingMonth,
								  @SessionAttribute("personalInfoVO") PersonalInfoVO vo,
								  Model model) {
		model.addAttribute("page", page);
		model.addAttribute("sortingYear", sortingYear);
		model.addAttribute("sortingMonth", sortingMonth);
		//임시empno
		model.addAttribute("empno", vo.getEmpno());
		service.getDefaultData(model);		
		return "commuting/commuting";
	}
	
}

