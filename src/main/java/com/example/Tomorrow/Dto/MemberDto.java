package com.example.Tomorrow.Dto;

import com.example.Tomorrow.Dao.Post;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import java.util.ArrayList;
import java.util.List;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class MemberDto {

    private Long member_id;
    private List<Post> posts;
    private String id;
    private String pw;

}
