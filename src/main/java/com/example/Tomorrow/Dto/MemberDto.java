package com.example.Tomorrow.Dto;

import com.example.Tomorrow.Dao.Post;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class MemberDto {

    private Long post_id;
    private List<Post> List_post = new ArrayList<>();
}
