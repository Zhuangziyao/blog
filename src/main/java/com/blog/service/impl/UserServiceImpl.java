package com.blog.service.impl;

import com.blog.mapper.UserMapper;
import com.blog.model.User;
import com.blog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userDAO;

    @Override
    public List<User> findUserByNameAndPwd(String userName, String password) {
        return userDAO.findUserByNameAndPwd(userName, password);
    }

    @Override
    public int addUser(User user) {
        return userDAO.addUser(user);
    }

    @Override
    public int deleteUserByName(String userName) {
        return userDAO.deleteUserByName(userName);
    }

    @Override
    public int updateUserByName(User user) {
        return userDAO.updateUserByName(user);
    }

    @Override
    public List<User> findUserByName(String userName) {
        return userDAO.findUserByName(userName);
    }

    @Override
    public List<User> findAll() {
        return userDAO.findAll();
    }
}
