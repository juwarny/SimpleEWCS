package com.wcs.controller;

import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wcs.domain.ChattingRoom;
import com.wcs.repository.ChattingRoomRepository;
import com.wcs.vo.ChPageVO;
import com.wcs.vo.PageMaker;

import lombok.extern.java.Log;

@Controller
@RequestMapping("/chrooms/")
@Log
public class ChatRoomController {

	@Autowired
	private ChattingRoomRepository chrepo;
	


	@GetMapping("/chregister")
	public void registerGET(@ModelAttribute("vo")ChattingRoom vo ){
		log.info("register get");
		vo.setTitle("샘플 채팅방 제목입니다....");
	}
	
	@PostMapping("/chregister")
	public String registerPOST(@ModelAttribute("vo")ChattingRoom vo, RedirectAttributes rttr){
		
		log.info("chregister post");
		log.info("" + vo);
		chrepo.save(vo);
		
		rttr.addFlashAttribute("msg", "success");
		
		return "redirect:/chrooms/chlist";
	}
	
	@GetMapping("/chroom")
	public void view(Long chrno, @ModelAttribute("pageVO") ChPageVO vo, Model model){
		
		log.info("chrno: "+ chrno);
		
		Optional.ofNullable(chrepo.findOne(chrno)).ifPresent(chroom -> model.addAttribute("vo", chroom));
		
	}
	
	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@GetMapping("/chmodify")
	public void modify(Long chrno, @ModelAttribute("pageVO") ChPageVO vo, Model model){
		
		log.info("MODIFY chrno: "+ chrno);
		
		Optional.ofNullable(chrepo.findOne(chrno)).ifPresent(chroom -> model.addAttribute("vo", chroom));
	}
	
	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@PostMapping("/chmodify")
	public String modifyPost(ChattingRoom chroom, @ModelAttribute("pageVO") ChPageVO vo, RedirectAttributes rttr ){
		
		log.info("Modify chroom: " + chroom);
		
		Optional.ofNullable(chrepo.findOne(chroom.getChrno())).ifPresent( origin ->{
		 
			origin.setTitle(chroom.getTitle());
			
			chrepo.save(origin);
			rttr.addFlashAttribute("msg", "success");
			rttr.addAttribute("chrno", origin.getChrno());
		});
		
		//페이징과 검색했던 결과로 이동하는 경우 
		rttr.addAttribute("page", vo.getPage());
		rttr.addAttribute("size", vo.getSize());
		rttr.addAttribute("keyword", vo.getKeyword());

		return "redirect:/chrooms/chroom";
	}
	
	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@PostMapping("/delete")
	public String delete(Long chrno, ChPageVO vo, RedirectAttributes rttr ){
		
		log.info("DELETE BNO: " + chrno);
		
		chrepo.delete(chrno);
		
		rttr.addFlashAttribute("msg", "success");

		//페이징과 검색했던 결과로 이동하는 경우 
		rttr.addAttribute("page", vo.getPage());
		rttr.addAttribute("size", vo.getSize());
		rttr.addAttribute("keyword", vo.getKeyword());

		return "redirect:/chrooms/chlist";
	}
	
	
	@GetMapping("/chlist")
	@Transactional
	public void list(@ModelAttribute("pageVO") ChPageVO vo, Model model){
		
		Pageable page = vo.makePageable(0, "chrno");
		
		Page<Object[]> result = chrepo.getChattingRoomPage(vo.getKeyword(), page);
		
		log.info(""+ page);
		log.info(""+result);
		log.info("TOTAL PAGE NUMBER: " + result.getTotalPages());
		model.addAttribute("result", new PageMaker<>(result, page));
				
	}

}