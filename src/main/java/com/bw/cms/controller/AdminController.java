package com.bw.cms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {

	/**
	 * 
	 * @Title: index 
	 * @Description: 跳转到index页面
	 * @return
	 * @return: String
	 */
	@RequestMapping("index")
	public String index() {
		
		return "admin/index";
		
	}
}
