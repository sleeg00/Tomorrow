package com.example.Tomorrow.Mapper;

import com.example.Tomorrow.Dao.Post;
import com.example.Tomorrow.Dto.PostDto;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface PostMapper extends EntityMapper<PostDto, Post>{
}
