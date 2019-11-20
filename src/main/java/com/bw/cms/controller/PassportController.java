package com.bw.cms.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bw.cms.domain.User;
import com.bw.cms.service.UserService;
import com.bw.cms.utils.CMSException;
import com.bw.cms.vo.UserVO;
@RequestMapping("passport")
@Controller
public class PassportController {

	@Resource
	private UserService userService;
	/**
	 * 
	 * @Title: reg 
	 * @Description: 去注册
	 * @return
	 * @return: String
	 */
	@GetMapping("reg")
	public String reg() {
		
		return "passport/reg";
		
	}
	/**
	 * 
	 * @Title: login 
	 * @Description: 去登录
	 * @return
	 * @return: String
	 */
	@GetMapping("login")
	public String login() {
		
		return "passport/login";
		
	}
	/**
	 * 
	 * @Title: reg 
	 * @Description:注册
	 * @param model
	 * @param userVO
	 * @param redirectAttributes
	 * @return
	 * @return: String
	 */
	@PostMapping("reg")
	public String reg(Model model,UserVO userVO,RedirectAttributes redirectAttributes) {
		try {
			boolean b = userService.insertSelective(userVO);//注册账号
			if(b) {
				redirectAttributes.addAttribute("username", userVO.getUsername());//重定向携带参数到登录页面
				redirectAttributes.addAttribute("messages", "恭喜,注册成功");//重定向携带参数
				return "redirect:/passport/login";//注册成功,重定向到登录页面
			}
		} catch (CMSException e) {
			e.printStackTrace();
			//封装到model，用于在页面回显提示用户
			model.addAttribute("messages", e.getMessage());
		}catch (Exception e) {
			model.addAttribute("message", "系统异常.请联系管理员");
		}
		return "passport/reg";
		
	}
	/**
	 * 
	 * @Title: login 
	 * @Description: 登录
	 * @param user
	 * @param model
	 * @param session
	 * @return
	 * @return: String
	 */
	@PostMapping("login")
	public String login(User user,Model model,HttpSession session) {
		try {
			User u = userService.login(user);
			if(u.getRole().equals("1")) {//判断是管理员还是普通注册用户
				session.setAttribute("admin", u);
				return "redirect:/admin";//管理员进入管理员后台
				
			}else {
				session.setAttribute("user", u);//普通注册用户进入用户后台
				return "redirect:/my";
			}
		}catch (CMSException e) {
			e.printStackTrace();
			//封装到model,用于提示用户
			model.addAttribute("messages", e.getMessage());
		}catch (Exception e) {
			model.addAttribute("message", "系统异常.请联系管理员");
		}
		return "passport/login";
	}
	/**
	 * 
	 * @Title: logout 
	 * @Description: 退出登录
	 * @param request
	 * @return
	 * @return: String
	 */
	@GetMapping("logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession(false);//getSession(false)中false:如果request没有session返回null.true:如果没有则创建session.默认true
		if(null!=session)//如果session不等于空
		session.invalidate();//清空session
		return "redirect:/passport/login";//返回登录页面
	}
}
