package com.bw.cms.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.apache.bcel.classfile.Field;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bw.cms.domain.Article;
import com.bw.cms.domain.ArticleWithBLOBs;
import com.bw.cms.domain.User;
import com.bw.cms.service.ArticleService;
import com.github.pagehelper.PageInfo;
@RequestMapping("my")
@Controller
public class MyController {
	
	@Resource
	private ArticleService articleService;
	/**
	 * @Title: index 
	 * @Description: 去个人中心首页
	 * @return
	 * @return: String
	 */
	@RequestMapping(value = {"","/","index"})
	public String index() {
		
		return "my/index";
		
	}
	/**
	 * 
	 * @Title: publish 
	 * @Description: 去增加文章发布文章
	 * @return
	 * @return: String
	 */
	@GetMapping("publish")
	public String publish() {
		return "my/article/publish";
	}
	/**
	 * 
	 * @Title: publish 
	 * @Description: 增加发布文章
	 * @param request
	 * @param article
	 * @param file
	 * @return
	 * @return: boolean
	 */
	@PostMapping("publish")
	@ResponseBody
	public boolean publish(HttpServletRequest request,ArticleWithBLOBs article,MultipartFile file) {
		//判断文件是否为空
		if(!file.isEmpty()) {
			//文件上传路径，把文件放入resource/pic下
			String path = request.getSession().getServletContext().getRealPath("/resource/pic");
			//为了防止文件重名，使用uuid的方式重命名上传文件
			String oldname = file.getOriginalFilename();
			String newFilename = UUID.randomUUID()+oldname.substring(oldname.lastIndexOf("."));
			 File f = new File(path,newFilename);
			 //写入硬盘
			 try {
				file.transferTo(f);
				article.setPicture(newFilename);//标题图片
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		//初始化设置
		article.setStatus(0);//待审核
		HttpSession session = request.getSession(false);
		if(session==null) {
			return false;
		}
		User user = (User) session.getAttribute("user");
		article.setUserId(user.getId());//发布人
		article.setHot(0);
		article.setHits(0);
		article.setDeleted(0);
		article.setCreated(new Date());
		article.setUpdated(new Date());
		
		return articleService.insertSelective(article);
		
	}
	/**
	 * 
	 * @Title: detail 
	 * @Description: 查询文章详情
	 * @param id
	 * @return
	 * @return: String
	 */
	@RequestMapping("article")
	public String detail(Integer id,Model model) {
		ArticleWithBLOBs article = articleService.selectByPrimaryKey(id);
		model.addAttribute("article", article);
		return "/my/article/article";
		
	}
	/**
	 * 返回我的文章
	 * @Title: selectByUser 
	 * @Description:返回我的文章
	 * @param model
	 * @param page
	 * @param pageSize
	 * @return
	 * @return: String
	 */
	@RequestMapping("selectByUser")
	public String selectByUser(HttpServletRequest request,Model model,@RequestParam(defaultValue = "1")Integer page,@RequestParam(defaultValue = "3")Integer pageSize) {
		Article a = new Article();
		HttpSession session = request.getSession(false);
		if(session==null) {
			return "redirect:/passport.login";//session可能过期
		}
		User user = (User) session.getAttribute("user");
		a.setUserId(user.getId());
		PageInfo<Article> info = articleService.selects(a, page, pageSize);
		model.addAttribute("info", info);
		return "my/article/articles";
	}
}
