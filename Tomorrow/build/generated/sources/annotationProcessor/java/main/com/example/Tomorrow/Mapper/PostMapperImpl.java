package com.example.Tomorrow.Mapper;

import com.example.Tomorrow.Dao.Member;
import com.example.Tomorrow.Dao.Post;
import com.example.Tomorrow.Dto.PostDto;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2023-03-03T19:47:54+0900",
    comments = "version: 1.5.3.Final, compiler: IncrementalProcessingEnvironment from gradle-language-java-7.6.jar, environment: Java 17.0.5 (Amazon.com Inc.)"
)
@Component
public class PostMapperImpl implements PostMapper {

    @Override
    public Post toEntity(PostDto dto) {
        if ( dto == null ) {
            return null;
        }

        Post post = new Post();

        post.setPost_id( dto.getPost_id() );
        post.setTag( dto.getTag() );
        post.setContent( dto.getContent() );
        post.setLikes( dto.getLikes() );
        post.setComment( dto.getComment() );
        post.setEmoticon( dto.getEmoticon() );

        return post;
    }

    @Override
    public PostDto toDto(Post entity) {
        if ( entity == null ) {
            return null;
        }

        Long post_id = null;
        String content = null;
        Long likes = null;
        String comment = null;
        String tag = null;
        String emoticon = null;

        post_id = entity.getPost_id();
        content = entity.getContent();
        likes = entity.getLikes();
        comment = entity.getComment();
        tag = entity.getTag();
        emoticon = entity.getEmoticon();

        String picture = null;
        Member member_id = null;

        PostDto postDto = new PostDto( post_id, content, likes, comment, picture, tag, member_id, emoticon );

        return postDto;
    }
}
