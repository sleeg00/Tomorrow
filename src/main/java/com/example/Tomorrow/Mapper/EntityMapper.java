package com.example.Tomorrow.Mapper;

public interface EntityMapper <D, E>{
    E toEntity (D dto);
    D toDto (E entity);
}
