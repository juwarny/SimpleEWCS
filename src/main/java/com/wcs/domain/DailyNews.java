package com.wcs.domain;

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Entity
@Table(name = "tbl_daily_news")
@EqualsAndHashCode(of = "dnno")
@ToString(exclude = {"member"})
public class DailyNews {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long dnno;
	private String title;
	
	private String content;

	@CreationTimestamp
	private Timestamp regdate;
	@UpdateTimestamp
	private Timestamp updatedate;
	
	
	@ManyToOne(fetch=FetchType.LAZY)
	private Member member;
}
