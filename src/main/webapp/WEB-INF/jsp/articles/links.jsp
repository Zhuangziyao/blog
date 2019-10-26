<%@ page import="com.blog.model.Meta" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>友情链接</title>
    <link rel="shortcut icon" href="<%=path%>/static/user/img/favicon.ico"/>
    <link rel="stylesheet" href="<%=path %>/static/user/css/style.min.css"/>
</head>
<body class="bg-grey">
<jsp:include page="header.jsp"/>
<article class="main-content post-page">
    <div id="post-content" class="post-content">
        <h3>友情链接</h3>
        <ul class="flinks">
            <% List<Meta> metas = (List<Meta>) request.getAttribute("links");
                for (int i = 0; i < metas.size(); i++) {%>
            <li>🔒 <a href="<%=metas.get(i).getSlug()%>" target="_blank"><%=metas.get(i).getName()%>
            </a></li>
            <% } %>
        </ul>
        <h3>链接须知</h3>
        <blockquote>
            <ul>
                <li><p>预计现在开始是不会有友链的</p></li>
                <li><p>请确定贵站可以稳定运营</p></li>
                <li><p>原创博客优先，技术类博客优先，设计、视觉类博客优先</p></li>
                <li><p>经常过来访问和评论，眼熟的</p></li>
            </ul>
        </blockquote>
        <h3>基本信息</h3>
        <pre><code class="lang-md hljs markdown">
            网站名称：BPM Blog(大猪妖的博客)
            网站地址：</code></pre>

        <p>我的邮箱:921137471@qq.com</p>
        <p>欢迎互换友链</p></div>
</article>
<jsp:include page="footer.jsp"/>
</body>
</html>