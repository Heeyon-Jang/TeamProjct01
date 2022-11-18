package com.awoo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.awoo.vo.PersonalInfoVO;



@Controller
public class HomeController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String LogIn(PersonalInfoVO vo, Model model) {
		return "LogIn";
	}

}

