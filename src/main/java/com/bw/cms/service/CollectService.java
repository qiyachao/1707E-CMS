package com.bw.cms.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bw.cms.domain.Collect;
import com.bw.cms.domain.User;
import com.github.pagehelper.PageInfo;

public interface CollectService {

		//收藏
		boolean insert(Collect collect);
		//查询列表
		PageInfo<Collect> selects(Integer page,Integer pageSize,User user);
		//根据登录人和文章标题查询是否收藏
		int selectByText(@Param("text")String text,@Param("user")User user);
		//删除收藏
		boolean deleteById(Integer id);
}
