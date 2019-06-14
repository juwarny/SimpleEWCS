package com.wcs.repository;


import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.data.repository.CrudRepository;
import com.wcs.domain.Board;

public interface BoardRepository extends CrudRepository<Board, Long>, BoardRepositoryCustom, QueryDslPredicateExecutor<Board>{

// jpa는 기본적인 쿼리 (삭제, 업데이트, 생성, 하나 찾기, 전부 가져오기)를 인터페이스로 제공합니다.

}





