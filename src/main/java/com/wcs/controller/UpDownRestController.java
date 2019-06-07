package com.wcs.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.wcs.domain.Board;
import com.wcs.domain.KoreaStock;
import com.wcs.domain.Member;
import com.wcs.domain.Reply;
import com.wcs.domain.UpDown;
import com.wcs.repository.MemberRepository;
import com.wcs.repository.ReplyRepository;
import com.wcs.repository.StockRepository;
import com.wcs.repository.UpDownRepository;
import com.wcs.vo.ReplyVO;
import com.wcs.vo.UpDownVO;

import lombok.extern.java.Log;

@RestController
@RequestMapping("/updowns/*")
@Log
public class UpDownRestController {

	@Autowired
	private UpDownRepository upRepo;
	
	@Autowired
	private StockRepository stRepo;
	
	@Autowired
	private MemberRepository mRepo;
	
	@GetMapping("/{stcode}")
	public ResponseEntity<Object[]> getAvgAndCount(
			@PathVariable("stcode")String stcode){
	
		log.info("get Avg and Count updowns..........................");
		
		KoreaStock stock = stRepo.findOne(stcode);
		
		
		return new ResponseEntity<>(getAvgAndCount(stock), HttpStatus.OK);
	}
	
	@GetMapping("/{stcode}/{uid}")
	public ResponseEntity<UpDownVO> getUpdownOfUser(
			@PathVariable("stcode")String stcode, @PathVariable("uid")String uid){
	
		log.info("get Avg and Count updowns..........................");
		
		KoreaStock stock = stRepo.findOne(stcode);
		Member member = mRepo.findOne(uid);
		
		UpDown updown = upRepo.findByMemberAndStock(member, stock);
		
		UpDownVO vo = new UpDownVO();
		
		vo.setOpinion(updown.getOpinion());
		vo.setRegdate(updown.getRegdate());
		vo.setUpdatedate(updown.getUpdatedate());
		vo.setUid(uid);
		vo.setStcode(stcode);
		vo.setUpno(updown.getUpno());
		
		
		return new ResponseEntity<>(vo, HttpStatus.OK);
	}
	
	
	
	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@Transactional
	@PostMapping("/{stcode}/{uid}")
	public ResponseEntity<Object[]> addUpDown(
			@PathVariable("stcode")String stcode, @PathVariable("uid")String uid, 
			@RequestBody UpDownVO vo){

		log.info("addupdown..........................");
		log.info("BNO: " + stcode);
		log.info("updown: " + vo);
		
		UpDown updown = new UpDown();
		Member member = new Member();
		member.setUid(uid);
		updown.setMember(member);
		
		updown.setOpinion(vo.getOpinion());
		KoreaStock st = new KoreaStock();
		st.setStcode(stcode);
		
		updown.setStock(st);
		upRepo.save(updown);
		
		KoreaStock stock = stRepo.findOne(stcode);

		return new ResponseEntity<>(getAvgAndCount(stock), HttpStatus.CREATED);
		
	}

	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@Transactional
	@PutMapping("/{stcode}/{upno}")
	public ResponseEntity<Object[]> modifyUpDown(
			@PathVariable("stcode")String stcode, @PathVariable("upno")Long upno, 
			@RequestBody UpDownVO vo){

		log.info("addupdown..........................");
		log.info("BNO: " + stcode);
		log.info("updown: " + vo);
		
		Optional.ofNullable(upRepo.findOne(upno)).ifPresent(origin->{
			Member member = new Member();
			member.setUid(vo.getUid());
			origin.setMember(member);
			origin.setOpinion(vo.getOpinion());
			upRepo.save(origin);
		});
		
		KoreaStock stock = stRepo.findOne(stcode);

		return new ResponseEntity<>(getAvgAndCount(stock), HttpStatus.CREATED);
	}
	
	private Object[] getAvgAndCount(KoreaStock stock)throws RuntimeException{
		
		Date date = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(date); 
		cal.add(Calendar.DATE, -7);
	
		Object[] result = upRepo.getAvgAndCountOfUpDownsByStockCode(stock, new Timestamp(cal.getTime().getTime()));
		
		return result;
	}
}



