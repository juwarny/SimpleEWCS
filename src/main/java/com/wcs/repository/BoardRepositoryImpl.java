package com.wcs.repository;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.support.QueryDslRepositorySupport;


import com.querydsl.core.Tuple;
import com.querydsl.jpa.JPQLQuery;
import com.wcs.domain.Board;
import com.wcs.domain.QBoard;
import com.wcs.domain.QReply;

import lombok.extern.java.Log;

@Log
public class BoardRepositoryImpl extends QueryDslRepositorySupport implements BoardRepositoryCustom {

	public BoardRepositoryImpl() {
		super(Board.class);
	}

	@Override
	public Page<Object[]> getCustomPage(String type, String keyword, Pageable page, Long catno) {
		log.info("====================================");
		log.info("TYPE: " + type);
		log.info("KEYWORD: " + keyword);
		log.info("PAGE: " + page);
		log.info("====================================");

		QBoard b = QBoard.board;
		QReply r = QReply.reply;
		
		JPQLQuery<Board> query = from(b);
		
		JPQLQuery<Tuple> tuple = query.select(b.bno, b.title, r.count(), b.member.uid, b.regdate);
		tuple.leftJoin(b.replies, r);
		tuple.where(b.bno.gt(0L).and(b.category.cno.eq(catno)));
		
		if(type != null){
			
			switch (type.toLowerCase()) {
			case "t":
				tuple.where(b.title.like("%" + keyword +"%"));
				break;
			case "c":
				tuple.where(b.content.like("%" + keyword +"%"));
				break;
			case "w":
				tuple.where(b.member.uid.like("%" + keyword +"%"));
				break;				
			}
		}
		

		tuple.groupBy(b.bno);
		tuple.orderBy( b.bno.desc());

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
