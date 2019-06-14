package com.wcs.controller;

import java.util.ArrayList;
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
import com.wcs.domain.LikeHate;
import com.wcs.domain.Member;
import com.wcs.repository.LikeOrHateRepository;
import com.wcs.vo.LikeHateVO;

import lombok.extern.java.Log;

@RestController
@RequestMapping("/likehate/*")
@Log
public class LikeHateController {

	@Autowired
	private LikeOrHateRepository repo;
	
	
	@GetMapping("/{bno}")
	public ResponseEntity<List<LikeHateVO>> getLikeHate(
			@PathVariable("bno")Long bno){
	
		log.info("get All Replies..........................");
		
		Board board = new Board();
		board.setBno(bno);
		return new ResponseEntity<>(getListByBoard(board), HttpStatus.OK);
	}
	
	
	
	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@Transactional
	@PostMapping("/{bno}")
	public ResponseEntity<List<LikeHateVO>> addLikeHate(
			@PathVariable("bno")Long bno, 
			@RequestBody LikeHateVO likehateVO){

		log.info("addLikeHate..........................");
		log.info("BNO: " + bno);
		log.info("LikeHate: " + likehateVO);
		
		Board board = new Board();
		board.setBno(bno);
		
		LikeHate likehate = new LikeHate();
		
		likehate.setBoard(board);
		likehate.setRegdate(likehateVO.getRegdate());
		likehate.setUpdatedate(likehateVO.getUpdatedate());
		likehate.setLhno(likehateVO.getLhno());
		
		Member member = new Member();
		member.setUid(likehateVO.getUid());
		likehate.setMember(member);
		
		likehate.setLoh(likehateVO.getLoh());
		
		repo.save(likehate);		
		
		return new ResponseEntity<>(getListByBoard(board), HttpStatus.CREATED);
		
	}
	
	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@Transactional
	@DeleteMapping("/{bno}/{lhno}")
	public ResponseEntity<List<LikeHateVO>> remove(
			@PathVariable("bno")Long bno,
			@PathVariable("lhno")Long lhno){
		
		log.info("delete LikeHate: "+ lhno);
		
		repo.delete(lhno);
		
		Board board = new Board();
		board.setBno(bno);
		
		return  new ResponseEntity<>(getListByBoard(board), HttpStatus.OK);
		
	}
	
	
	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@Transactional
	@PutMapping("/{bno}")
	public ResponseEntity<List<LikeHateVO>> modify(@PathVariable("bno")Long bno, 
			@RequestBody LikeHateVO likehateVO){
	
		log.info("modify LikeHate: "+ likehateVO);
		
		Optional<LikeHate> likeHateOp = Optional.ofNullable(repo.findOne(likehateVO.getLhno()));				
		
		likeHateOp.ifPresent(origin -> {
			origin.setLoh(likehateVO.getLoh());
			
			Member member = new Member();
			member.setUid(likehateVO.getUid());
			
			origin.setMember(member);			
			
			repo.save(origin);
		});
		
		Board board = new Board();
		board.setBno(bno);
		
		return new ResponseEntity<>(getListByBoard(board), HttpStatus.OK);
	}
	
	private List<LikeHateVO> getListByBoard(Board board)throws RuntimeException{		
		
		log.info("getListByBoard...." + board);
		List<LikeHateVO> list = new ArrayList<LikeHateVO>();
		repo.getLikeOrHateOfBoard(board).forEach(likehate->{
			LikeHateVO vo = new LikeHateVO();
			vo.setBno(likehate.getBoard().getBno());
			vo.setRegdate(likehate.getRegdate());
			vo.setUpdatedate(likehate.getUpdatedate());
			vo.setLhno(likehate.getLhno());
			vo.setUid(likehate.getMember().getUid());
			vo.setLoh(likehate.getLoh());
			list.add(vo);
		});
		return list;		
	}
	
	
}



