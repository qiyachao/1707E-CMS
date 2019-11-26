package com.bw.cms.service;

import java.util.List;

import com.bw.cms.domain.Links;
import com.github.pagehelper.PageInfo;

public interface LinksService {

	//添加
	boolean insert(Links links);
	//查询
	PageInfo<Links> selects(Integer page,Integer pageSize);
	
}
