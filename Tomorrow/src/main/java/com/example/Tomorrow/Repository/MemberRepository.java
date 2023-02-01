package com.example.Tomorrow.Repository;

import com.example.Tomorrow.Dao.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {




    String findById(String id);


    String findByPw(String pw);
}
