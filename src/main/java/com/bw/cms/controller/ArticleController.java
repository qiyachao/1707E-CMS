package com.bw.cms.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bw.cms.domain.Article;
import com.bw.cms.domain.ArticleWithBLOBs;
import com.bw.cms.service.ArticleService;
import com.github.pagehelper.PageInfo;
@RequestMapping("article")
@Controller
public class ArticleController {

	@Resource
	private ArticleService articleService;
	/**
	 * 
	 * @Title: selects 
	 * @Description: 文章管理列表
	 * @param article
	 * @param page
	 * @param pageSize
	 * @param model
	 * @return
	 * @return: String
	 */
	@RequestMapping("articles")
	public String selects(Article article,@RequestParam(defaultValue = "1")Integer page,@RequestParam(defaultValue = "3")Integer pageSize,Model model){
		PageInfo<Article> info = articleService.selects(article, page, pageSize);
		int[] nums = info.getNavigatepageNums();
		model.addAttribute("info", info);
		model.addAttribute("articles", info.getList());
		model.addAttribute("article",article);
		model.addAttribute("nums", nums);
		return "admin/article/articles";
		
	}
	
	@RequestMapping("update")
	@ResponseBody
	public boolean update(ArticleWithBLOBs article){
		
		return articleService.update(article);
		
		
	}
	
	@RequestMapping("article")
	public String detail(Integer id,Model model) {
		ArticleWithBLOBs article = articleService.selectByPrimaryKey(id);
		model.addAttribute("article", article);
		return "/admin/article/article";
		
	}
}
