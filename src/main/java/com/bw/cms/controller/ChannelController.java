package com.bw.cms.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bw.cms.domain.Channel;
import com.bw.cms.service.ChannelService;
@RequestMapping("channel")
@Controller
public class ChannelController {

	@Resource
	private ChannelService channelService;
	/**
	 * 
	 * @Title: channels 
	 * @Description:所有栏目
	 * @return
	 * @return: List<Channel>
	 */
	@RequestMapping("channels")
	@ResponseBody
	public List<Channel> channels() {
		
		return channelService.selects();
				
		
	}
}
