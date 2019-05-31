package com.wcs.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ChattingRoomRepositoryCustom {

	public Page<Object[]> getChattingRoomPage(String keyword, Pageable page);
	
}
