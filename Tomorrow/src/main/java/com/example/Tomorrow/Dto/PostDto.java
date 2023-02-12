package com.example.Tomorrow.Dto;


import com.example.Tomorrow.Dao.Member;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Optional;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PostDto {
    private Long post_id;
    private String content;
    private Long likes;
    private String comment;
    private Long post_picture;
    private String title;
    private Member member_id;
    private String emoticon;
}
