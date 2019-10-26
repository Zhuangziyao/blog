package com.blog.service.impl;

import com.blog.mapper.ArticleMapper;
import com.blog.model.Archive;
import com.blog.model.Article;
import com.blog.service.IndexService;
import org.pegdown.PegDownProcessor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IndexServiceImpl implements IndexService {

    @Autowired
    private ArticleMapper articleDAO;

    @Override
    public int getArticlesCount() {
        return articleDAO.getArticlesCount();
    }

    @Override
    public List<Article> findArticles(int start, int pageSize) {
        List<Article> articles = articleDAO.findArticles(start, pageSize);
        return articles;
    }

    @Override
    public Article findArticleById(int cid) {
        Article article = articleDAO.findArticleById(cid);
        //把markdown格式转成html格式
        PegDownProcessor pdp = new PegDownProcessor(Integer.MAX_VALUE);
        String html = pdp.markdownToHtml(article.getContent());
        article.setContent(html);
        return article;
    }

    @Override
    public Article findArticleByIdOnEdite(int cid) {
        Article article = articleDAO.findArticleById(cid);
        return article;
    }

    @Override
    public List<Article> findArticleByWord(String word) {
        return articleDAO.findArticleByWord(word);
    }

    @Override
    public List<Archive> findAllArchives() {
        List<Archive> archives = articleDAO.findAllArchives();
        for (int i = 0; i < archives.size(); i++) {
            List<Article> articles = articleDAO.findArticleByDate(archives.get(i).getDate());
            System.out.println(archives.get(i).getDate());
            archives.get(i).setArticles(articles);
        }
        return archives;
    }

    @Override
    public Article findArticleBySlug(String slug) {
        Article article = articleDAO.findArticleBySlug(slug);
        //把markdown格式转成html格式
        PegDownProcessor pdp = new PegDownProcessor(Integer.MAX_VALUE);
        String html = pdp.markdownToHtml(article.getContent());

        article.setContent(html);
        return article;
    }

    @Override
    public List<Article> findArticleByCategory(String c) {
        return articleDAO.findArticleByCategory(c);
    }

    @Override
    public List<Article> findArticleByTag(String c) {
        return articleDAO.findArticleByTag(c);
    }

    @Override
    public List<Article> findArticleOrderByCreate() {
        return articleDAO.findArticleOrderByCreate();
    }

    @Override
    public int delete(int cid) {
        return articleDAO.delete(cid);
    }

    @Override
    public List<Article> findAllArticles() {
        return articleDAO.findAllArticles();
    }

    @Override
    public int insert(Article article) {
        return articleDAO.insert(article);
    }

    @Override
    public int updateById(Article article) {
        return articleDAO.updateById(article);
    }

    //检查同一ip是否在一小时内访问同一文章
    @Override
    @Cacheable(value = "ipCache", key = "#ip+'_'+#cid")
    public void updateHit(String ip, int cid) {
        articleDAO.updateHit(cid);
    }

    @Override
    public void updateComment(int cid) {
        articleDAO.updateComment(cid);
    }

    @Override
    public Article findArticleByCreated(int created) {
        return articleDAO.findArticleByCreated(created);
    }
}
