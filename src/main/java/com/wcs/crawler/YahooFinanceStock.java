package com.wcs.crawler;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.List;

import com.wcs.domain.KoreaStock;

import lombok.extern.java.Log;
import yahoofinance.Stock;
import yahoofinance.YahooFinance;
import yahoofinance.histquotes.HistoricalQuote;
import yahoofinance.histquotes.Interval;

@Log
public class YahooFinanceStock {
	public List<HistoricalQuote> getHistoryQuoteByStock(KoreaStock stock) throws IOException{
		Stock st = YahooFinance.get(stock.getStcode()+"."+stock.getMarket());
		Calendar from = Calendar.getInstance();
		Calendar to = Calendar.getInstance();
		from.add(Calendar.YEAR, -1); // from 1 year ago
		
		List<HistoricalQuote> result = st.getHistory(from, to, Interval.DAILY);
		
		return result;
	}
//	public static void main(String[] args) throws IOException {
//		Stock google = YahooFinance.get("095570.KS");
//		Stock g = YahooFinance.get("095570.KS");
//		
//		log.info(g.getName());
//		Calendar from = Calendar.getInstance();
//		Calendar to = Calendar.getInstance();
//		from.add(Calendar.YEAR, -1); // from 1 year ago
//		 
//		List<HistoricalQuote> googleHistQuotes = google.getHistory(from, to, Interval.DAILY);
//		
//		googleHistQuotes.forEach(a->{
//			log.info(a.toString());
//		});
//	}
}
