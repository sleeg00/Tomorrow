package com.example.Tomorrow.Repository;

import com.example.Tomorrow.Dao.Post;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PostRepository extends JpaRepository<Post, Long> {
    static void save(String content) {
    }
}
