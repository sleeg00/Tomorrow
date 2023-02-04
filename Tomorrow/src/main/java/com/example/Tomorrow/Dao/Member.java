package com.example.Tomorrow.Dao;


import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;


@Entity
@Table(name = "member")
@Getter
@Setter
@Data
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class Member implements UserDetails {

    @Id
    @Column(name = "member_id")
    private Long member_id;

    @Column(name = "id")
    private String id;

    @Column(name = "pw")
    private String pw;


    @OneToMany(mappedBy= "member") //cascadeALl ->  Entity 따라감 모든 것을
    @JsonBackReference //순환참조 방지
    private List<Post> posts = new ArrayList<Post>();

    @ElementCollection(fetch = FetchType.EAGER)
    @Builder.Default
    private List<String> roles = new ArrayList<>();



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


    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return this.roles.stream()
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toList());
    }

    @Override
    public String getPassword() {
        return pw;
    }

    @Override
    public String getUsername() {
        return id;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

}
