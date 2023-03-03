package com.example.Tomorrow.Service;

import com.example.Tomorrow.Repository.MemberRepository;
import com.querydsl.jpa.impl.JPAQueryFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;

@Service
public class HomeService {

    @Autowired
    MemberRepository memberRepository;

    private final EntityManager em;
    private final JPAQueryFactory query;


    public HomeService(EntityManager em, JPAQueryFactory query) {
        this.em = em;
        this.query = query;
    }


}
