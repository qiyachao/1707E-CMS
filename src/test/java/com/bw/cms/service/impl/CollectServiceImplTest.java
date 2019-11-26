package com.bw.cms.service.impl;

import static org.junit.Assert.*;

import javax.annotation.Resource;

import org.junit.Test;

import com.bw.cms.domain.Collect;
import com.bw.cms.service.CollectService;

public class CollectServiceImplTest extends JunitParent{

	@Resource
	private CollectService collectService;
	@Test
	public void testInsert() {
		Collect c = new Collect();
		c.setUrl("aaa");
		collectService.insert(c);
	}

	@Test
	public void testSelects() {
		
	}

	@Test
	public void testDeleteById() {
		
	}

}
