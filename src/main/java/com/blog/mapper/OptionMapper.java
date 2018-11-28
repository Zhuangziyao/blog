package com.blog.mapper;

import com.blog.model.Option;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OptionMapper {
    int insert(Option option);
    int updateByName(@Param("option") Option option);
    List<Option> findAll();
    String findRecord();
}
