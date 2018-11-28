package com.blog.service;

import com.blog.model.Option;

import java.util.List;

public interface SettingService {
    int insert(Option option);
    int updateByName(List<Option> options);
    List<Option> findAll();
    String findBeiAnHao();
}
