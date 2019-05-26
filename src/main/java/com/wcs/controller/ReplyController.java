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
import com.wcs.domain.Reply;
import com.wcs.repository.ReplyRepository;

import lombok.extern.java.Log;

@RestController
@RequestMapping("/replies/*")
@Log
public class ReplyController {

	@Autowired
	private ReplyRepository replyRepo;
	
	
	@GetMapping("/{bno}")
	public ResponseEntity<List<Reply>> getReplies(
			@PathVariable("bno")Long bno){
	
		log.info("get All Replies..........................");
		
		Board board = new Board();
		board.setBno(bno);
		return new ResponseEntity<>(getListByBoard(board), HttpStatus.OK);
	}
	
	
	
//	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@Transactional
	@PostMapping("/{bno}")
	public ResponseEntity<List<Reply>> addReply(
			@PathVariable("bno")Long bno, 
			@RequestBody Reply reply){

		log.info("addReply..........................");
		log.info("BNO: " + bno);
		log.info("REPLY: " + reply);
		
		Board board = new Board();
		board.setBno(bno);
		
		reply.setBoard(board);
		
		replyRepo.save(reply);		
		
		return new ResponseEntity<>(getListByBoard(board), HttpStatus.CREATED);
		
	}
	
//	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@Transactional
	@DeleteMapping("/{bno}/{rno}")
	public ResponseEntity<List<Reply>> remove(
			@PathVariable("bno")Long bno,
			@PathVariable("rno")Long rno){
		
		log.info("delete reply: "+ rno);
		
		replyRepo.delete(rno);
		
		Board board = new Board();
		board.setBno(bno);
		
		return  new ResponseEntity<>(getListByBoard(board), HttpStatus.OK);
		
	}
	
	
//	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@Transactional
	@PutMapping("/{bno}")
	public ResponseEntity<List<Reply>> modify(@PathVariable("bno")Long bno, 
			@RequestBody Reply reply){
	
		log.info("modify reply: "+ reply);
		
		Optional<Reply> replyOp = Optional.ofNullable(replyRepo.findOne(reply.getRno()));				
		
		replyOp.ifPresent(origin -> {
			
			origin.setReplyText(reply.getReplyText());
			origin.setReplyer(reply.getReplyer());
			
			replyRepo.save(origin);
		});
		
		Board board = new Board();
		board.setBno(bno);
		
		return new ResponseEntity<>(getListByBoard(board), HttpStatus.OK);
	}
	
	private List<Reply> getListByBoard(Board board)throws RuntimeException{
		
		log.info("getListByBoard...." + board);
		return replyRepo.getRepliesOfBoard(board);
		
	}
	
	
}



