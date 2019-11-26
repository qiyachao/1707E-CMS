package com.bw.cms.dao;

import java.util.List;

import com.bw.cms.domain.Links;

public interface LinksMapper {
	//添加
	int insert(Links links);
	//查询
	List<Links> selects();
}
