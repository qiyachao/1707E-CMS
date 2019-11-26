package com.bw.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bw.cms.domain.Collect;
import com.bw.cms.domain.User;


public interface CollectMapper {
	//收藏
	int insert(Collect collect);
	//查询列表
	List<Collect> selects(User user);
	//根据登录人和文章标题查询是否收藏
	int selectByText(@Param("text")String text,@Param("user")User user);
	//删除收藏
	int deleteById(Integer id);
	
}
