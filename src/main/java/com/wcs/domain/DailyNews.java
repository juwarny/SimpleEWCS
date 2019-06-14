package com.wcs.domain;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain=true)
@Entity
@Table(name = "tbl_daily_news")
@ToString
@EqualsAndHashCode(of = "dnno")
public class DailyNews {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long dnno;
	
	private String headline;	
	private String imgSrc;
	private String href;
	private String pretxt;
	private String office;	

	@CreationTimestamp
	private Timestamp regdate;
	@UpdateTimestamp
	private Timestamp updatedate;
}
