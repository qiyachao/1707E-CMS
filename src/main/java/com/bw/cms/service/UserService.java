package com.bw.cms.service;

import java.util.List;

import com.bw.cms.domain.User;
import com.github.pagehelper.PageInfo;

public interface UserService {

	PageInfo<User> selects(User user,Integer page,Integer pageSize);

	boolean update(User user);
	
	
}
