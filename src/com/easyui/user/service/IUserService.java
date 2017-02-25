package com.easyui.user.service;

import java.util.List;

import com.easyui.user.model.User;

public interface IUserService {

	/**
	 * 
	 * @param user
	 * @return
	 */
	public List<User> getUsers();
}
