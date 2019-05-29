package com.wcs.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
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

import com.wcs.domain.Board;
import com.wcs.domain.Category;
import com.wcs.domain.Member;
import com.wcs.repository.BoardRepository;
import com.wcs.repository.BoardRepositoryCustom;
import com.wcs.repository.CategoryRepository;
import com.wcs.vo.PageVO;
import com.wcs.vo.PageMaker;

import lombok.extern.java.Log;

@Controller
@RequestMapping("/boards/")
@Log
public class BoardController {

	
	@Autowired
	private CategoryRepository catrepo;
	
	@Autowired
	private BoardRepository brepo;
	
	@GetMapping("/topic")
	public void topicGET(@ModelAttribute("vo")Category vo, Model model) {
		log.info("---------------topic get");
		List<Object[]> resultOfCategory = catrepo.getCategoryNamesAndBoardsCount();
		model.addAttribute("result", resultOfCategory);
	}
	
	
	
	@GetMapping("/bregister")
	public void registerGET(Long cno, @ModelAttribute("vo")Board vo ){
		log.info("register get");
		vo.setTitle("샘플 게시물 제목입니다....");
		vo.setContent("내용을 처리해 봅니다 " );
		vo.setCategory(new Category());
		vo.getCategory().setCno(cno);
		//TODO: 다시 만들어볼 것
//		Member member = new Member();
//		member.setUid("user00");
//		vo.setMember(member);
	}
	
	@PostMapping("/bregister")
	public String registerPOST(@ModelAttribute("vo")Board vo, RedirectAttributes rttr){
		
		log.info("register post");
		log.info("" + vo);
//		vo.getCategory().setCno(cno);
		brepo.save(vo);
		
		rttr.addFlashAttribute("msg", "success");
		rttr.addAttribute("cno", vo.getCategory().getCno());
		
		return "redirect:/boards/blist";
	}
	
	@GetMapping("/bview")
	public void view(Long bno, @ModelAttribute("pageVO") PageVO vo, Model model){
		
		log.info("BNO: "+ bno);
		
		Optional.ofNullable(brepo.findOne(bno)).ifPresent(board -> model.addAttribute("vo", board));
		
	}
	
	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@GetMapping("/bmodify")
	public void modify(Long bno, @ModelAttribute("pageVO") PageVO vo, Model model){
		
		log.info("MODIFY BNO: "+ bno);
		
		Optional.ofNullable(brepo.findOne(bno)).ifPresent(board -> model.addAttribute("vo", board));
	}
	
	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@PostMapping("/bmodify")
	public String modifyPost(Board board, PageVO vo, RedirectAttributes rttr ){
		
		log.info("Modify Board: " + board);
		
		Optional.ofNullable(brepo.findOne(board.getBno())).ifPresent( origin ->{
		 
			origin.setTitle(board.getTitle());
			origin.setContent(board.getContent());
			
			brepo.save(origin);
			rttr.addFlashAttribute("msg", "success");
			rttr.addAttribute("bno", origin.getBno());
		});
		
		//페이징과 검색했던 결과로 이동하는 경우 
		rttr.addAttribute("page", vo.getPage());
		rttr.addAttribute("size", vo.getSize());
		rttr.addAttribute("type", vo.getType());
		rttr.addAttribute("keyword", vo.getKeyword());
		rttr.addAttribute("catno", vo.getCno());

		return "redirect:/boards/bview";
	}
	
	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@PostMapping("/delete")
	public String delete(Long bno, PageVO vo, RedirectAttributes rttr ){
		
		log.info("DELETE BNO: " + bno);
		
		brepo.delete(bno);
		
		rttr.addFlashAttribute("msg", "success");

		//페이징과 검색했던 결과로 이동하는 경우 
		rttr.addAttribute("page", vo.getPage());
		rttr.addAttribute("size", vo.getSize());
		rttr.addAttribute("type", vo.getType());
		rttr.addAttribute("keyword", vo.getKeyword());

		return "redirect:/boards/blist";
	}
	
	
	@GetMapping("/blist")
	@Transactional
	public void list(@ModelAttribute("pageVO") PageVO vo, Model model){
		
		Pageable page = vo.makePageable(0, "bno");
		
		Page<Object[]> result = brepo.getCustomPage(vo.getType(), 
				vo.getKeyword(), page, Long.parseLong(vo.getCno()));
		
		log.info(""+ page);
		log.info(""+result);
		
		log.info("TOTAL PAGE NUMBER: " + result.getTotalPages());
		model.addAttribute("result", new PageMaker<>(result, page));
				
	}

}