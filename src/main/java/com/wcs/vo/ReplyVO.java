package com.wcs.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReplyVO {

	private Long rno;
	
	private String replyText;	
	
	private Timestamp regdate;
	private Timestamp updatedate;
	
	private Long bno;
	
	private String replyer;

}
