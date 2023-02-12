package com.example.Tomorrow.Mapper;

import com.example.Tomorrow.Dao.Post;
import com.example.Tomorrow.Dto.PostDto;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2023-02-06T22:50:42+0900",
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
        post.setTitle( dto.getTitle() );
        post.setContent( dto.getContent() );
        post.setPost_picture( dto.getPost_picture() );
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

        PostDto postDto = new PostDto();

        postDto.setPost_id( entity.getPost_id() );
        postDto.setContent( entity.getContent() );
        postDto.setLikes( entity.getLikes() );
        postDto.setComment( entity.getComment() );
        postDto.setPost_picture( entity.getPost_picture() );
        postDto.setTitle( entity.getTitle() );
        postDto.setEmoticon( entity.getEmoticon() );

        return postDto;
    }
}
