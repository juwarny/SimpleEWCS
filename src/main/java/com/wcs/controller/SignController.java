package com.wcs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sign/")
public class SignController {

	@GetMapping("/signin")
	public void signIn() {

	}

	@GetMapping("/accessDenied")
	public void accessDenied() {

	}

	@GetMapping("/signout")
	public void signOut() {

	}
}
