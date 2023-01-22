package com.example.Tomorrow.Controller;

import com.example.Tomorrow.Service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api")
@RestController
public class MemberController {
    @Autowired
    MemberService memberService;

    @PostMapping("/member/join")
    public String join(@RequestParam("member_id") Long member_id,
                       @RequestParam("id") String id,
                       @RequestParam("pw") String pw) {
         return memberService.join(member_id, id,pw);
    }

    @GetMapping("member/login")
    public HttpStatus login(@RequestParam("member_id") Long member_id) {
        return memberService.login(member_id);
    }

}
