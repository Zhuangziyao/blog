package com.blog.service;

import com.blog.model.Meta;
import com.blog.model.MetaDto;

import java.util.List;

public interface MetaService {
    List<Meta> findMetaByType(String type);

    int updateById(Meta meta);

    int deleteById(int id);

    int insert(Meta meta);

    List<MetaDto> findMetaDtoByType(String type);

    int findCountByType(String type);

    int findCountByName(String name);
}
