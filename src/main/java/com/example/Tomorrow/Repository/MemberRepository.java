package com.example.Tomorrow.Repository;

import com.example.Tomorrow.Dao.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {



}
