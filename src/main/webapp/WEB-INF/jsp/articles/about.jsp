<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="com.blog.model.Article" %>
<%@page import="java.util.*" %>
<%@ page import="java.text.*,com.blog.common.util.*" %>
<% String path = request.getContextPath(); %>
<% Article article = (Article) request.getAttribute("article"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>关于博客</title>
    <link rel="shortcut icon" href="<%=path%>/static/user/img/favicon.ico"/>
    <link rel="stylesheet" href="<%=path %>/static/user/css/style.min.css"/>
</head>
<body class="bg-grey">
<jsp:include page="header.jsp"/>
<article class="main-content post-page" itemscope="" itemtype="http://schema.org/Article">
    <div class="post-header">
        <h1 class="post-title" itemprop="name headline">
            <a href="" data-no-instant=""><%=article.getTitle() %>
            </a>
        </h1>
        <div class="post-data">
            <time itemprop="datePublished">发布于 <%=TimeTransform.TimeStamp2Date(article.getCreated()) %>
            </time>
        </div>
    </div>
    <div id="post-content" class="post-content" itemprop="articleBody">

        <p class="post-tags">
            <% if (article.getTags() != null && !article.getTags().trim().equals("")) { %>
            <a href="<%=path %>/tag/<%=article.getTags()%>"><%=article.getTags() %>
            </a>
            <% } %>
        </p>
        <block/>
        <%=article.getContent() %>

    </div>
</article>
<jsp:include page="footer.jsp"/>
</body>
</html>