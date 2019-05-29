package com.wcs.crawler;

import java.io.IOException;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.data.repository.NoRepositoryBean;

import com.wcs.domain.DailyNews;

import lombok.extern.java.Log;
@Log
public class DailyNewsCrawler {
	private final static String base = "https://news.naver.com/main/ranking/popularDay.nhn?rankingType=popular_day&sectionId=101&date=";
	private final static String naver = "https://news.naver.com";
	
	public DailyNewsCrawler() {
		super();
	}
	public List<DailyNews> getListOfDailyEconomyNews(Date date) throws IOException {
		
		Format formatter = new SimpleDateFormat("yyyyMMdd");
		String sdate = formatter.format(date);
		String targetUrl = base + sdate;
				
		Document doc = Jsoup.connect(targetUrl).get();
		
		Element content = doc.select("ol.ranking_list").first();
		Elements items = content.getElementsByTag("li");
		
		List<DailyNews> list = new ArrayList<DailyNews>();
		
		for (Element item : items) {
			log.info(item.className());
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
			list.add(dailynews);
		}
		return list;
	}
}
