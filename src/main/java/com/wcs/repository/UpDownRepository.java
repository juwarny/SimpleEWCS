package com.wcs.repository;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.data.repository.CrudRepository;


import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Predicate;
import com.wcs.domain.Board;
import com.wcs.domain.Chatting;
import com.wcs.domain.ChattingRoom;
import com.wcs.domain.KoreaStock;
import com.wcs.domain.Member;
import com.wcs.domain.QBoard;
import com.wcs.domain.UpDown;

public interface UpDownRepository extends CrudRepository<UpDown, Long>{
	
	@Query("SELECT COUNT(u), AVG(u.opinion) FROM UpDown u WHERE u.stock = ?1 And u.updatedate > ?2")
	public List<Object[]> getAvgAndCountOfUpDownsByStockCode(KoreaStock stock, Timestamp today);
	
	public UpDown findByMemberAndStock(Member member, KoreaStock stock);
}





