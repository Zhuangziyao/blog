package com.blog.service;

import com.blog.model.Attach;

import java.util.List;

public interface AttachService {
    int insert(Attach attach);

    int findCount();

    int deleteById(int id);

    List<Attach> findAll();

    String findPathById(int id);
}
