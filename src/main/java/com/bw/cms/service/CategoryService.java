package com.bw.cms.service;

import java.util.List;

import com.bw.cms.domain.Category;

public interface CategoryService {
	//根据栏目id查找所有分类
	List<Category> selectByChannelId(Integer channelId);
}
