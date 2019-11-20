package com.bw.cms.service;

import java.util.List;

import com.bw.cms.domain.Channel;

public interface ChannelService {

	/**
	 * 
	 * @Title: selects 
	 * @Description:查出所有栏目
	 * @return
	 * @return: List<Channel>
	 */
	List<Channel> selects();
}
