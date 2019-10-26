package com.blog.service.impl;

import com.blog.mapper.LogMapper;
import com.blog.model.Log;
import com.blog.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LogServiceImpl implements LogService {
    @Autowired
    private LogMapper logMapper;

    @Override
    public int insert(Log log) {
        return logMapper.insert(log);
    }

    @Override
    public List<Log> findOrderByCreate() {
        return logMapper.findOrderByCreate();
    }

    @Override
    public List<Log> findAll() {
        return logMapper.findAll();
    }
}
