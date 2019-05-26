package com.wcs.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.wcs.domain.Board;
import com.wcs.domain.LikeHate;
import com.wcs.domain.Member;


public interface LikeOrHateRepository extends CrudRepository<LikeHate, Long> {

	
	@Query("SELECT h FROM LikeHate h WHERE h.board = ?1 " +
	       " AND h.rno > 0 ORDER BY h.rno ASC")
	public List<LikeHate> getLikeOrHateOfBoard(Board board);
	
	@Query("SELECT h FROM LikeHate h WHERE h.board = ?1 " + "And h.member = ?2" +
		       " AND h.lhno > 0 ORDER BY h.lhno ASC")
	public List<LikeHate> getLikeOrHateOfUserAndBoard(Board board, Member member);

}
