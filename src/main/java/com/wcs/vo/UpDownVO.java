package com.wcs.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UpDownVO {

	private Long upno;
	
	private Long opinion;

	private Timestamp regdate;
	private Timestamp updatedate;
	
	private String uid;	
	
	private String stcode;

}
