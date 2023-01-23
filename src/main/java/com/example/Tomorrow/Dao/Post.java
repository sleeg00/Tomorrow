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

    @Column(name = "title")
    private String title;

    @Column(name = "content")
    private String content;

    @Column(name = "picture")
    private String post_picture;

    @Column(name = "likes", nullable = true)
    private String likes;

    @Column(name = "comment", nullable = true)
    private String comment;

    @ManyToOne
    @JoinColumn(name="member_id") //중복 안되게 Post테이블의 id필드랑
    private Member member;


}
