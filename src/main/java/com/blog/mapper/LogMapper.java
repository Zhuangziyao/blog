package com.blog.mapper;

import com.blog.model.Log;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LogMapper {
    int insert(Log log);
    List<Log> findAll();
    List<Log> findOrderByCreate();
}
