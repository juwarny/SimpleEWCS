package com.wcs.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.data.repository.CrudRepository;


import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Predicate;
import com.wcs.domain.Board;
import com.wcs.domain.ChattingRoom;
import com.wcs.domain.QBoard;

public interface ChattingRoomRepository extends CrudRepository<ChattingRoom, Long>, ChattingRoomRepositoryCustom, QueryDslPredicateExecutor<Board>{


}





