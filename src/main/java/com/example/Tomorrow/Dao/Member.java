package com.example.Tomorrow.Dao;


import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;


@Entity
@Table(name = "member")
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Member {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long member_id;

    public List<Post> getList_post() {
        return List_post;
    }

    //양방향 매핑을 위해 추가했다
    @Builder.Default        //빌더가 있으면 초기화를 안 시켜줘서 어노테이션 추가 --> 초기화 완료
    @OneToMany(mappedBy= "member", cascade = CascadeType.ALL) //cascadeALl ->  Entity 따라감 모든 것을
    private List<Post> List_post = new ArrayList<>();

    public void setList_post(List<Post> list_post) {
        List_post = list_post;
    }

    public void addPost(Post post) { //Post가 Member당 여러개인데 새로운 Post를 추가해주는 메소드!
        this.List_post.add(post);
    }
}
