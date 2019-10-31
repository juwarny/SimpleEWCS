package com.wcs.repository;

import java.sql.Timestamp;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.wcs.domain.KoreaStock;
import com.wcs.domain.Member;
import com.wcs.domain.UpDown;

public interface UpDownRepository extends CrudRepository<UpDown, Long>{
	
	@Query("SELECT COUNT(u), AVG(u.opinion) FROM UpDown u WHERE u.stock = ?1 And u.updatedate > ?2")
	public Object[] getAvgAndCountOfUpDownsByStockCode(KoreaStock stock, Timestamp today);
	
	public UpDown findByMemberAndStock(Member member, KoreaStock stock);
}





