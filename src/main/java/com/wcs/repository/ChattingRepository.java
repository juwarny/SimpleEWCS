package com.wcs.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.wcs.domain.Chatting;
import com.wcs.domain.ChattingRoom;


public interface ChattingRepository extends CrudRepository<Chatting, Long> {

	
	@Query("SELECT c FROM Chatting c WHERE c.chroom = ?1 " +
	       " AND c.chtno > 0 ORDER BY c.chtno ASC")
	public List<Chatting> getChattsOfChroom(ChattingRoom Chroom);

}
