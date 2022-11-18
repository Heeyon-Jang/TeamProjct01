package com.awoo.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.awoo.service.LoginService;
import com.awoo.service.MailService;
import com.awoo.vo.HolidayVO;
import com.awoo.vo.PersonalInfoVO;

@Controller
public class LoginController {

	private LoginService service;
	private MailService mservice;

	public LoginController(LoginService service, MailService mservice) {
		super();
		this.service = service;
		this.mservice = mservice;
	}
	
	//로그인(세션 저장)
	@PostMapping("/login")
	public String login(PersonalInfoVO vo, HttpSession session, HttpServletRequest request) {
		return service.isUser(vo, session, request);
	}	
	
	//메인페이지 이동
	@GetMapping("/login/home")
	public String postLogin() {
		return "redirect:/MoveToHome";
	}
	
	@RequestMapping("/login/changePassword")
	public String changePassword(@SessionAttribute("personalInfoVO") PersonalInfoVO vo, Model model) {
		service.getUserInfo(vo.getEmpno(), model);
		return "home/changePassword";
	}

	@RequestMapping("/login/afterAuthPage")
	public String afterAuthpage(@SessionAttribute("personalInfoVO") PersonalInfoVO vo, Model model) {
		service.getUserInfo(vo.getEmpno(), model);
		return "home/afterAuthPage";
	}
	
	//로그아웃(세션 초기화)
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";	
	}
	
	//초기 비밀번호 변경
	@PostMapping("/resetPassword")
	public String resetPW(@RequestParam Map<String, Object> map, @SessionAttribute("personalInfoVO") PersonalInfoVO vo) {
		map.put("empno", vo.getEmpno());
		service.resetPassword(map);
		return "redirect:/";
	}

	// 이메일 인증
	@ResponseBody   
	@PostMapping("/EmailAuth")
	public int EmailAuth(@RequestBody Map<String, Object> map, @SessionAttribute("personalInfoVO") PersonalInfoVO vo) {
		
		int min = 1000;
		int max = 9999;
		int random = (int) ((Math.random() * (max - min)) + min);
		
		map.put("random", random);
		
		mservice.sendAuthMail(map);
		service.setMailAuth(map);
	
		return 1;
	}
	
	@PostMapping("/EmailAuth/EmailKey")
	public String EmailKey(@RequestParam Map<String, Object> map, @SessionAttribute("personalInfoVO") PersonalInfoVO vo, Model model) {
		map.put("empno", vo.getEmpno());
		return service.getMailAuth(map);
	}
	
}
