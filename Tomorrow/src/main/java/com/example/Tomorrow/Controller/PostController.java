package com.example.Tomorrow.Controller;

import com.example.Tomorrow.BasicResponse;
import com.example.Tomorrow.Dto.PostDto;
import com.example.Tomorrow.Jwt.JwtProvider;
import com.example.Tomorrow.Service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@RequestMapping("/api")
@RestController
public class PostController {

    @Autowired
    PostService postService;

    @Autowired
    JwtProvider jwtProvider;

    @PostMapping("/post/write")
    public ResponseEntity<BasicResponse> write(HttpServletRequest req,  @RequestBody PostDto postDto) {
        String accessToken = req.getHeader("accessToken");
        String member_id = jwtProvider.getMemberIdFromToken(accessToken);

        return postService.write(Long.valueOf(member_id), postDto);
    }
}
