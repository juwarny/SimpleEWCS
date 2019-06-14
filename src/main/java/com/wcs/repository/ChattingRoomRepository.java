package com.wcs.repository;


import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.data.repository.CrudRepository;

import com.wcs.domain.Board;
import com.wcs.domain.ChattingRoom;

public interface ChattingRoomRepository extends CrudRepository<ChattingRoom, Long>, ChattingRoomRepositoryCustom, QueryDslPredicateExecutor<Board>{


}





