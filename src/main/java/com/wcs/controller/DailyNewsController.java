package com.wcs.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wcs.crawler.DailyNewsCrawler;
import com.wcs.domain.DailyNews;



@Controller
@RequestMapping("/dailynews/")
public class DailyNewsController {
  
  DailyNewsCrawler crawler;

  @GetMapping("/dnlist")
  public void join(Model model, String date){
	  
	  if(date==null) {
		  Date dt = new Date();
		  crawler = new DailyNewsCrawler(dt);
		  date = crawler.getSdate();
	  }else {
		  try {
			crawler = new DailyNewsCrawler(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
	  }	  
	  
	  List<DailyNews> list = new ArrayList<DailyNews>();
	  try {
		  list = crawler.getListOfDailyEconomyNews();
	  } catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	  }
	  model.addAttribute("news", list);
	  model.addAttribute("date", date);
	  model.addAttribute("prevDate", crawler.getPrevDate());
	  model.addAttribute("nextDate", crawler.getNextDate());
  }
}
