package com.wcs.controller;

import java.io.IOException;
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

import com.google.common.collect.Lists;
import com.wcs.crawler.YahooFinanceStock;
import com.wcs.domain.Board;
import com.wcs.domain.KoreaStock;
import com.wcs.domain.Member;
import com.wcs.repository.StockRepository;
import com.wcs.repository.StockRepository;

import lombok.extern.java.Log;
import yahoofinance.histquotes.HistoricalQuote;

@RestController
@RequestMapping("/stocks/*")
@Log
public class StockController {

	@Autowired
	private StockRepository repo;
	
	private YahooFinanceStock yf;
	
	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@GetMapping("/stocklist")
	public ResponseEntity<List<KoreaStock>> getAllStocksList(){
	
		log.info("get All Stocks..........................");
		List<KoreaStock> result = Lists.newArrayList(repo.findAll());
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	
	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@GetMapping("/symbol/{symbol}")
	public ResponseEntity<List<KoreaStock>> getStocksBySymbol(
			@PathVariable("symbol")String symbol){
	
		log.info("get Stocks like symbol..........................");
		
		KoreaStock stock = new KoreaStock();
		stock.setSymbol(symbol);
		
		return new ResponseEntity<>(getListByStockSymbol(stock), HttpStatus.OK);
	}
	
	@Secured(value={"ROLE_BASIC","ROLE_MANAGER","ROLE_ADMIN"})
	@GetMapping("/stcode/{stcode}")
	public ResponseEntity<List<HistoricalQuote>> getHistoryOfStock(
			@PathVariable("stcode")String stcode){
	
		log.info("get Stocks stock..........................");
		
		yf = new YahooFinanceStock();
		
		List<HistoricalQuote> result = new ArrayList<HistoricalQuote>();
		KoreaStock stock = repo.findOne(stcode);
		
		try {
			result = yf.getHistoryQuoteByStock(stock);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	private List<KoreaStock> getListByStockSymbol(KoreaStock stock)throws RuntimeException{
		
		log.info("getListByStockSymbol");
		List<KoreaStock> list = new ArrayList<KoreaStock>();
		list = repo.getStocksBySymbol(stock.getSymbol());
		
		return list;
	}
	
	
}



