package com.blog.service.impl;

import com.blog.mapper.RelationshipMapper;
import com.blog.service.RelationshipService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Description:relationship service impl
 *
 * @authror: zhuangziyao
 * @date: 2018/9/23 11:02
 **/
@Service
public class RelationshipServiceImpl implements RelationshipService {

    @Autowired
    private RelationshipMapper relationshipMapper;

    @Override
    public int insert(int cid, int mid) {
        return relationshipMapper.insert(cid,mid);
    }

    @Override
    public int delete(int cid,int mid) {
        return relationshipMapper.delete(cid,mid);
    }

    @Override
    public int findCount(int mid) {
        return relationshipMapper.findCount(mid);
    }

    @Override
    public int deleteAll(int cid) {
        return relationshipMapper.deleteAll(cid);
    }
}
