package com.example.Tomorrow.Service;

import com.example.Tomorrow.Dao.Member;
import com.example.Tomorrow.Repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class MemberService {

    @Autowired
    MemberRepository memberRepository;

    public HttpStatus join(Long member_id) {
        try {
            Member member = new Member();
            member.setMember_id(member_id);
            memberRepository.save(member);
        }catch(Exception e){
            return HttpStatus.BAD_REQUEST;
        }
        return HttpStatus.OK;
    }

    public HttpStatus login(Long member_id) {

        try {
            Optional<Member> check = memberRepository.findById(member_id);
        }catch(Exception e) {
            return HttpStatus.BAD_REQUEST;
        }
        return HttpStatus.OK;
    }
}
