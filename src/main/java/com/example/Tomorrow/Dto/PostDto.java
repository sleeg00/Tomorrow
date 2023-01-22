package com.example.Tomorrow.Dto;


import com.example.Tomorrow.Dao.Member;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class PostDto {
    private Long post_id;
    private String content;
    private String likes;
    private String comment;
    private String post_picture;
    private Member member;
    private String title;
}
