package com.awoo.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.awoo.dao.MailDAO;
import com.awoo.service.MailService;
import com.awoo.vo.MailVO;
import com.awoo.vo.MessageVO;
import com.awoo.vo.PersonalInfoVO;

@Controller
public class MailController {
	
	@Autowired
	private MailService mailService;

	
	
	@GetMapping("SendEmail")
	public String sendEmail(@RequestParam("page") String page,
							@RequestParam("name") String name,
							@RequestParam("year") String sortingYear, 
							@RequestParam("month") String sortingMonth, 
							@SessionAttribute("personalInfoVO") PersonalInfoVO vo, Model model){
		
		model.addAttribute("sortingpage", page);
		model.addAttribute("sortingname", name);
		model.addAttribute("sortingYear", sortingYear);
		model.addAttribute("sortingMonth", sortingMonth);
		
		model.addAttribute("empno", vo.getEmpno());
		mailService.getMailList(model);
		return "message/sendEmail";
	}
	
	
	//DB작업이 필요한 만큼 DAO들 선언해야함
	
	//아이디와 이메일이 같으면 특정한 메일이 가게..
	@RequestMapping("/WebSendMail")
	public String WebSendMail(String[] email, 
							  String title, 
							  String content,
							  int showHide, 
							  MultipartFile[] attachment,
							  @SessionAttribute("personalInfoVO") PersonalInfoVO vo,
							  Model model
								) throws Exception {


		//google
		String addr = "awoogof@gmail.com";
		
		List<MailVO> mailList = new ArrayList<MailVO>(); 
		for (String one : email) {
			MailVO mvo = new MailVO();
			mvo.setSendFrom(addr);
			mvo.setEmpno(vo.getEmpno());
			mvo.setSendTo(one);
			mvo.setContent(content);
			mvo.setTitle(title);
//			mvo.setCountFiles(attachment.length);
			mvo.setAttachment(attachment);
			mvo.setShowHide(showHide);
			mailList.add(mvo);
		}
		
		
		mailService.sendEmail(mailList);
		
		
		return "message/successPage";
	}
	
	@ResponseBody   
	@PostMapping("/mail/detail")
	public MailVO MessageDetailReceive(@RequestBody Map<String, String> map,
										@SessionAttribute("personalInfoVO") PersonalInfoVO vo,
										Model model) {
		model.addAttribute("empno", vo.getEmpno());
		
		int id = Integer.parseInt((String)map.get("id"));
		model.addAttribute("id", id);
		
		return mailService.getDetailMail(model);
	}
}
