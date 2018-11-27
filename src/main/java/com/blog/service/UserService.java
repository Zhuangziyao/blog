package com.blog.service;

import com.blog.model.User;

import java.util.List;

public interface UserService {
	List<User> findUserByNameAndPwd(String userName, String password);
	int addUser(User user);
	int deleteUserByName(String userName);
	int updateUserByName(User user);
	List<User> findUserByName(String userName);
	List<User> findAll();
}
