package com.wcs.crawler;

import java.io.IOException;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.data.repository.NoRepositoryBean;

import com.wcs.domain.DailyNews;

import lombok.Getter;
import lombok.extern.java.Log;
@Log
@Getter
public class DailyNewsCrawler {
	private final static String base = "https://news.naver.com/main/ranking/popularDay.nhn?rankingType=popular_day&sectionId=101&date=";
	private final static String naver = "https://news.naver.com";
	
	private SimpleDateFormat formatter;
	private String sdate;
	private Date date;
	
	public DailyNewsCrawler(Date date) {
		this.formatter = new SimpleDateFormat("yyyyMMdd");
		this.date = date;
		this.sdate = formatter.format(date);
	}
	
	public DailyNewsCrawler(String date) throws ParseException {
		this.sdate = date;
		this.formatter = new SimpleDateFormat("yyyyMMdd");
		this.date = formatter.parse(sdate);
	}
	
	public List<DailyNews> getListOfDailyEconomyNews() throws IOException {
		
		String targetUrl = base + sdate;
				
		Document doc = Jsoup.connect(targetUrl).get();
		
		Element content = doc.select("ol.ranking_list").first();
		Elements items = content.getElementsByTag("li");
		
		List<DailyNews> list = new ArrayList<DailyNews>();
		
		for (Element item : items) {
			
			DailyNews dailynews = new DailyNews();
			Element thumb = item.selectFirst("div.ranking_thumb");
			Element text = item.selectFirst("div.ranking_text");
			
			Optional.ofNullable(thumb).ifPresent(th->{
							String imgSrc = thumb.selectFirst("a img").attr("src");
							dailynews.setImgSrc(imgSrc);
						});
		

			String headline = text.selectFirst("div.ranking_headline a").text();
			String href = text.selectFirst("div.ranking_headline a").attr("href");

			String pretxt = text.selectFirst("div.ranking_lede").text();
			String office = text.selectFirst("div.ranking_office").text();
			
			dailynews.setHref(naver+href).setHeadline(headline).setOffice(office).setPretxt(pretxt);
			log.info(dailynews.toString());
			list.add(dailynews);
		}
		return list;
	}
	
	public String getPrevDate() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date); 
		cal.add(Calendar.DATE, -1);
		String preDate = formatter.format(cal.getTime());
		
		return preDate;
	}
	
	public String getNextDate() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date); 
		cal.add(Calendar.DATE, +1);
		
		Calendar current = Calendar.getInstance();
		current.setTime(new Date());
		
		int result = current.compareTo(cal);
		
		String nextDate;
		if(result>0) {
			 nextDate = formatter.format(cal.getTime());	
		}else {
			nextDate = null;
		}		
			
		return nextDate;
	}
}
