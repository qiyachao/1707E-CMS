package com.bw.cms.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bw.cms.domain.Article;
import com.bw.cms.service.ArticleService;
import com.github.pagehelper.PageInfo;

@Controller
public class ArticleController {

	@Resource
	private ArticleService articleService;
	
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
}
