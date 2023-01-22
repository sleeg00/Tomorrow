package com.example.Tomorrow.Service;

import com.example.Tomorrow.Dao.Member;
import com.example.Tomorrow.Dao.Post;
import com.example.Tomorrow.Dto.PostDto;
import com.example.Tomorrow.Mapper.PostMapper;
import com.example.Tomorrow.Repository.MemberRepository;
import com.example.Tomorrow.Repository.PostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;

@Service
public class PostService {

    @Autowired
    PostRepository postRepository;
    PostMapper postMapper;
    MemberRepository memberRepository;

    public void write(Long member_id, PostDto postDto) {
        Member member = new Member();
        member.setMember_id(member_id);

        Post post = postMapper.toEntity(postDto);
        post.getMember().getPosts().add(post);

        postRepository.save(post);
        memberRepository.save(member);
    }

    public void memberSearch(Long id) {
        Post post = postRepository.findById(id).get();
        Member member = post.getMember();
    }
}
