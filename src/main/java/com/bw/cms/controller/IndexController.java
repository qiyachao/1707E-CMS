package com.bw.cms.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bw.cms.dao.CategoryMapper;
import com.bw.cms.domain.Article;
import com.bw.cms.domain.ArticleWithBLOBs;
import com.bw.cms.domain.Category;
import com.bw.cms.domain.Channel;
import com.bw.cms.service.ArticleService;
import com.bw.cms.service.CategoryService;
import com.bw.cms.service.ChannelService;
import com.github.pagehelper.PageInfo;

@Controller
public class IndexController {

	@Resource
	private ChannelService channelService;//栏目
	@Resource
	private ArticleService articleService;//文章
	@Resource
	private CategoryService categoryService;//分类
	
	@RequestMapping(value= {"","/","index"})
	public String index(Article article,Model model,@RequestParam(defaultValue = "1")Integer page,@RequestParam(defaultValue = "10")Integer pageSize) {
		article.setStatus(1);//查询审核过的文章
		article.setDeleted(0);//查询未删除的
		List<Channel> channels = channelService.selects();//查询所有栏目
		model.addAttribute("channels", channels);//前台传值
		//查询热点文章
		if(article.getChannelId()==null) {
		Article hot = new Article();
		hot.setStatus(1);//查询审核过的文章
		hot.setHot(1);//赋值让其查询热点文章
		hot.setDeleted(0);//查询未删除的
		PageInfo<Article> info = articleService.selects(hot,page, pageSize);//查询热点文章
		model.addAttribute("info", info);
		}
		//显示分类文章
		if(article.getChannelId()!=null) {
			//查询出来栏目下分类
			List<Category> categorys = categoryService.selectByChannelId(article.getChannelId());
			model.addAttribute("categorys", categorys);
			//显示分类下的文章
			PageInfo<Article> info = articleService.selects(article,page, pageSize);//
			model.addAttribute("info", info);
		}
		
		//右侧
		Article lastArticle = new Article();
		lastArticle.setStatus(1);
		lastArticle.setDeleted(0);
		PageInfo<Article> lastInfo = articleService.selects(lastArticle,1, 5);
		model.addAttribute("lastInfo", lastInfo);
		return "index/index";
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
		return "index/article";
		
	}
}
