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
import com.wcs.domain.ChattingRoom;
import com.wcs.domain.QBoard;
import com.wcs.domain.QChatting;
import com.wcs.domain.QChattingRoom;
import com.wcs.domain.QMember;
import com.wcs.domain.QReply;

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
		QMember m = QMember.member;
		QChatting ch = QChatting.chatting;
		
		/*
		 * .from(qSampleBO)
		 * .innerJoin(qEntity1).on(qEntity1.id.eq(qSampleBO.address.id))
		 * .innerJoin(qEntity2).on(qEntity2.id.eq(qSampleBO.secondary_address.id))
		 */
		
		JPQLQuery<ChattingRoom> query = from(chr);
		
		JPQLQuery<Tuple> tuple = query.select(chr.chrno, chr.title, m.count(), chr.member.uid,  chr.regdate);
		tuple.join(chr.chats, ch);
		tuple.join(ch.member, m);
		
		tuple.where(chr.chrno.gt(0L));
		tuple.where(chr.title.like("%" + keyword +"%"));

		tuple.groupBy(chr.chrno);
		tuple.orderBy(chr.chrno.desc());

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
