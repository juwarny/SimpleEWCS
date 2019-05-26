package com.wcs.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.wcs.domain.Board;
import com.wcs.domain.Reply;


public interface ReplyRepository extends CrudRepository<Reply, Long> {

	
	@Query("SELECT r FROM Reply r WHERE r.board = ?1 " +
	       " AND r.rno > 0 ORDER BY r.rno ASC")
	public List<Reply> getRepliesOfBoard(Board board);

}
