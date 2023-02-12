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
    date = "2023-02-06T22:50:42+0900",
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
        member.id( dto.getId() );
        member.pw( dto.getPw() );
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
        String id = null;
        String pw = null;

        member_id = entity.getMember_id();
        List<Post> list = entity.getPosts();
        if ( list != null ) {
            posts = new ArrayList<Post>( list );
        }
        id = entity.getId();
        pw = entity.getPw();

        MemberDto memberDto = new MemberDto( member_id, posts, id, pw );

        return memberDto;
    }
}
