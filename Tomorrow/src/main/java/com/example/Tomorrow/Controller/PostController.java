package com.example.Tomorrow.Controller;

import com.example.Tomorrow.BasicResponse;
import com.example.Tomorrow.Dao.Post;
import com.example.Tomorrow.Dto.PostDto;
import com.example.Tomorrow.Jwt.JwtProvider;
import com.example.Tomorrow.Service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Slice;
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
    public ResponseEntity<BasicResponse> write(HttpServletResponse req,  @RequestBody PostDto postDto) {
        System.out.println("여기까지 된 건가!");
        String accessToken = req.getHeader("accessToken");
        String member_id = jwtProvider.getMemberIdFromToken(accessToken);

        return postService.write(Long.valueOf(member_id), postDto);
    }

    @GetMapping("/post/mywrite")
    public Slice<Post> getPosts(HttpServletRequest req,
                                @RequestParam Long start) {
        String accessToken = req.getHeader("accessToken");
        String member_id = jwtProvider.getMemberIdFromToken(accessToken);
        return postService.searchBySlice(start, Long.valueOf(member_id), PageRequest.ofSize(6));
    }
}
