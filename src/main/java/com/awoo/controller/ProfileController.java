package com.awoo.controller;

import java.io.IOException;
import java.nio.file.Paths;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.awoo.service.EmployeeInfoService;
import com.awoo.service.PersonalInfoService;
import com.awoo.service.UploadfilesService;
import com.awoo.vo.EmployeeInfoVO;
import com.awoo.vo.InfoVO;
import com.awoo.vo.PersonalInfoVO;
import com.awoo.vo.UploadfilesVO;

@Controller
@RequestMapping("/profile")
public class ProfileController {

	private PersonalInfoService Pservice;
	private EmployeeInfoService Eservice;
	private UploadfilesService Uservice;
	private int empno;
	
	public ProfileController(PersonalInfoService pservice,
							EmployeeInfoService eservice,
							UploadfilesService uservice) {
		super();
		Pservice = pservice;
		Eservice = eservice;
		Uservice = uservice;
	}
	
	// 내 정보 접속시 값 자동 입력
	@GetMapping
	public String profile(@SessionAttribute("personalInfoVO") PersonalInfoVO pVO,
							Model model, InfoVO infoVO, UploadfilesVO uVO) {
		int id = pVO.getId();
		empno = pVO.getEmpno();
		
		infoVO.setId(id);
		Pservice.selectInfo(infoVO, model); // 인사 정보
		
		uVO.setOwnerId(empno);
		Uservice.selectFile(uVO, model); // 사원 사진 정보
		
		Eservice.selectPerPro(empno, model);
		Pservice.selectPerPro(empno, model);
		
//		model.addAttribute("updateCheck", check);
		
		return "profile/profile";
	}
	
	// 내 정보 접속시 비밀번호 확인
	@PostMapping("/passCheck")
	@ResponseBody
	public int passCheck(@RequestBody Map<String, String> map) {
		return Pservice.passCheckMethod(map);
	}
	
	// 수정하기
	@PostMapping("/updateData")
	public String updateDetail(
			PersonalInfoVO pVO,EmployeeInfoVO eVO,@RequestParam("page") String page,
			HttpServletRequest request,Model model,@RequestParam("totalH") int totalH,
			@RequestParam("proimg") MultipartFile[] files,
			UploadfilesVO uVO)throws IllegalStateException, IOException {
		model.addAttribute("page", page);
		eVO.setTotalHoliday(totalH);
		Eservice.updateE(pVO,eVO,request); // 인사정보 수정
		for (MultipartFile file : files) { 
			if(!file.getOriginalFilename().isEmpty()){ 
				String ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
				file.transferTo(Paths.get("C:/sample/"+eVO.getEmpno()+"."+ext));
				uVO.setFileName(String.valueOf(eVO.getEmpno())+"."+ext); 
				uVO.setOwnerId(eVO.getEmpno());
				Uservice.updateFile(uVO); // 사원사진 등록
				} else { 
					System.out.println("사진을 변경하지 않았습니다."); 
				} 
			}	
		try {
		    Thread.sleep(1000); // 단위 ms
		} catch (InterruptedException ie) {
		    Thread.currentThread().interrupt();
		}
//		String updateCheck = "1";
//		session.setAttribute("check", check);
//		session.setAttribute("check", updateCheck);
		return "redirect:/profile";
	}
}
