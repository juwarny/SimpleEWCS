package com.wcs;


import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Commit;
import org.springframework.test.context.junit4.SpringRunner;

import com.wcs.domain.Category;
import com.wcs.domain.Member;
import com.wcs.repository.CategoryRepository;
import com.wcs.repository.MemberRepository;

import lombok.extern.java.Log;


@RunWith(SpringRunner.class)
@SpringBootTest
@Log
@Commit
public class ProfileTests {

	@Autowired
	private CategoryRepository repo;
	
	
	@Test
	@Commit
	public void testInsertCategory() {
		String[] cnamess = {"주식", "채권", "종목분석", "경제현황"};
		IntStream.range(0, 4).forEach(i -> {
			Category cate = new Category();
			cate.setCname(cnamess[i]);
			repo.save(cate);
		});
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
