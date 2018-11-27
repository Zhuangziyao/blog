package com.blog.mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface RelationshipMapper {
    int insert(@Param("cid") int cid,@Param("mid") int mid);
    int delete(@Param("cid") int cid,@Param("mid") int mid);
    int deleteAll(@Param("cid") int cid);
    int findCount(@Param("mid") int mid);
}
