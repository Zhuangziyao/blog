package com.blog.controller.admin;

import com.blog.model.Comment;
import com.blog.service.CommentService;
import com.blog.service.IndexService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Description:comment controller
 *
 * @authror: zhuangziyao
 * @date: 2018/9/19 12:09
 **/
@Controller
@RequestMapping("/admin/comments")
public class CommentController {

    @Autowired
    private CommentService commentService;

    @Autowired
    private IndexService indexService;

    @RequestMapping("")
    public String comment(HttpServletRequest request){
        List<Comment> comments=commentService.findAll();
        request.setAttribute("comments",comments);
        return "admin/comment_list";
    }

    @RequestMapping("/approve")
    @ResponseBody
    public String updateStatus(@RequestParam int coid){
        return "success";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public String deleteComment(@RequestParam int coid){
        commentService.delete(coid);
        //文章的评论数应该-1
        //indexService.updateComment();
        return "success";
    }
}
