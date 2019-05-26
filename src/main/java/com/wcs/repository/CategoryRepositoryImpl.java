package com.wcs.repository;

import java.util.ArrayList;
import java.util.List;


import org.springframework.data.jpa.repository.support.QueryDslRepositorySupport;


import com.querydsl.core.Tuple;
import com.querydsl.jpa.JPQLQuery;
import com.wcs.domain.Category;
import com.wcs.domain.QBoard;
import com.wcs.domain.QCategory;

import lombok.extern.java.Log;

@Log
public class CategoryRepositoryImpl extends QueryDslRepositorySupport implements CategoryRepositoryCustom {

	public CategoryRepositoryImpl() {
		super(Category.class);
	}

	
	@Override
	public List<Object[]> getCategoryNamesAndBoardsCount() {
		log.info("====================================");
		log.info("starting category main page model query");
		
		// TODO Auto-generated method stub
		QCategory c = QCategory.category;
		QBoard b = QBoard.board;
		JPQLQuery<Category> query = from(c);
		
		List<Tuple> list = query.select(c.cno, c.cname, b.count())
				.leftJoin(c.boards, b)
				.where(c.cno.gt(0L))
				.groupBy(c.cname)
				.orderBy(c.cno.desc())
				.fetch();
		
		List<Object[]> resultList = new ArrayList<>();

		list.forEach(t -> {
			resultList.add(t.toArray());
		});
		
		return resultList;
	}
}
