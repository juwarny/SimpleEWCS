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

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Entity
@Table(name = "tbl_up_downs")
@EqualsAndHashCode(of = "upno")
@ToString(exclude = {"member","stock"})
public class UpDown {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long upno;
	
	private Long opinion;

	@CreationTimestamp
	private Timestamp regdate;
	@UpdateTimestamp
	private Timestamp updatedate;
	
	@JsonIgnore
	@ManyToOne(fetch=FetchType.LAZY)
	private Member member;
	
	@JsonIgnore
	@ManyToOne(fetch=FetchType.LAZY)
	private KoreaStock stock;
}
