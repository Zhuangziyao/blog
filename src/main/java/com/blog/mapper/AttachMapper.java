package com.blog.mapper;

import com.blog.model.Attach;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AttachMapper {
    int insert(Attach attach);
    List<Attach> findAll();
    int findCount();
    int deleteById(@Param("id") int id);
    String findPathById(@Param("id") int id);
}
