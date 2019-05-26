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
@Table(name = "tbl_like_hate")
@EqualsAndHashCode(of = "lhno")
@ToString(exclude = {"member","board"})
public class LikeHate {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long lhno;
	private boolean loh;

	@CreationTimestamp
	private Timestamp regdate;
	@UpdateTimestamp
	private Timestamp updatedate;
	
	
	@ManyToOne(fetch=FetchType.LAZY)
	private Member member;
	
	@ManyToOne(fetch=FetchType.LAZY)
	private Board board;
}
