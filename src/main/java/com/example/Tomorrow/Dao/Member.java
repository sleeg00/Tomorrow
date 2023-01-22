package com.example.Tomorrow.Dao;


import lombok.*;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

import static javax.persistence.GenerationType.IDENTITY;


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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long member_id;

    @Column(name = "id")
    private String id;

    @Column(name = "pw")
    private String pw;


    @OneToMany(mappedBy= "member") //cascadeALl ->  Entity 따라감 모든 것을
    private List<Post> posts = new ArrayList<>();





    public void updateMember(long member_id) {
        this.member_id=member_id;
    }

    public void addPost(Post post) {
        this.posts.add(post);
    }

}
