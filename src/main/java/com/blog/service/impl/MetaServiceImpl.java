package com.blog.service.impl;

import com.blog.mapper.MetaMapper;
import com.blog.model.Meta;
import com.blog.model.MetaDto;
import com.blog.service.MetaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MetaServiceImpl implements MetaService {

    @Autowired
    private MetaMapper metaDAO;

    @Override
    public List<Meta> findMetaByType(String type) {
        // TODO Auto-generated method stub
        return metaDAO.findMetaByType(type);
    }

    @Override
    public int updateById(Meta meta) {
        // TODO Auto-generated method stub
        return metaDAO.updateById(meta);
    }

    @Override
    public int deleteById(int id) {
        // TODO Auto-generated method stub
        return metaDAO.deleteById(id);
    }

    @Override
    public int insert(Meta meta) {
        // TODO Auto-generated method stub
        return metaDAO.insert(meta);
    }

    @Override
    public int findCountByType(String type) {
        return metaDAO.findCountByType(type);
    }

    @Override
    public List<MetaDto> findMetaDtoByType(String type) {
        return metaDAO.findMetaDtoByType(type);
    }

    @Override
    public int findCountByName(String name) {
        return metaDAO.findCountByName(name);
    }
}
