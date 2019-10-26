<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<% String path = request.getContextPath(); %>
<%@ page import="com.blog.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.blog.common.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>分类归档</title>
    <link rel="shortcut icon" href="<%=path%>/static/user/img/favicon.ico"/>
    <link rel="stylesheet" href="<%=path %>/static/user/css/style.min.css"/>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="main-content archive-page clearfix">
    <div class="categorys-item">
        <% List<Archive> archives = (List<Archive>) request.getAttribute("archives");
            for (int i = 0; i < archives.size(); i++) { %>
        <block>
            <div class="categorys-title"><%=archives.get(i).getDate() %>
            </div>
            <div class="post-lists">
                <div class="post-lists-body">
                    <% for (int j = archives.get(i).getCount() - 1; j >= 0; j--) { %>
                    <block>
                        <div class="post-list-item">
                            <div class="post-list-item-container">
                                <div class="item-label">
                                    <div class="item-title">
                                        <a href="<%=path%>/article/<%=archives.get(i).getArticles().get(j).getCid()%>"><%=archives.get(i).getArticles().get(j).getTitle() %>
                                        </a>
                                    </div>
                                    <div class="item-meta clearfix">
                                        <div class="item-meta-date">发布于
                                            <block/>
                                            <%=TimeTransform.TimeStamp2Date(archives.get(i).getArticles().get(j).getCreated()) %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </block>
                    <% } %>
                </div>
            </div>
        </block>
        <% } %>
    </div>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>