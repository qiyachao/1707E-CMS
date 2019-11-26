package com.bw.cms.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bw.cms.domain.Links;
import com.bw.cms.service.LinksService;
import com.bw.cms.utils.Result;
import com.bw.cms.utils.ResultUtil;
import com.github.pagehelper.PageInfo;

import net.sf.jsqlparser.util.AddAliasesVisitor;
@RequestMapping("admin")
@Controller
public class AdminController {

	@Resource
	private LinksService linksService;
	/**
	 * 
	 * @Title: selects 
	 * @Description: 维护友情链接--列表
	 * @param page
	 * @param pageSize
	 * @return
	 * @return: String
	 */
	@GetMapping("links/selects")
	public String selects(Model model,@RequestParam(defaultValue = "1")Integer page,@RequestParam(defaultValue = "10")Integer pageSize) {
		PageInfo<Links> info = linksService.selects(page, pageSize);
		model.addAttribute("info", info);
		return "admin/links/links";
	}
	
	@GetMapping("links/add")
	public String add() {
		return "admin/links/add";	
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping("links/add")
	public Result<Links> add(Links links){
		linksService.insert(links);
		return ResultUtil.success();
	}
	
	/**
	 * 
	 * @Title: index 
	 * @Description: 跳转到index页面
	 * @return
	 * @return: String
	 */
	@RequestMapping(value = {"","/","index"})
	public String index() {
		
		return "admin/index";
		
	}
	
	
}
