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
@Table(name = "tbl_chatting_rooms")
@EqualsAndHashCode(of = "chrno")
@ToString(exclude="chats")
public class ChattingRoom {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long chrno;
	private String title;

	@CreationTimestamp
	private Timestamp regdate;
	@UpdateTimestamp
	private Timestamp updatedate;
	
	@JsonIgnore
	@OneToMany(mappedBy="chroom", fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	private List<Chatting> chats;
	
	@ManyToOne
	private Member member;
	
}
