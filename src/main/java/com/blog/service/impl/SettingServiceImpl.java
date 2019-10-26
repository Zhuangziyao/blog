package com.blog.service.impl;

import com.blog.mapper.OptionMapper;
import com.blog.model.Option;
import com.blog.service.SettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SettingServiceImpl implements SettingService {

    @Autowired
    private OptionMapper optionMapper;

    @Override
    public int insert(Option option) {
        return optionMapper.insert(option);
    }

    @Override
    public int updateByName(List<Option> options) {
        int result = 0;
        for (int i = 0; i < options.size(); i++) {
            int r = optionMapper.updateByName(options.get(i));
            result += r;
        }
        return result;
    }

    @Override
    public List<Option> findAll() {
        return optionMapper.findAll();
    }

    @Override
    public String findBeiAnHao() {
        return optionMapper.findRecord();
    }
}
