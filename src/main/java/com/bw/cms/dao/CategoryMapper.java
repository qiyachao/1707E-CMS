package com.bw.cms.dao;

import java.util.List;

import com.bw.cms.domain.Category;

public interface CategoryMapper {
	
	List<Category> selectByChannelId(Integer channelId);
	
    int deleteByPrimaryKey(Integer id);

    int insert(Category record);

    int insertSelective(Category record);

    Category selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Category record);

    int updateByPrimaryKey(Category record);
}