package com.example.Tomorrow.Controller;

import com.example.Tomorrow.BasicResponse;
import com.example.Tomorrow.Dao.Member;
import com.example.Tomorrow.Dao.Post;
import com.example.Tomorrow.Dto.MemberDto;
import com.example.Tomorrow.Jwt.JwtProvider;
import com.example.Tomorrow.Repository.MemberRepository;
import com.example.Tomorrow.Service.MemberService;
import com.example.Tomorrow.Service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Slice;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequestMapping("/api")
@RestController
public class MemberController {
    @Autowired
    MemberService memberService;

    @Autowired
    private MemberRepository memberRepository;
    @Autowired
    JwtProvider jwtProvider;
    @Autowired
    PostService postService;

    @PostMapping("/member/join")
    public ResponseEntity<BasicResponse> join(HttpServletResponse res, @RequestBody MemberDto memberDto)throws Exception {

        return memberService.join(res, memberDto);
    }

    @PostMapping("/member/login")
    public HttpStatus login(@RequestBody MemberDto memberDto) {
        return memberService.login(memberDto);
    }

    @GetMapping("/home")
    public Slice<Post> getHome(HttpServletRequest req,
                                @RequestParam Long start) {
        String accessToken = req.getHeader("accessToken");
        String member_id = jwtProvider.getMemberIdFromToken(accessToken);
        return postService.searchBySliceHome(start, Long.valueOf(member_id), PageRequest.ofSize(6));
    }
}
