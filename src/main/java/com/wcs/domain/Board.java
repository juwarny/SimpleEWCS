package com.wcs.domain;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
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
@Table(name = "tbl_boards")
@EqualsAndHashCode(of = "bno")
@ToString(exclude= {"replies", "likehates"})
public class Board {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long bno;
	private String title;

	private String content;

	@CreationTimestamp
	private Timestamp regdate;
	@UpdateTimestamp
	private Timestamp updatedate;
	
	@JsonIgnore
	@OneToMany(mappedBy="board", fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	private List<Reply> replies;
	
	@OneToMany(mappedBy="board", fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	private List<LikeHate> likehates;
	
	@ManyToOne
	private Member member;
	
	@ManyToOne
	private Category category;
}
