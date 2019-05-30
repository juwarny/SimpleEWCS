package com.wcs.vo;

import java.sql.Timestamp;

import javax.persistence.FetchType;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.wcs.domain.Board;
import com.wcs.domain.Member;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LikeHateVO {

	private Long lhno;
	
	private Boolean loh;

	private Timestamp regdate;
	private Timestamp updatedate;	
	
	private String uid;
	
	private Long bno;

}
