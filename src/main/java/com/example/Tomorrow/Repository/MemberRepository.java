package com.example.Tomorrow.Repository;

import com.example.Tomorrow.Dao.Member;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<Member, Long> {


}
