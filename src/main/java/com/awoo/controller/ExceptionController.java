package com.awoo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ExceptionController {
	@GetMapping("/error404")
	public String error404() {
		return "error/404";
	}
}
