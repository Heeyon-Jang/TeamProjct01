package com.awoo.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.awoo.dao.LoginDAO;
import com.awoo.vo.PersonalInfoVO;

@Service
public class LoginService {
	
	LoginDAO loginDao;
	
	public LoginService(LoginDAO loginDao) {
		super();
		this.loginDao = loginDao;
	}

	//로그인
	public String isUser(PersonalInfoVO vo, HttpSession session, HttpServletRequest request) {
		String path = "";
		if(loginDao.selectUser(vo) != null) {
			//유저 정보를 세션에 넣기 전 세션 초기화
			session.invalidate();
			//초기화한 후애 다시 세션 불러와야 함
			session = request.getSession();
			//세션에 담기
			session.setAttribute("personalInfoVO", loginDao.selectUser(vo));
			//관리자 확인
			session.setAttribute("checkAdmin", loginDao.checkAdmin(vo));
			//초기 비밀번호(abc1)일경우 비밀번호 변경 페이지로 이동
			if(loginDao.selectUser(vo).getPassword().equals("abc1")){
				path ="redirect:/login/changePassword";				
			}else {
				path = "redirect:/login/home";
			}
		}else {
			//세션을 초기화하고 로그인 창으로 돌려보냄
			session.invalidate();
			path = "LogIn";
		}
		return path;
	}
	
	//초기 비밀번호 변경
	public void resetPassword(Map<String, Object> map) {
		loginDao.updatePassword(map);	
	}
	
	// 이메일 인증을 위한 데이터 가져오기
	public void getUserInfo(int empno, Model model) {
		model.addAttribute("userInfo", loginDao.getUserInfo(empno));
	}
	
	public void setMailAuth(Map<String, Object> map) {
		loginDao.setMailAuth(map);
	}
	public String getMailAuth(Map<String, Object> map) {
		String path = "";
		if(loginDao.getMailAuth(map) == 1) {
			path = "redirect:/login/afterAuthPage";
		}else {
			path ="redirect:/login/changePassword";			
		}
		return path;
	}
}
