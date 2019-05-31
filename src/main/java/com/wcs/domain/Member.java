package com.wcs.domain;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
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
@Table(name = "tbl_members")
@EqualsAndHashCode(of = "uid")
@ToString(exclude = {"boards", "replies", "chats", "likehates", "dailynews", "chrooms"})
public class Member {

  @Id
  private String uid;
  
  private String upw;
  
  private String uname;
  
  private String grade;
  
  private Integer points;
  
  
  @CreationTimestamp
  private Timestamp regdate;
  @UpdateTimestamp
  private Timestamp updatedate;
  
  @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER)
  @JoinColumn(name = "member")
  private List<MemberRole> roles;
  
  @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY)
  private List<Board> boards;
  
  @JsonIgnore
  @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY)
  private List<Reply> replies;
  
  @JsonIgnore
  @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY)
  private List<Chatting> chats;
  
  @JsonIgnore
  @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY)
  private List<ChattingRoom> chrooms;
  
  @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY)
  private List<LikeHate> likehates;
  
  @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY)
  private List<DailyNews> dailynews;
}
