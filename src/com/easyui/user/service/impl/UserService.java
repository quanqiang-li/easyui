package com.easyui.user.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easyui.user.dao.UserMapper;
import com.easyui.user.model.User;
import com.easyui.user.service.IUserService;
@Service
public class UserService implements IUserService{

	@Autowired
	private UserMapper userMapper;
	
	@Override
	public List<User> getUsers() {
		
		return userMapper.selectByExample(null);
	}
}
