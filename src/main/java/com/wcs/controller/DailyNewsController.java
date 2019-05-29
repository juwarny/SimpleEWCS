package com.wcs.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;

import com.wcs.crawler.DailyNewsCrawler;
import com.wcs.domain.DailyNews;


import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/dailynews/")
public class DailyNewsController {
  
  DailyNewsCrawler crawler;

  @GetMapping("/dnlist")
  public void join(Model model){
	  crawler = new DailyNewsCrawler();
	  Date date = new Date();
	  List<DailyNews> list = new ArrayList<DailyNews>();
	  try {
		  list = crawler.getListOfDailyEconomyNews(date);
	  } catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	  }
	  model.addAttribute("news", list);
  }
}
