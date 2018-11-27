package com.blog.service.impl;

import com.blog.mapper.CommentMapper;
import com.blog.model.Comment;
import com.blog.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentMapper commentMapper;

    @Override
    public int insert(Comment comment) {
        return commentMapper.insert(comment);
    }

    @Override
    public List<Comment> findOrderByCreate() {
        return commentMapper.findOrderByCreate();
    }

    @Override
    public List<Comment> findAll() {
        return commentMapper.findAll();
    }

    @Override
    public int findCount() {
        return commentMapper.findCount();
    }

    @Override
    public int delete(int coid) {
        return 0;
    }

    @Override
    public int updateStatus(int coid) {
        return 0;
    }

    @Override
    public List<Comment> findByCid(int cid){
        return commentMapper.findByCid(cid);
    }
}
