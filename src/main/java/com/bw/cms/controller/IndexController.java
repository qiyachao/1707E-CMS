package com.bw.cms.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bw.cms.dao.CategoryMapper;
import com.bw.cms.domain.Article;
import com.bw.cms.domain.ArticleWithBLOBs;
import com.bw.cms.domain.Category;
import com.bw.cms.domain.Channel;
import com.bw.cms.domain.Collect;
import com.bw.cms.domain.Links;
import com.bw.cms.domain.User;
import com.bw.cms.service.ArticleService;
import com.bw.cms.service.CategoryService;
import com.bw.cms.service.ChannelService;
import com.bw.cms.service.CollectService;
import com.bw.cms.service.LinksService;
import com.bw.cms.utils.ArticleEnum;
import com.bw.cms.utils.Result;
import com.bw.cms.utils.ResultUtil;
import com.bw.cms.vo.ArticleVO;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

@Controller
public class IndexController {

	@Resource
	private ChannelService channelService;//栏目
	@Resource
	private ArticleService articleService;//文章
	@Resource
	private CategoryService categoryService;//分类
	@Resource
	private LinksService linksService;// 分类
	@Resource
	private CollectService collectService;//收藏
	
	@RequestMapping(value= {"","/","index"})
	public String index(Article article,Model model,@RequestParam(defaultValue = "1")Integer page,@RequestParam(defaultValue = "10")Integer pageSize) {
		article.setStatus(1);//查询审核过的文章
		article.setDeleted(0);//查询未删除的
		article.setContentType(ArticleEnum.HTML.getCode());
		long s1 = System.currentTimeMillis();
		//创建线程
		Thread t1 = null;
		Thread t2 = null;
		Thread t3 = null;
		Thread t4 = null;
		Thread t5 = null;
		Thread t6 = null;
		t1 = new Thread(new Runnable() {
			
			@Override
			public void run() {
				
				List<Channel> channels = channelService.selects();//查询所有栏目
				model.addAttribute("channels", channels);//前台传值
			}
		});
		
		t2 = new Thread(new Runnable() {
			
			@Override
			public void run() {
				//查询热点文章
				if(article.getChannelId()==null) {
				Article hot = new Article();
				hot.setStatus(1);//查询审核过的文章
				hot.setHot(1);//赋值让其查询热点文章
				hot.setDeleted(0);//查询未删除的
				hot.setContentType(ArticleEnum.HTML.getCode());
				PageInfo<Article> info = articleService.selects(hot,page, pageSize);//查询热点文章
				model.addAttribute("info", info);
				}
				
			}
		});
		t3 = new Thread(new Runnable() {
			
			@Override
			public void run() {
				//显示分类文章
				if(article.getChannelId()!=null) {
					//查询出来栏目下分类
					List<Category> categorys = categoryService.selectByChannelId(article.getChannelId());
					model.addAttribute("categorys", categorys);
					//显示分类下的文章
					PageInfo<Article> info = articleService.selects(article,page, pageSize);//
					model.addAttribute("info", info);
				}
				
			}
		});
		t4 = new Thread(new Runnable() {
			
			@Override
			public void run() {
				//右侧最新文章
				Article lastArticle = new Article();
				lastArticle.setStatus(1);
				lastArticle.setDeleted(0);
				lastArticle.setContentType(ArticleEnum.HTML.getCode());
				PageInfo<Article> lastInfo = articleService.selects(lastArticle,1, 5);
				model.addAttribute("lastInfo", lastInfo);
				
			}
		});
		t5 = new Thread(new Runnable() {
			
			@Override
			public void run() {
				//右侧最新文章
				Article picArticle = new Article();
				picArticle.setStatus(1);
				picArticle.setDeleted(0);
				picArticle.setContentType(ArticleEnum.IMAGE.getCode());
				PageInfo<Article> picInfo = articleService.selects(picArticle,1, 5);
				model.addAttribute("picInfo", picInfo);	
				
			}
		});
		
		// 查询出左侧栏目
				t6 = new Thread(new Runnable() {
					@Override
					public void run() {
						PageInfo<Links> info = linksService.selects(1, 10);
						model.addAttribute("linksInfo", info);

					}
				});
		model.addAttribute("article", article);
		//开启线程
		t1.start();
		t2.start();
		t3.start();
		t4.start();
		t5.start();
		t6.start();
		try {
			//让子线程先运行，主线程最后运行
			t1.join();
			t2.join();
			t3.join();
			t4.join();
			t5.join();
			t6.join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		long s2 = System.currentTimeMillis();
		System.out.println("首页用时================"+(s2-s1));
		
		return "index/index";
	}
	/**
	 * 
	 * @Title: detail 
	 * @Description: 查询文章详情
	 * @param id
	 * @return
	 * @return: String
	 */
	@RequestMapping("article")
	public String detail(Model model, Integer id,HttpServletRequest request) {
		ArticleWithBLOBs article = articleService.selectByPrimaryKey(id);
		

		//检查当前点击人是否登录.如果登录则根据标题和登录人查询是否收藏该文章
		HttpSession session = request.getSession(false);
		if(null!=session) {
	       //
			User user = (User) session.getAttribute("user");
			int i = collectService.selectByText(article.getTitle(), user);
			model.addAttribute("isCollect", i);
		}
		
		model.addAttribute("article", article);
		return "index/article";
		
	}
	
	/**
	 * 
	 * @Title: articlepic
	 * @Description: 图片集详情
	 * @param model
	 * @return
	 * @return: String
	 */
	@RequestMapping("articlepic")
	public String articlepic(Model model, Integer id) {

		ArticleWithBLOBs article = articleService.selectByPrimaryKey(id);

		String string = article.getContent();
		ArrayList<ArticleVO> list = new ArrayList<ArticleVO>();
		
		Gson gson = new Gson();
		JsonArray array = new JsonParser().parse(string).getAsJsonArray();
		for (JsonElement jsonElement : array) {
			//把json转为java
			ArticleVO vo = gson.fromJson(jsonElement, ArticleVO.class);
			list.add(vo);
		}
		model.addAttribute("title", article.getTitle());// 标题
		model.addAttribute("list", list);// 标题包含的 图片的地址和描述
		return "index/articlepic";
	}

	/**
	 * 
	 * @Title: collect 
	 * @Description: 收藏
	 * @param collect
	 * @return
	 * @return: Result<Collect>
	 */
	@ResponseBody
	@PostMapping("/collect")
	public  Result<Collect> collect(Collect collect,HttpServletRequest request){
		
		HttpSession session = request.getSession(false);
		if(null==session) {
	    return ResultUtil.error(1, "收藏失败,登录可能过期");
		}
		User user = (User) session.getAttribute("user");
		if(null==user) {
		return	ResultUtil.error(1, "收藏失败,登录可能过期");
		}
		collect.setUser(user);
		collect.setCreated(new Date());
		collectService.insert(collect);
		return ResultUtil.success();
	}
}
