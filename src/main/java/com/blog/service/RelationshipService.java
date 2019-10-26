package com.blog.service;

public interface RelationshipService {
    int insert(int cid, int mid);

    int delete(int cid, int mid);

    int deleteAll(int cid);

    int findCount(int mid);
}
