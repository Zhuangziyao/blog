package com.blog.service;

import com.blog.model.Comment;

import java.util.List;

public interface CommentService {
    int insert(Comment comment);

    List<Comment> findAll();

    List<Comment> findOrderByCreate();

    int findCount();

    int delete(int coid);

    int updateStatus(int coid);

    List<Comment> findByCid(int cid);
}
