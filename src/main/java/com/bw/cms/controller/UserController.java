package com.bw.cms.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bw.cms.domain.User;
import com.bw.cms.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class UserController {

	@Resource
	private UserService userService;
	
	@RequestMapping("users")
	public String users(User user,@RequestParam(defaultValue = "1")Integer page,@RequestParam(defaultValue = "3")Integer pageSize,Model model){
		PageInfo<User> info = userService.selects(user, page, pageSize);
		int[] nums = info.getNavigatepageNums();
		model.addAttribute("users", info.getList());//查出来的用户集合
		model.addAttribute("user", user);
		model.addAttribute("nums", nums);
		model.addAttribute("info", info);
		return "admin/user/users";
		
	}
	
	@RequestMapping("update")
	@ResponseBody
	public boolean update(User user){
		return userService.update(user);
	}
}
