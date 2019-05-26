package com.wcs.repository;


import org.springframework.data.repository.CrudRepository;



import com.wcs.domain.Category;


public interface CategoryRepository extends CrudRepository<Category, Long>, CategoryRepositoryCustom{

	
}





