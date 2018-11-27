<%--
  Created by IntelliJ IDEA.
  User: 92113
  Date: 2018/9/9
  Time: 8:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.blog.model.Article" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blog.common.util.TimeTransform" %>
<%@ page import="static com.blog.common.util.common.show_icon" %>
<%String path=request.getContextPath(); %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" href="<%=path%>/static/user/img/favicon.ico" />
    <link rel="stylesheet" href="<%=path %>/static/user/css/style.min.css" />
    <title><%=request.getAttribute("keyword") %> - BPM Blog</title>
</head>
<body>
<jsp:include page="header.jsp"/>
    <div class="main-content common-page clearfix">
        <div class="categories-item">
            <div class="common-title">
                <%=request.getAttribute("type")%> : <%=request.getAttribute("keyWord") %>
            </div>
        </div>
        <% List<Article> list=(List<Article>)request.getAttribute("articles");
            if(list.size() == 0){%>
            <div>
                <p>抱歉，还没有相关文章.</p>
            </div>
        <% }else {%>
        <div class="post-lists">
            <div class="post-lists-body">
                <% for(int i=0;i<list.size();i++){ %>
                    <div class="post-list-item">
                        <div class="post-list-item-container ">
                            <div class="item-label ">
                                <div class="item-title">
                                    <a href="../article/<%=list.get(i).getCid() %>" ><%=list.get(i).getTitle()%></a>
                                </div>
                                <div class="item-meta clearfix">
                                    <div class="item-meta-ico <%=show_icon(list.get(i).getCid())%>"
                                         style="background: url('<%=path%>/static/user/img/bg-ico.png') no-repeat;background-size: 40px auto;"></div>
                                    <div class="item-meta-date">发布于 <block/><%=TimeTransform.TimeStamp2Date(list.get(i).getCreated()) %></div>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>
        <% } %>
    </div>
<jsp:include page="footer.jsp"/>
</body>
</html>
