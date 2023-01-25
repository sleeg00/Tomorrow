package com.example.Tomorrow.Service;

import com.example.Tomorrow.Dao.Member;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

public class Details extends User {

    public Details(Member member) {
        super(member.getMember_id(), member.getPw(),
                AuthorityUtils.createAuthorityList(String.valueOf(member.getRoles())));
    }

    public String getMemberId() {
        return this.getPassword();
    }

}
