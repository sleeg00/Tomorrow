package com.example.Tomorrow.Mapper;

import com.example.Tomorrow.Dao.Member;
import com.example.Tomorrow.Dao.Post;
import com.example.Tomorrow.Dto.MemberDto;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2023-02-26T22:27:30+0900",
    comments = "version: 1.5.3.Final, compiler: IncrementalProcessingEnvironment from gradle-language-java-7.6.jar, environment: Java 17.0.5 (Amazon.com Inc.)"
)
@Component
public class MemberMapperImpl implements MemberMapper {

    @Override
    public Member toEntity(MemberDto dto) {
        if ( dto == null ) {
            return null;
        }

        Member.MemberBuilder member = Member.builder();

        member.member_id( dto.getMember_id() );
        member.sex( dto.getSex() );
        member.year( dto.getYear() );
        List<Post> list = dto.getPosts();
        if ( list != null ) {
            member.posts( new ArrayList<Post>( list ) );
        }

        return member.build();
    }

    @Override
    public MemberDto toDto(Member entity) {
        if ( entity == null ) {
            return null;
        }

        Long member_id = null;
        List<Post> posts = null;
        String sex = null;
        String year = null;

        member_id = entity.getMember_id();
        List<Post> list = entity.getPosts();
        if ( list != null ) {
            posts = new ArrayList<Post>( list );
        }
        sex = entity.getSex();
        year = entity.getYear();

        MemberDto memberDto = new MemberDto( member_id, posts, sex, year );

        return memberDto;
    }
}
