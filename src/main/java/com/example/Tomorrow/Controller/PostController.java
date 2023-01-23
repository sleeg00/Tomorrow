package com.example.Tomorrow.Controller;

import com.example.Tomorrow.BasicResponse;
import com.example.Tomorrow.Dto.PostDto;
import com.example.Tomorrow.Service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api")
@RestController
public class PostController {

    @Autowired
    PostService postService;

    @PostMapping("/post/write")
    public ResponseEntity<BasicResponse> write(@RequestParam("member_id") Long member_id, @RequestBody PostDto postDto) {
        return postService.write(member_id, postDto);
    }
}
