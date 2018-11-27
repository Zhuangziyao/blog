package com.blog.mapper;

import com.blog.model.Meta;
import com.blog.model.MetaDto;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface MetaMapper {
    List<Meta> findMetaByType(@Param("type") String type);
    int updateById(Meta meta);
    int deleteById(@Param("mid") int id);
    int insert(Meta meta);
    List<MetaDto> findMetaDtoByType(@Param("type") String type);
    int findCountByType(@Param("type") String type);
    int findCountByName(@Param("name") String name);
}
