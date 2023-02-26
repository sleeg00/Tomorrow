package com.example.Tomorrow.Service;

import com.example.Tomorrow.BasicResponse;
import com.example.Tomorrow.Dao.Member;
import com.example.Tomorrow.Dao.Post;

import com.example.Tomorrow.Dto.MemberDto;
import com.example.Tomorrow.Jwt.JwtProvider;
import com.example.Tomorrow.Mapper.MemberMapper;
import com.example.Tomorrow.Repository.MemberRepository;
import com.example.Tomorrow.Repository.PostRepository;
import org.apache.coyote.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;


import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;
import java.util.Collections;
import java.util.HashMap;
import java.util.Optional;



@Service
@Transactional
public class MemberService {
    @Autowired
    MemberRepository memberRepository;
    MemberMapper memberMapper;
    @Autowired
    PostRepository postRepository;

    @Autowired
    JwtProvider jwtProvider;

    @Autowired
    CookieUtil cookieUtil;




    public ResponseEntity<BasicResponse> join(HttpServletResponse res, MemberDto memberDto) throws Exception {

        try {
            Member member = new Member();



            Post post = new Post();
            post.setComment(null);
            post.setPost_picture((long)((Math.random()*10000)%10));
            post.setLikes(0L);
            post.setMember(member);

            member.setRoles(Collections.singletonList("USER")); //권한 설정

            //RefreshToken 생성 및 쿠키화

            memberRepository.save(member);
            postRepository.save(post);

            HashMap<String, String> m = new HashMap<>();
            m.put("memberId", String.valueOf(member.getMember_id()));
            //Id, Pw로 Token 생성?...

            String accessToken, refreshToken;
            accessToken= jwtProvider.generateToken(m);
            refreshToken = jwtProvider.generateRefreshToken(m);

            res.setHeader("accessToken", accessToken);
            res.setHeader("refreshToken", refreshToken);

            BasicResponse basicResponse = new BasicResponse();
            if(accessToken!=null && refreshToken!=null) {
                basicResponse = BasicResponse.builder()
                        .code(HttpStatus.OK.value())
                        .httpStatus(HttpStatus.OK)
                        .message(accessToken)
                        .accessToken(accessToken)
                        .refreshToken(refreshToken)
                        .result(null)
                        .count(1).build();
            }
            return new ResponseEntity<>(basicResponse, basicResponse.getHttpStatus());
            //ResponseBody에 AccessToken 전달
        }catch(Exception e){
            throw new Exception(e.getMessage());
        }
    }

    public HttpStatus login(MemberDto memberDto) {
        System.out.println("성공!!!");
        try {


        }catch(Exception e) {
            return HttpStatus.BAD_REQUEST;
        }
        return HttpStatus.OK;
    }
}
