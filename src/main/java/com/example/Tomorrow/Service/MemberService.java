package com.example.Tomorrow.Service;

import com.example.Tomorrow.BasicResponse;
import com.example.Tomorrow.Dao.Member;
import com.example.Tomorrow.Dao.Post;

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




    public ResponseEntity<BasicResponse> join(HttpServletResponse res, Long member_id, String id, String pw) throws Exception {

        try {
            Member member = new Member();
            member.setMember_id(member_id);
            member.setId(id);
            member.setPw(pw);


            System.out.println("start post");
            Post post = new Post();
            post.setComment("Comment");
            post.setPost_picture("PI");
            post.setContent("content");
            post.setTitle("title");
            post.setLikes("LIkes");
            post.setMember(member);

            member.setRoles(Collections.singletonList("USER"));
            HashMap<String, String> m = new HashMap<>();
            m.put("Id", member.getId());

            String accessToken, refreshToken;
            accessToken= jwtProvider.generateToken(m);
            refreshToken = jwtProvider.generateRefreshToken(m);

            Cookie refreshCookie = cookieUtil.createCookie("RefreshToken", refreshToken);
            //RefreshToken 생성 및 쿠키화

            memberRepository.save(member);
            postRepository.save(post);
            res.addCookie(refreshCookie);   //응답에 쿠키 넘겨주기!

            BasicResponse basicResponse = new BasicResponse();
            if(accessToken!=null && refreshToken!=null) {
                basicResponse = BasicResponse.builder()
                        .code(HttpStatus.OK.value())
                        .httpStatus(HttpStatus.OK)
                        .message(accessToken)
                        .result(null)
                        .count(1).build();
            }
            return new ResponseEntity<>(basicResponse, basicResponse.getHttpStatus());
            //ResponseBody에 AccessToken 전달
        }catch(Exception e){
            throw new Exception(e.getMessage());
        }
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
