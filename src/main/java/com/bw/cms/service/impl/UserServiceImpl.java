package com.bw.cms.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.bw.cms.dao.UserMapper;
import com.bw.cms.domain.User;
import com.bw.cms.service.UserService;
import com.bw.cms.utils.CMSException;
import com.bw.cms.utils.Md5Util;
import com.bw.cms.vo.UserVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qiyachao.util.StringUtil;
@Service
public class UserServiceImpl implements UserService {

	@Resource
	private UserMapper userMapper;
	//查询用户
	@Override
	public PageInfo<User> selects(User user,Integer page,Integer pageSize) {
		PageHelper.startPage(page, pageSize);
		List<User> users = userMapper.selects(user);
		return new PageInfo<User>(users);
	}
	//修改账户使用状态
	@Override
	public boolean update(User user) {
		try {
			userMapper.updateByPrimaryKeySelective(user);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("操作失败");
		}
		
	}
	/**
	 * 注册账号
	 */
	@Override
	public boolean insertSelective(UserVO userVO) {
		//判断注册信息是否满足要求
		if(!StringUtil.hasText(userVO.getUsername()))
			throw new CMSException("用户名不能为空");
		if(!StringUtil.hasText(userVO.getPassword()))
			throw new CMSException("密码不能为空");
		if(!StringUtil.hasText(userVO.getPassword()))
			throw new CMSException("确认密码不能为空");
		if(!userVO.getPassword().equals(userVO.getRepassword()))
			throw new CMSException("两次密码不一致");
		//判断用户名是否重复
		User u = userMapper.selectByName(userVO.getUsername());
		if(u!=null) 
			throw new CMSException("用户名不能重复注册");
		//对密码进行加密保存
		userVO.setPassword(Md5Util.md5Encoding(userVO.getPassword()));
		//用户注册的其他属性默认值
		userVO.setNickname(userVO.getUsername());
		userVO.setCreated(new Date());//注册时间
		
		return userMapper.insertSelective(userVO)>0;
	}
	//登录
	@Override
	public User login(User user) {
		if(!StringUtil.hasText(user.getUsername()))
			throw new CMSException("用户名不能为空");
		if(!StringUtil.hasText(user.getPassword()))
			throw new CMSException("密码不能为空");
		//判断用户名是否存在
		User u = userMapper.selectByName(user.getUsername());
		if(u==null) {
			throw new CMSException("用户名不存在");
		}else if(u.getLocked()==1) {
			throw new CMSException("账户被禁用");
		}else if(!Md5Util.md5Encoding(user.getPassword()).equals(u.getPassword())){
			
			throw new CMSException("密码不正确");
		}
		return u;
	}

}
