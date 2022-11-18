package com.awoo.controller;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.awoo.service.MessageService;
import com.awoo.vo.HolidayVO;
import com.awoo.vo.MailVO;
import com.awoo.vo.MessageVO;
import com.awoo.vo.PersonalInfoVO;



@Controller
//@RequestMapping("/message")
public class MessageController {

	private MessageService service;

	public MessageController(MessageService service) {
		super();
		this.service = service;
	}


	// 내가 받은 쪽지 페이지
	@GetMapping("ReceivedMessage")
	public String ReceivedMessage(@RequestParam("page") String page,
								  @RequestParam("name") String name,
								  @RequestParam("year") String sortingYear, 
								  @RequestParam("month") String sortingMonth,
								  @SessionAttribute("personalInfoVO") PersonalInfoVO vo,
								  Model model){  

		model.addAttribute("sortingpage", page);
		model.addAttribute("sortingname", name);
		model.addAttribute("sortingYear", sortingYear);
		model.addAttribute("sortingMonth", sortingMonth);
		
		model.addAttribute("name", vo.getName());
		model.addAttribute("empno", vo.getEmpno());
		service.getRMessageList(model);
		return "message/receivedMessage";
	}
	// 내가 보낸 페이지
	@GetMapping("SendMessage")
	public String SendMessage(@RequestParam("page") String page,
							  @RequestParam("name") String name,
							  @RequestParam("year") String sortingYear, 
							  @RequestParam("month") String sortingMonth,
							  @SessionAttribute("personalInfoVO") PersonalInfoVO vo,
							  Model model){ 
		
		model.addAttribute("sortingpage", page);
		model.addAttribute("sortingname", name);
		model.addAttribute("sortingYear", sortingYear);
		model.addAttribute("sortingMonth", sortingMonth);
		
		model.addAttribute("empno", vo.getEmpno());
		service.getSMessageList(model);
		return "message/sendMessage";
	}
	
	
	@PostMapping("sendMessage/sendMessage")
	public String insertMessage(MessageVO mvo, 
								Model model,  
								@SessionAttribute("personalInfoVO") PersonalInfoVO vo){
		
		model.addAttribute("empno", vo.getEmpno());
		mvo.setMownerId(vo.getEmpno());
		service.sendMessage(mvo);
		return "redirect:/ReceivedMessage?page=1&&name=0&&year=0&&month=0";
	}
	
	@GetMapping("sendMessage/deleteMessage")
	@ResponseBody
	public String deleteMessage(Model model, 
								@PathVariable("checkbox") int[] checkbox,
								@RequestParam("checkbox") int[] checkboxes) {

		return "redirect:/ReceivedMessage?page=1&&name=0&&year=0&&month=0";
	}
	@ResponseBody   
	@PostMapping("sendMessage/deleteMessage")
	public ResponseEntity<String> holidaydetailAdmin(@RequestBody int[] checked) {
		ResponseEntity<String> response = null;
		service.deleteMessage(checked);
		return response;
	
	}
	
	
	@ResponseBody   
	@PostMapping("/message/detail/receive")
	public MessageVO MessageDetailReceive(@RequestBody Map<String, String> map,
										  @SessionAttribute("personalInfoVO") PersonalInfoVO vo,
										  Model model) {
		model.addAttribute("empno", vo.getEmpno());
		
		int id = Integer.parseInt((String)map.get("id"));
		model.addAttribute("id", id);
		
		return service.getDetailMessageReceive(model);
	}
	
	@ResponseBody   
	@PostMapping("/message/detail/send")
	public MessageVO MessageDetailSend(@RequestBody Map<String, String> map,
									   Model model) {
		
		int id = Integer.parseInt((String)map.get("id"));
		model.addAttribute("id", id);
		
		return service.getDetailMessageSend(model);
	}
	
	
	
	
	
	
	
	
	
//	@RequestMapping("MailSuccess")
//	public String mailSuccess(Model model) {
//		System.out.println("여기로 오니?");
//		
//		List<MailVO> mvo = (List<MailVO>)model.getAttribute("mailList");
//		System.out.println(mvo.get(0).getSendTo());
//		System.out.println("--------------------------");
//		
//		return "message/successPage";
//	}

//	@RequestMapping("loginOK")
//	public String loginOK() {
//		System.out.println("여기는 loginOK cont");
//		return "message/successPage";
//	}
	
//	@RequestMapping("loginFail")
//	public String loginFail() {
//		System.out.println("여기는 loginFail cont");
//		return "message/failPage";
//	}
	
//	@PostMapping("updateEmail")
//	public String updateGmail(Model model,
//							HttpServletRequest request,
//							  @SessionAttribute("personalInfoVO") PersonalInfoVO vo) {
//		System.out.println(request.getParameter("email_id"));
//		System.out.println(request.getParameter("email_password"));
//		System.out.println(model.getAttribute("email_id"));
//		System.out.println(model.getAttribute("email_password"));
//		model.addAttribute("empno", vo.getEmpno());
//		model.addAttribute("email_id", request.getParameter("email_id"));
//		model.addAttribute("email_password", request.getParameter("email_password"));
//		service.updateEmail(model);
//		return "redirect:/SendEmail";
//	}
	
	
	
	
//	@RequestMapping("preWeb")
//	public String LoginFail(Htto) {
//			System.out.println("여기는 로그인 프리웸");
//		
//			return "forward:/WebSendMail";
//	}
//	@RequestMapping("checkIdController")
//	public String LoginOK() {
//		return "message/sendEmail";
//	}
	
	
	
	//지영---------------------------------------------
//	@GetMapping
//	public String index(Model model) {
//		service.getList(model);
//		return "message/sendMessage";
//	}
//
//
//
//	//게시판 출력
//	@GetMapping("result1")
//	public String result1(MessageVO vo) {
//		service.setData1(vo);
//		return "redirect:/message";
//	}
//
//	//쪽지 보내기 페이지로 이동
//	@GetMapping("result2")
//	public String result(Model model) {
//		service.getList(model);
//		return "/message/result2";
//	}
//
//	//보낸 쪽지함 페이지로 이동
//	@GetMapping("message2")
//	public String message2(Model model) {
//		service.getList(model);
//		return "/message/message2";
//	}
//
//	//	//쪽지 보내기 내용
//	//	@PostMapping("result2")
//	//	public String result2(MessageVO vo) {
//	//		service.setData1(vo);
//	//		return "redirect:/message";
//	//	}
//
//
//	//
//	//	//보낸쪽지함 아이디 입력 버전 삭제(성공)
//	//	@GetMapping("result8")
//	//	public String result8(MessageVO vo) {
//	//		service.deleteData2(vo);
//	//		return "redirect:/message";
//	//	}
//	//
//
//	//내용 쪽지함에서 원래 메세지함으로 이동
//	@GetMapping("/message1")
//	public String message(Model model) {
//		service.getList(model);
//		return "message/message1";
//	}
//
//	//상세 게시판 보기 - 받은 쪽지함1
//	@GetMapping("/messageValue/{id}")
//	public String getBBSItem(MessageVO vo, Model model, @PathVariable("id")String id) {
//		//		System.out.println("여기오니");
//		//		오류시 콘솔 찍는 법		
//		//		System.out.println(vo.getId());
//		if(vo != null ) {
//			service.MessageContent(model, id);
//			return "message/content";
//		}else {
//			return "redirect:/message/message1";		
//		}
//	}
//
//	//상세 게시판 보기 - 받은 쪽지함2
//	@GetMapping("/messageValue2/{id}")
//	public String getBBSItem2(MessageVO vo, Model model, @PathVariable("id")String id) {
//		if(vo != null ) {
//			service.MessageContent(model, id);
//			return "message/content2";
//		}else {
//			return "redirect:/message/message2";		
//		}
//	}
//
//	//받은 쪽지함- 체크박스 삭제
//	@PostMapping("/delete")
//	@ResponseBody
//	public ResponseEntity<String> deleteItems(@RequestBody int[] ids){
//
//		//		for (String string : idArr) {
//		//			System.out.println(string);
//		//		}
//		ResponseEntity<String> response = null;
//
//		if(service.deleteData1(ids)) {
//			response = new ResponseEntity<String>("ok", HttpStatus.OK);
//		}else {
//			response = new ResponseEntity<String>("err", HttpStatus.NOT_FOUND);
//		}
//
//		return response;
//
//	}
//
//	//받은 쪽지함- 체크박스 삭제
//	@PostMapping("/delete2")
//	@ResponseBody
//	public ResponseEntity<String> deleteItems2(@RequestBody int[] idss){
//
//		//		for (String string : idArr) {
//		//			System.out.println(string);
//		//		}
//		ResponseEntity<String> response = null;
//
//		if(service.deleteData2(idss)) {
//			response = new ResponseEntity<String>("ok", HttpStatus.OK);
//		}else {
//			response = new ResponseEntity<String>("err", HttpStatus.NOT_FOUND);
//		}
//
//		return response;}
//
//
//
//
//	@PostMapping("/insert/{mowner}")
//	public String insert(@PathVariable("mowner")String mowner,MessageVO vo) {
//
//		//		오류시 콘솔 찍는 법		
//		//		System.out.println(vo.getId());
//		vo.setMowner(mowner);
//		service.insert(vo);
//		return "redirect:/message/message2";		
//
//	}
}



