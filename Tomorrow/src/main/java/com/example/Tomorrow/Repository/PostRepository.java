package com.example.Tomorrow.Repository;

import com.example.Tomorrow.Dao.Member;
import com.example.Tomorrow.Dao.Post;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PostRepository extends JpaRepository<Post, Long>{


    Post findByMemberId(Long member_id);

    List<Post> findByMember(Member member);


}
