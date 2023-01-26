package com.example.Tomorrow.Controller;

import com.example.Tomorrow.BasicResponse;
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

    @PostMapping("/member/join")
    public ResponseEntity<BasicResponse> join(HttpServletResponse res, @RequestParam("member_id") Long member_id,
                                              @RequestParam("id") String id,
                                              @RequestParam("pw") String pw) throws Exception {
         return memberService.join(res,member_id, id,pw);
    }

    @PostMapping("/member/login")
    public HttpStatus login(@RequestParam("member_id") Long member_id) {
        return memberService.login(member_id);
    }

}
