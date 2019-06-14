package com.wcs.vo;

import java.sql.Timestamp;

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
