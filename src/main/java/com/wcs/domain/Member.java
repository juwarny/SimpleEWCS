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

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Entity
@Table(name = "tbl_members")
@EqualsAndHashCode(of = "uid")
@ToString(exclude = {"boards", "replies", "chats", "likehates", "dailynews"})
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
  //@JoinColumn(name = "member")
  private List<Board> boards;
  
  @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY)
  //@JoinColumn(name = "member")
  private List<Reply> replies;
  
  @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY)
  //@JoinColumn(name = "member")
  private List<Chatting> chats;
  
  @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY)
  //@JoinColumn(name = "member")
  private List<LikeHate> likehates;
  
  @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY)
  //@JoinColumn(name = "member")
  private List<DailyNews> dailynews;
}
