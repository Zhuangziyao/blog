package com.blog.service.impl;

import com.blog.mapper.AttachMapper;
import com.blog.model.Attach;
import com.blog.service.AttachService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AttachServiceImpl implements AttachService {

    @Autowired
    private AttachMapper attachMapper;

    @Override
    public int insert(Attach attach) {
        return attachMapper.insert(attach);
    }

    @Override
    public int findCount() {
        return attachMapper.findCount();
    }

    @Override
    public int deleteById(int id) {
        return attachMapper.deleteById(id);
    }

    @Override
    public List<Attach> findAll() {
        return attachMapper.findAll();
    }

    @Override
    public String findPathById(int id) {
        return attachMapper.findPathById(id);
    }
}
