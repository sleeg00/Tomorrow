package com.example.Tomorrow.Dao;

import lombok.*;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

@Entity
@Table(name = "post")
@Getter
@Setter
@Data
@NoArgsConstructor
@AllArgsConstructor

public class Post {

    @Id
    @Column(name = "post_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long post_id;


    @Column(name = "tag")
    private String tag;

    @Column(name = "content")
    private String content;

    @Column(name = "picture")
    private Long post_picture;

    @Column(name = "likes", nullable = true)
    private Long likes;

    @Column(name = "comment", nullable = true)
    private String comment;

    @Column(name = "emoticon")
    private String emoticon;

    @ManyToOne
    @JoinColumn(name="member_id") //중복 안되게 Post테이블의 id필드랑
    private Member member;

}
