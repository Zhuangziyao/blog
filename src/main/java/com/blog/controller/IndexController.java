package com.blog.controller;

import com.blog.common.util.RedisUtil;
import com.blog.model.Archive;
import com.blog.model.Article;
import com.blog.model.Comment;
import com.blog.model.Meta;
import com.blog.service.CommentService;
import com.blog.service.IndexService;
import com.blog.service.MetaService;
import com.blog.service.SettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class IndexController {
	
	@Autowired
	private IndexService indexService;

	@Autowired
	private CommentService commentService;

	@Autowired
	private MetaService metaService;

	@Autowired
	private SettingService settingService;
	
	@RequestMapping("/")
	public String index(HttpServletRequest request,@RequestParam(value="limit",defaultValue="12") int limit) {
		return index(request,1,limit);
	}
	
	@GetMapping("/page/{p}")
	public String index(HttpServletRequest request,@PathVariable int p,@RequestParam(value="limit",defaultValue="12") int limit) {
		p = p<0||p>100?1:p;
		int start=(p-1)*limit;
		//计算总页数
		int articleCount=indexService.getArticlesCount();
		int count=articleCount%limit>0?(articleCount/limit+1):articleCount/limit;
		if(count==0)
			count=1;
		//获取对应页数的文章
		List<Article> articles=indexService.findArticles(start, limit);
		
		request.setAttribute("articles", articles);
		request.setAttribute("nowPage", p);
		request.setAttribute("PageCount", count);
		return "articles/index";
	}
	//点击文章
	@GetMapping("/article/{cid}")
	public String article(HttpServletRequest request,@PathVariable int cid) {
		Article article=indexService.findArticleById(cid);
		List<Comment> comments=commentService.findByCid(cid);
		request.setAttribute("article", article);
		request.setAttribute("comments",comments);
		String ip=getIpAddrByRequest(request);
		indexService.updateHit(ip,cid);
		return "articles/post";
	}
	
	//归档
	@RequestMapping("/archives")
	public String archives(HttpServletRequest request) {
		List<Archive> archives=indexService.findAllArchives();
		request.setAttribute("archives",archives);
		return "articles/archives";
	}
	//友链
	@RequestMapping("/links")
	public String links(HttpServletRequest request) {
		List<Meta> links=metaService.findMetaByType("link");
		request.setAttribute("links",links);
		return "articles/links";
	}
	//关于
	@RequestMapping("/about")
	public String about(HttpServletRequest request) {
		Article article=indexService.findArticleBySlug("about");
		request.setAttribute("article",article);
		return "articles/about";
	}
	//搜索
	@GetMapping("/search")
	public String search(HttpServletRequest request,@RequestParam String word) {
		List<Article> articles=indexService.findArticleByWord(word);
		request.setAttribute("articles", articles);
		request.setAttribute("keyWord", word);
		request.setAttribute("type", "搜索");
		return "articles/page-category";
	}
	
	@RequestMapping("/category/{word}")
	public String category(HttpServletRequest request,@PathVariable String word) {
		List<Article> articles=indexService.findArticleByCategory(word);
		request.setAttribute("articles", articles);
		request.setAttribute("keyWord", word);
		request.setAttribute("type", "分类");
		return "articles/page-category";
	}

	@RequestMapping("/tag/{word}")
	public String tag(HttpServletRequest request,@PathVariable String word) {
		List<Article> articles=indexService.findArticleByTag(word);
		request.setAttribute("articles", articles);
		request.setAttribute("keyWord", word);
		request.setAttribute("type", "标签");
		return "articles/page-category";
	}

	@RequestMapping("/comment/add")
	@ResponseBody
	public String addComment(String author,String url,String mail,String content,int cid){
		Comment comment=new Comment();
		comment.setCid(cid);
		comment.setAuthor(author);
		comment.setContent(content);
		comment.setUrl(url);
		comment.setMail(mail);
		Date date=new Date();
		comment.setCreated((int)(date.getTime()/1000));
		int result=commentService.insert(comment);
		indexService.updateComment(cid);//评论数+1
		if(result==1)
			return "success";
		else
			return "failed";
	}

	@RequestMapping("/beianhao")
	@ResponseBody
	public Map<String,String> getBeiAnHao(){
		Map<String,String> map=new HashMap<>();
		map.put("beianhao",settingService.findBeiAnHao());
		//System.out.println(beianhao);
		return map;
	}

	//从request中获取ip
	public static String getIpAddrByRequest(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
}
