package com.bw.cms.service;

import java.util.List;

import com.bw.cms.domain.Article;
import com.bw.cms.domain.ArticleWithBLOBs;
import com.github.pagehelper.PageInfo;

public interface ArticleService {
	//文章列表
	PageInfo<Article> selects(Article article, Integer page,Integer pageSize);
	//修改
	boolean update(ArticleWithBLOBs article);
	
	ArticleWithBLOBs selectByPrimaryKey(Integer id);
	
	/**
	 * 
	 * @Title: insertSelective 
	 * @Description: 发布文章
	 * @param record
	 * @return
	 * @return: int
	 */
	boolean insertSelective(ArticleWithBLOBs record);
}
