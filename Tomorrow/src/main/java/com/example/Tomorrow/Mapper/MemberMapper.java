package com.example.Tomorrow.Mapper;

import com.example.Tomorrow.Dao.Member;
import com.example.Tomorrow.Dto.MemberDto;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface MemberMapper extends EntityMapper<MemberDto, Member> {
}
