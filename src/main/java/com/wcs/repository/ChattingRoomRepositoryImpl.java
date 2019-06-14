package com.wcs.repository;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.support.QueryDslRepositorySupport;


import com.querydsl.core.Tuple;
import com.querydsl.jpa.JPQLQuery;
import com.wcs.domain.ChattingRoom;
import com.wcs.domain.QChattingRoom;

import lombok.extern.java.Log;

@Log
public class ChattingRoomRepositoryImpl extends QueryDslRepositorySupport implements ChattingRoomRepositoryCustom {

	public ChattingRoomRepositoryImpl() {
		super(ChattingRoom.class);
	}

	@Override
	public Page<Object[]> getChattingRoomPage(String keyword, Pageable page) {
		log.info("====================================");
		log.info("KEYWORD: " + keyword);
		log.info("PAGE: " + page);
		log.info("====================================");

		QChattingRoom chr = QChattingRoom.chattingRoom;
		
		JPQLQuery<ChattingRoom> query = from(chr);
		
		JPQLQuery<Tuple> tuple = query.select(chr.chrno, chr.title, chr.member.uid,  chr.regdate);
		
		tuple.where(chr.chrno.gt(0L));
		
		if(keyword!=null) {
			tuple.where(chr.title.like("%" + keyword +"%"));
		}


		tuple.offset(page.getOffset());
		tuple.limit(page.getPageSize());

		List<Tuple> list = tuple.fetch();

		List<Object[]> resultList = new ArrayList<>();

		list.forEach(t -> {
			resultList.add(t.toArray());
		});

		long total = tuple.fetchCount();

		return new PageImpl<>(resultList, page, total);

	}
}
