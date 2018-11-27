package com.blog.mapper;

import com.blog.model.Archive;
import com.blog.model.Article;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface ArticleMapper {
    int getArticlesCount();
    List<Article> findArticles(@Param("start") int start, @Param("pageSize") int pageSize);
    Article findArticleById(@Param("cid") int cid);
    List<Article> findArticleByWord(@Param("word") String word);
    List<Article> findAllArticles();
    List<Archive> findAllArchives();
    List<Article> findArticleByDate(@Param("date") String date);
    Article findArticleBySlug(@Param("slug") String slug);
    List<Article> findArticleByCategory(@Param("category") String category);
    List<Article> findArticleOrderByCreate();
    int delete(@Param("cid") int cid);
    int insert(Article article);
    int updateById(Article article);
    int updateHit(@Param("cid") int cid);
    int updateComment(@Param("cid") int cid);
    Article findArticleByCreated(@Param("created") int created);
    List<Article> findArticleByTag(@Param("tag") String tag);
}
