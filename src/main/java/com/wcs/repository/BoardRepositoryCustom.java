package com.wcs.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface BoardRepositoryCustom {

	public Page<Object[]> getCustomPage(String type, String keyword, Pageable page, Long catno);
	
}
