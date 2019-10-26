package com.blog.model;

import java.io.Serializable;
import java.util.List;

/**
 * 归档
 *
 * @author acer
 */
public class Archive implements Serializable {
    private static final long serialVersionUID = 1L;
    private String date;
    private Integer count;
    private List<Article> articles;

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public List<Article> getArticles() {
        return articles;
    }

    public void setArticles(List<Article> articles) {
        this.articles = articles;
    }

}
