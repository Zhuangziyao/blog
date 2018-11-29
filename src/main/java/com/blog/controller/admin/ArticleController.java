package com.blog.controller.admin;

import com.blog.model.Article;
import com.blog.model.Log;
import com.blog.model.Meta;
import com.blog.model.User;
import com.blog.service.IndexService;
import com.blog.service.LogService;
import com.blog.service.MetaService;
import com.blog.service.RelationshipService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import static com.blog.controller.IndexController.getIpAddrByRequest;

/**
 * Description:article controller
 *
 * @authror: zhuangziyao
 * @date: 2018/9/16 17:52
 **/
@Controller
@RequestMapping("/admin/article")
public class ArticleController {

    @Autowired
    private IndexService indexService;

    @Autowired
    private MetaService metaService;

    @Autowired
    private RelationshipService relationshipService;

    @Autowired
    private LogService logService;

    @RequestMapping("")
    public String articles(HttpServletRequest request){
        List<Article> articles=indexService.findAllArticles();
        request.setAttribute("articles",articles);
        return "admin/article_list";
    }
    //前往文章编辑页面
    @RequestMapping("/publish")
    public String articlePublish(@RequestParam(required = false,defaultValue = "-1")Integer cid, HttpServletRequest request){
        Article article=null;
        if(cid != -1)
            article=indexService.findArticleByIdOnEdite(cid);
        request.setAttribute("article",article);

        List<Meta> metas= metaService.findMetaByType("category");
        request.setAttribute("categories",metas);
        return "admin/article_edit";
    }

    @RequestMapping("/{cid}")
    public String articleEdit(@PathVariable("cid") int cid, HttpServletRequest request){
        return articlePublish(cid,request);
    }
    //预览
    @RequestMapping("/preview/{cid}")
    @ResponseBody
    public Article preview(@PathVariable("cid") int cid){
        Article article=indexService.findArticleById(cid);
        return article;
    }

    //修改文章
    @RequestMapping("/modify")
    @ResponseBody
    public String modifyArticle(HttpServletRequest request,Article article ){
        Date now=new Date();
        article.setCreated((int)(now.getTime()/1000));
        article.setModified((int)(now.getTime()/1000));
        int result;
        if(article.getCid()==null){
            result=indexService.insert(article);
            Article art=indexService.findArticleByCreated(article.getCreated());
            //添加文章和分类的关联
            String[] categories=article.getCategories().split(",");
            List<Meta> metas=metaService.findMetaByType("category");
            for(int i=0;i<categories.length;i++){
                for(int j=0;j<metas.size();j++){
                    if(categories[i].equals(metas.get(j).getName())){
                        relationshipService.insert(art.getCid(),metas.get(j).getmId());
                        break;
                    }
                }
            }
        }
        else{
            result=indexService.updateById(article);
            //修改文章和分类的关联   先全部删除再添加
            relationshipService.deleteAll(article.getCid());
            String[] categories=article.getCategories().split(",");
            List<Meta> metas=metaService.findMetaByType("category");
            for(int i=0;i<categories.length;i++){
                for(int j=0;j<metas.size();j++){
                    if(categories[i].equals(metas.get(j).getName())){
                        relationshipService.insert(article.getCid(),metas.get(j).getmId());
                        break;
                    }
                }
            }
        }
        if(result == 1){
            HttpSession session=request.getSession();
            User user=(User)session.getAttribute("user");
            Log log=new Log();
            log.setAction("修改文章");
            log.setAuthorId(user.getuId());
            log.setCreated((int)(now.getTime()/1000));
            logService.insert(log);
            return "success";
        }

        else
            return "failed";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public String deleteArticle(HttpServletRequest request,@RequestParam() int cid){
        int result=indexService.delete(cid);
        if(result == 1){
            HttpSession session=request.getSession();
            User user=(User)session.getAttribute("user");
            Log log=new Log();
            log.setAction("删除文章");
            log.setAuthorId(user.getuId());
            Date date=new Date();
            log.setCreated((int)(date.getTime()/1000));
            logService.insert(log);
            return "success";
        }
        else
            return "failed";
    }

}
