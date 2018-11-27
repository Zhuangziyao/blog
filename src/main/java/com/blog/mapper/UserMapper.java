package com.blog.mapper;

import com.blog.model.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface UserMapper {
    //登录判断
    List<User> findUserByNameAndPwd(@Param("userName") String userName, @Param("password") String password);
    //添加
    int addUser(User user);
    //删除
    int deleteUserByName(@Param("userName") String userName);
    //更新
    int updateUserByName(User user);
    //判断用户是否存在
    List<User> findUserByName(@Param("userName") String userName);

    List<User> findAll();
}
