package com.bw.cms.service;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Test;

import com.bw.cms.domain.Links;
import com.bw.cms.service.impl.JunitParent;

public class LinksServiceTest extends JunitParent{

	@Resource
	private LinksService linksService;
	@Test
	public void testInsert() {
		Links links = new Links();
		links.setUrl("https://www.baidu.com/");
		links.setText("头条");
		linksService.insert(links);

	}
}
