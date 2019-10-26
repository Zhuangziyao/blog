package com.blog.mapper;

import com.blog.model.Comment;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentMapper {
    int insert(Comment comment);

    List<Comment> findAll();

    List<Comment> findOrderByCreate();

    int findCount();

    int delete(@Param("coid") int coid);

    int updateStatus(@Param("coid") int coid);

    List<Comment> findByCid(@Param("cid") int cid);
}
