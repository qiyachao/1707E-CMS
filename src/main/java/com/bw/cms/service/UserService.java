package com.bw.cms.service;

import java.util.List;

import com.bw.cms.domain.User;
import com.bw.cms.vo.UserVO;
import com.github.pagehelper.PageInfo;

public interface UserService {
	//用户列表
	PageInfo<User> selects(User user,Integer page,Integer pageSize);
	//修改账户状态
	boolean update(User user);
	//注册
	boolean insertSelective(UserVO userVO);
	//登录
	User login(User user);
	
	
}
