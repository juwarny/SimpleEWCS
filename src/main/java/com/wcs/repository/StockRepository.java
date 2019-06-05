package com.wcs.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.data.repository.CrudRepository;


import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Predicate;
import com.wcs.domain.Board;
import com.wcs.domain.KoreaStock;
import com.wcs.domain.QBoard;

public interface StockRepository extends CrudRepository<KoreaStock, String>{
	@Query("SELECT s FROM KoreaStock s WHERE s.symbol LIKE ?1% ORDER BY c.chtno ASC")
	public List<KoreaStock> getStocksBySymbol(String symbol);
}





