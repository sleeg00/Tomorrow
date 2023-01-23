package com.example.Tomorrow.Service;

import com.example.Tomorrow.BasicResponse;
import com.example.Tomorrow.Dao.Member;
import com.example.Tomorrow.Dao.Post;
import com.example.Tomorrow.Dto.PostDto;
import com.example.Tomorrow.Mapper.PostMapper;
import com.example.Tomorrow.Repository.MemberRepository;
import com.example.Tomorrow.Repository.PostRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PostService {

    @Autowired
    PostRepository postRepository;
    PostMapper postMapper;
    @Autowired
    MemberRepository memberRepository;

    public ResponseEntity<BasicResponse> write(Long member_id, PostDto postDto) {

        Member member = memberRepository.findById(member_id).orElseGet(Member::new);
        //Optional<Member> example = memberRepository.findById(member_id)
        //Member member = example.orElseGet(Member::new) 코드를 한 줄로 줄였다 만약 널이 아니라면 저장하는 것

        BasicResponse basicResponse = new BasicResponse();
        if(member.getMember_id()==null){
            basicResponse = BasicResponse.builder()
                    .code(HttpStatus.BAD_REQUEST.value())
                    .httpStatus(HttpStatus.BAD_REQUEST)
                    .message("아이디에 맞는 사용자가 없습니다")
                    .result(null)
                    .count(1).build();
        }
        Post post = new Post();
        post.setPost_picture(postDto.getPicture());
        post.setComment(postDto.getComment());
        post.setTitle(postDto.getTitle());
        post.setMember(member);
        post.setContent(postDto.getContent());
        member.addPost(post);

        memberRepository.save(member);
        postRepository.save(post);
        basicResponse = BasicResponse.builder()
                .code(HttpStatus.OK.value())
                .httpStatus(HttpStatus.OK)
                .message("저장 성공!")
                .result(null)
                .count(1).build();
        return new ResponseEntity<>(basicResponse, basicResponse.getHttpStatus());
    }

    public void memberSearch(Long id) {
        Post post = postRepository.findById(id).get();
        Member member = post.getMember();
    }
}
