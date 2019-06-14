package com.wcs.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import com.wcs.domain.KoreaStock;

public interface StockRepository extends CrudRepository<KoreaStock, String>{
	@Query("SELECT s FROM KoreaStock s WHERE s.symbol LIKE ?1% ORDER BY s.symbol ASC")
	public List<KoreaStock> getStocksBySymbol(String symbol);
}





