package com.wcs.controller;

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
import com.wcs.repository.LikeOrHateRepository;
import lombok.extern.java.Log;

@RestController
@RequestMapping("/likehate/*")
@Log
public class LikeHateController {

	@Autowired
	private LikeOrHateRepository repo;
	
	
	@GetMapping("/{bno}")
	public ResponseEntity<List<LikeHate>> getReplies(
			@PathVariable("bno")Long bno){
	
		log.info("get All Replies..........................");
		
		Board board = new Board();
		board.setBno(bno);
		return new ResponseEntity<>(getListByBoard(board), HttpStatus.OK);
	}
	
	
	
//	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@Transactional
	@PostMapping("/{bno}")
	public ResponseEntity<List<LikeHate>> addLikeHate(
			@PathVariable("bno")Long bno, 
			@RequestBody LikeHate likehate){

		log.info("addLikeHate..........................");
		log.info("BNO: " + bno);
		log.info("LikeHate: " + likehate);
		
		Board board = new Board();
		board.setBno(bno);
		
		likehate.setBoard(board);
		
		repo.save(likehate);		
		
		return new ResponseEntity<>(getListByBoard(board), HttpStatus.CREATED);
		
	}
	
//	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@Transactional
	@DeleteMapping("/{bno}/{lhno}")
	public ResponseEntity<List<LikeHate>> remove(
			@PathVariable("bno")Long bno,
			@PathVariable("lhno")Long lhno){
		
		log.info("delete LikeHate: "+ lhno);
		
		repo.delete(lhno);
		
		Board board = new Board();
		board.setBno(bno);
		
		return  new ResponseEntity<>(getListByBoard(board), HttpStatus.OK);
		
	}
	
	
//	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@Transactional
	@PutMapping("/{bno}")
	public ResponseEntity<List<LikeHate>> modify(@PathVariable("bno")Long bno, 
			@RequestBody LikeHate likehate){
	
		log.info("modify LikeHate: "+ likehate);
		
		Optional<LikeHate> likeHateOp = Optional.ofNullable(repo.findOne(likehate.getLhno()));				
		
		likeHateOp.ifPresent(origin -> {
			origin.setLoh(likehate.getLoh());			
			repo.save(origin);
		});
		
		Board board = new Board();
		board.setBno(bno);
		
		return new ResponseEntity<>(getListByBoard(board), HttpStatus.OK);
	}
	
	private List<LikeHate> getListByBoard(Board board)throws RuntimeException{		
		
		log.info("getListByBoard...." + board);
		return repo.getLikeOrHateOfBoard(board);		
	}
	
	
}



