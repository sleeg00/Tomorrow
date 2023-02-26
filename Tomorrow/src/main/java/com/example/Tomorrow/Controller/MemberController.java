package com.example.Tomorrow.Controller;

import com.example.Tomorrow.BasicResponse;
import com.example.Tomorrow.Dao.Member;
import com.example.Tomorrow.Dto.MemberDto;
import com.example.Tomorrow.Repository.MemberRepository;
import com.example.Tomorrow.Service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;

@RequestMapping("/api")
@RestController
public class MemberController {
    @Autowired
    MemberService memberService;

    @Autowired
    private MemberRepository memberRepository;

    @PostMapping("/member/join")
    public ResponseEntity<BasicResponse> join(HttpServletResponse res, @RequestBody MemberDto memberDto)throws Exception {

        return memberService.join(res, memberDto);
    }

    @PostMapping("/member/login")
    public HttpStatus login(@RequestBody MemberDto memberDto) {
        return memberService.login(memberDto);
    }


}
