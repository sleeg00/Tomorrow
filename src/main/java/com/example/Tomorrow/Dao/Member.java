package com.example.Tomorrow.Dao;


import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;


@Entity
@Table(name = "member")
@Getter
@Setter
@Data
@NoArgsConstructor
@AllArgsConstructor

public class Member {

    @Id
    @Column(name = "member_id")
    private Long member_id;

    @Column(name = "id")
    private String id;

    @Column(name = "pw")
    private String pw;


    @OneToMany(mappedBy= "member") //cascadeALl ->  Entity 따라감 모든 것을
    private List<Post> posts = new ArrayList<Post>();





    public void updateMember(long member_id) {
        this.member_id=member_id;
    }

    public void addPost(Post post) {
        this.posts.add(post);
    }

    public int checkPost(){
        return this.posts.size();
    }

    public List<Post> getPosts() {
        return posts;
    }
}
