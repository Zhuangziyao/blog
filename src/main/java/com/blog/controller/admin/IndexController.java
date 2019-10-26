package com.blog.controller.admin;

import com.blog.model.Article;
import com.blog.model.Comment;
import com.blog.model.Log;
import com.blog.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller("adminIndexController")
@RequestMapping("/admin")
public class IndexController {

    @Autowired
    private IndexService indexService;

    @Autowired
    private MetaService metaService;

    @Autowired
    private LogService logService;

    @Autowired
    private AttachService attachService;

    @Autowired
    private CommentService commentService;

    @RequestMapping("/dashboard")
    @ResponseBody
    public Map<String, Object> adminIndex(HttpServletRequest request) {
        int articleCount = indexService.getArticlesCount();//文章数量
        int linkCount = metaService.findCountByType("link");//友链数量
        int attachCount = attachService.findCount();//附件数量
        int commentCount = commentService.findCount();//评论数量
        List<Article> articles = indexService.findArticleOrderByCreate();//获取最新文章
        List<Comment> comments = commentService.findOrderByCreate();//获取最新留言
        List<Log> logs = logService.findOrderByCreate();//获取最新日志
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("articleCount", articleCount);
        map.put("linkCount", linkCount);
        map.put("attachCount", attachCount);
        map.put("commentCount", commentCount);
        map.put("articles", articles);
        map.put("logs", logs);
        map.put("comments", comments);

        return map;
    }

}
