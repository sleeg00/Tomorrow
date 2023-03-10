package com.example.Tomorrow.Service;

import com.example.Tomorrow.BasicResponse;
import com.example.Tomorrow.Dao.Member;
import com.example.Tomorrow.Dao.Post;
import com.example.Tomorrow.Dto.PostDto;
import com.example.Tomorrow.Mapper.PostMapper;
import com.example.Tomorrow.Repository.MemberRepository;
import com.example.Tomorrow.Repository.PostRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class PostService {

    @Autowired
    PostRepository postRepository;
    @Autowired
    PostMapper postMapper;
    @Autowired
    MemberRepository memberRepository;

    @Autowired
    PostRepositoryImpl postRepositoryImpl;
    public ResponseEntity<BasicResponse> write(Long member_id, PostDto postDto) {

        Member member = memberRepository.findById(member_id).orElseGet(Member::new);
        //Optional<Member> example = memberRepository.findById(member_id)
        //Member member = example.orElseGet(Member::new) 코드를 한 줄로 줄였다 만약 널이 아니라면 저장하는 것

        Post post = new Post();



        post.setMember(member);
        post.setContent(postDto.getContent());
        post.setEmoticon(postDto.getEmoticon());
        post.setLikes(0L);
        member.addPost(post);   //List에 더 하기

        memberRepository.save(member);
        postRepository.save(post);
        BasicResponse basicResponse = BasicResponse.builder()
                .code(HttpStatus.OK.value())
                .httpStatus(HttpStatus.OK)
                .message("저장 성공!")
                .result(null)
                .count(1).build();

        return new ResponseEntity<>(basicResponse, basicResponse.getHttpStatus());
    }
    public Slice<Post> searchBySlice(Long start, Long member_id,
                                     Pageable pageable){
        return postRepositoryImpl.searchBySlice(start, member_id, pageable);
    }

    public Slice<Post> searchBySliceHome(Long start, Long member_id,
                                     Pageable pageable){
        return postRepositoryImpl.searchBySliceHome(start, member_id, pageable);
    }

}
