package com.bw.cms.service;

import java.util.List;

import com.bw.cms.domain.Article;
import com.github.pagehelper.PageInfo;

public interface ArticleService {

	PageInfo<Article> selects(Article article, Integer page,Integer pageSize);
}
