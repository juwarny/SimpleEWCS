package com.wcs.controller;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wcs.domain.Member;
import com.wcs.repository.MemberRepository;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/member/")
public class MemberController {
  
  @Autowired
  PasswordEncoder pwEncoder;
  
  @Autowired
  MemberRepository repo;

  @GetMapping("/signup")
  public void join(){
    
  }

  @Transactional
  @PostMapping("/signup")
  public String joinPost(@ModelAttribute("member") Member member, RedirectAttributes rttr) {

    log.info("MEMBER: " + member);

    String encryptPw = pwEncoder.encode(member.getUpw());

    log.info("en: " + encryptPw);

    member.setUpw(encryptPw);

    repo.save(member);
    
    rttr.addAttribute("member", member);
    
    return "redirect:/member/signUpResult";
  }
  
  @GetMapping("/signUpResult")
  public void signResult(@ModelAttribute("member") Member member){
    
  }
}
