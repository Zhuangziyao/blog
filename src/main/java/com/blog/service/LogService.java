package com.blog.service;

import com.blog.model.Log;

import java.util.List;

public interface LogService {
    int insert(Log log);

    List<Log> findOrderByCreate();

    List<Log> findAll();

}
