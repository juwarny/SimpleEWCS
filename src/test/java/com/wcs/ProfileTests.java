package com.wcs;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Enumeration;
import java.util.List;
import java.util.stream.IntStream;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Commit;
import org.springframework.test.context.junit4.SpringRunner;

import com.opencsv.CSVReader;
import com.wcs.domain.Category;
import com.wcs.domain.KoreaStock;
import com.wcs.domain.Member;
import com.wcs.repository.CategoryRepository;
import com.wcs.repository.MemberRepository;
import com.wcs.repository.StockRepository;

import lombok.extern.java.Log;


@RunWith(SpringRunner.class)
@SpringBootTest
@Log
@Commit
public class ProfileTests {

	@Autowired
	private CategoryRepository repo;
	
	@Autowired
	private StockRepository strepo;
	
	
//	@Test
//	@Commit
//	public void testInsertCategory() {
//		String[] cnamess = {"주식", "채권", "종목분석", "경제현황"};
//		IntStream.range(0, 4).forEach(i -> {
//			Category cate = new Category();
//			cate.setCname(cnamess[i]);
//			repo.save(cate);
//		});
//	}
//	@Test
//	@Commit
//	@Transactional
//	public void testInsertStock() {
//		String title = "kospi";
//		String filepath = "C://Users/USER/eclipse-workspace/201217802/src/main/resources/static/csv";
//		try{
//			File file = new File(filepath+"/"+title+".csv");
//			FileReader fr = new FileReader(file);
//			BufferedReader bufReader = new BufferedReader(fr);
//			String line = "";
//			
//			int count = 0;
//			while((line = bufReader.readLine()) != null){
//					// ,로 구분되어 있는 각 열을 찾아 문자열 행렬로 반환한다.
//	               if(count!=0) {
//	            	   String[] row = line.split(",");
//		               
//		               KoreaStock stock = new KoreaStock();
//		               stock.setStcode(row[1]);
//		               stock.setSymbol(row[2]);
//		               stock.setIndustrycode(row[3]);
//		               stock.setIndustry(row[4]);
//		               stock.setMarket("KS");
//		               
//		               strepo.save(stock);
//		               
//	               }
//	               count++;
//					             
//	           }
//	           bufReader.close();		           
//		}	
//		catch(IOException e){
//            System.out.println(e);
//        }
//
//	}
	
	@Test
	@Commit
	@Transactional
	public void testInsertStock2() {
		String title = "kospi";
		String filepath = "C://Users/USER/eclipse-workspace/201217802/src/main/resources/static/csv";
		try{
			int count = 0;
			InputStreamReader is = new InputStreamReader(new FileInputStream(filepath+"/"+title+".csv"), "UTF-8");
			CSVReader reader = new CSVReader(is);
	        List<String[]> list = reader.readAll();
	         
	         for(String[] row : list){
	        	 if(count!=0) {		               
		               KoreaStock stock = new KoreaStock();
		               stock.setStcode(row[1]);
		               stock.setSymbol(row[2]);
		               stock.setIndustrycode(row[3]);
		               stock.setIndustry(row[4]);
		               stock.setMarket("KS");
		               
		               strepo.save(stock);
		               
	               }
	               count++;
	         }    
		}	
		catch(IOException e){
            System.out.println(e);
        }

	}
	
//	@Test
//	public void testInsertProfile() {
//		Member member = new Member();
//		member.setUid("user1");
//		
//		for(int i = 1; i < 5; i++) {
//			Profile profile1 = new Profile();
//			profile1.setFname("face"+i+".jpg");
//			
//			if(i==1) {
//				profile1.setCurrent(true);
//			}
//			
//			profile1.setMember(member);
//			profileRepo.save(profile1);
//		}
//	}
	
}
