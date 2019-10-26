package com.blog.model;

import java.io.Serializable;

public class Page implements Serializable {
    private Integer pageSize = 12;
    private Integer Count;
    private Integer showPageNum = 5;
    private static final long serialVersionUID = 1L;

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getCount() {
        return Count;
    }

    public void setCount(Integer count) {
        Count = count;
    }

    public Integer getShowPageNum() {
        return showPageNum;
    }

    public void setShowPageNum(Integer showPageNum) {
        this.showPageNum = showPageNum;
    }
}
