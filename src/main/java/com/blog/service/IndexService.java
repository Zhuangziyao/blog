package com.blog.service;

import com.blog.model.Archive;
import com.blog.model.Article;

import java.util.List;

public interface IndexService {
    int getArticlesCount();

    List<Article> findArticles(int start, int pageSize);

    Article findArticleById(int cid);

    Article findArticleByIdOnEdite(int cid);

    Article findArticleBySlug(String slug);

    List<Article> findArticleByWord(String word);

    List<Article> findAllArticles();

    List<Archive> findAllArchives();

    List<Article> findArticleByCategory(String c);

    List<Article> findArticleByTag(String c);

    List<Article> findArticleOrderByCreate();

    int delete(int cid);

    int insert(Article article);

    int updateById(Article article);

    void updateHit(String ip, int cid);

    void updateComment(int cid);

    Article findArticleByCreated(int created);
}
