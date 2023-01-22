package com.example.Tomorrow.Service;

import com.example.Tomorrow.Dao.Member;
import com.example.Tomorrow.Dao.Post;

import com.example.Tomorrow.Mapper.MemberMapper;
import com.example.Tomorrow.Repository.MemberRepository;
import com.example.Tomorrow.Repository.PostRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;


import javax.transaction.Transactional;
import java.util.Optional;



@Service
@Transactional
public class MemberService {

    @Autowired
   MemberRepository memberRepository;
   MemberMapper memberMapper;
   @Autowired
    PostRepository postRepository;





    public String join(Long member_id, String id, String pw) {

        try {
            Member member = new Member();
            member.setId("@@");
            member.setPw("@@");


            Post post = new Post();
            post.setComment("Comment");
            post.setPost_picture("PI");
            post.setContent("content");
            post.setLikes("LIkes");
            post.setMember(member);

            postRepository.save(post);
        }catch(Exception e){
            return e.getMessage();
        }

        return "1";
    }

    public HttpStatus login(Long member_id) {

        try {
            Optional<Member> check = memberRepository.findById(member_id);
        }catch(Exception e) {
            return HttpStatus.BAD_REQUEST;
        }
        return HttpStatus.OK;
    }
}
