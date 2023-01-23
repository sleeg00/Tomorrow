package com.example.Tomorrow.Dto;


import com.example.Tomorrow.Dao.Member;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Optional;

@Getter
@Setter
@AllArgsConstructor
public class PostDto {
    private Long post_id;
    private String content;
    private String likes;
    private String comment;
    private String picture;
    private String title;
    private Member member_id;
}
