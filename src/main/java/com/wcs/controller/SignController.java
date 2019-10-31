package com.wcs.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SignController {
	
	@RequestMapping(value = "/signin", method = RequestMethod.GET)
	public String loginPage(HttpServletRequest request) {
	    String referrer = request.getHeader("Referer");
	    request.getSession().setAttribute("prevPage", referrer);
	    return "signin";
	}
	

	@GetMapping("/accessDenied")
	public void accessDenied() {

	}

	@GetMapping("/signout")
	public void signOut() {

	}
}
