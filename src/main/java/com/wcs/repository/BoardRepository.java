package com.wcs.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.data.repository.CrudRepository;


import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Predicate;
import com.wcs.domain.Board;
import com.wcs.domain.QBoard;

public interface BoardRepository extends CrudRepository<Board, Long>, BoardRepositoryCustom, QueryDslPredicateExecutor<Board>{

// TODO:쿼리 변경 !!
//
//	@Query("SELECT b.category, b.bno, b.title, b.member, b.regdate, count(r) FROM Board b " +
//	    " LEFT OUTER JOIN b.replies r WHERE b.bno > 0 GROUP BY b.category")
//	public Page<Object[]> getListWithAll(Pageable page);
//	
//	// TODO:쿼리 변경
//	@Query("SELECT b.category, b.bno, b.title, b.member, b.regdate, count(r) FROM Board b " +
//		    " LEFT OUTER JOIN b.replies r WHERE b.title like %?1%  AND b.bno > 0 GROUP BY b")
//	public Page<Object[]> getListWithTitle(String keyword, Pageable page);
//	// TODO:쿼리 변경
//	@Query("SELECT b.category, b.bno, b.title, b.member, b.regdate, count(r) FROM Board b " +
//		    " LEFT OUTER JOIN b.replies r WHERE b.content like %?1% AND b.bno > 0 GROUP BY b")
//	public Page<Object[]> getListWithContent(String keyword, Pageable page);
//	// TODO:쿼리 변경
//	@Query("SELECT b.category, b.bno, b.title, b.member, b.regdate, count(r) FROM Board b " +
//		    " LEFT OUTER JOIN b.replies r WHERE b.writer like %?1% AND b.bno > 0 GROUP BY b")
//	public Page<Object[]> getListWithWriter(String keyword, Pageable page);
//	
}





