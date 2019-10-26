<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.blog.model.*" %>
<%@ page import="static com.blog.common.util.common.show_icon" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="<%=path %>/static/user/css/style.min.css"/>
    <link rel="shortcut icon" href="<%=path%>/static/user/img/favicon.ico" type="image/x-icon"/>
    <title>BPM - Blog</title>
</head>
<jsp:include page="header.jsp"/>
<body class="bg-grey">
<img style="position:fixed;left: 0;opacity: 0.5;width: 500px;" src="<%=path%>/static/user/img/hero/batman.png" alt="">
<img style="position: fixed;right: -20px;opacity: 0.5;width: 500px;" src="<%=path%>/static/user/img/hero/catwoman.png"
     alt="">
<div class="main-content index-page clearfix">
    <div class="post-lists">
        <div class="post-lists-body">
            <% List<Article> articles = (List<Article>) request.getAttribute("articles");
                for (int i = 0; i < articles.size(); i++) { %>
            <div class="post-list-item">
                <div class="post-list-item-container">
                    <a class="item-thumb bg-deepgrey" href="article/<%=articles.get(i).getCid() %>"
                       style="background:url('<%=path %>/static/user/img/rand/<%=articles.get(i).getCid()%>.jpg');
                               background-size: 400px;background-repeat:no-repeat;background-position:top center;">
                        <dir class="item-desc"><%=articles.get(i).getTags() %>
                        </dir>
                    </a>
                    <div class="item-slant reverse-slant &lt; bg-deepgrey"></div>
                    <div class="item-slant"></div>
                    <div class="item-label">
                        <div class="item-title">
                            <a href="article/<%=articles.get(i).getCid() %>"><%=articles.get(i).getTitle() %>
                            </a>
                        </div>
                        <div class="item-meta clearfix">
                            <div class="item-meta-ico <%=show_icon(articles.get(i).getCid())%> "
                                 style="background:url('<%=path%>/static/user/img/bg-ico.png');background-size:40px auto;"></div>
                            <div class="item-meta-cat">
                                <a href="./category/<%=articles.get(i).getCategories()%>"><%=articles.get(i).getCategories() %>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
    <div class="lists-navigator">
        <ol class="page-navigator">
            <% int nowPage = (int) request.getAttribute("nowPage");
                int pageCount = (int) request.getAttribute("PageCount");
                for (int i = 0; i < pageCount; i++) {
                    if (nowPage != 1) {%>
            <li class="prev">
                <a href="page/<%=i+1 %>">←</a>
            </li>
            <% }
                if (i + 1 == nowPage) { %>
            <li class="current">
                <a href="page/<%=i+1 %>">1</a>
            </li>
            <%} else { %>
            <li>
                <a href="page/<%=i+1 %>">1</a>
            </li>
            <%
                }
                if (nowPage != pageCount) {
            %>
            <li class="next">
                <a href="page/<%=i+1 %>">→</a>
            </li>
            <% }
            }%>
        </ol>
    </div>
</div>
<jsp:include page="footer.jsp" flush="true"/>
<script src="<%=path %>/static/user/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
    /*var height=$(window).scrollTop();
    $(window).scroll(function(event) {
        var scroll=$(this).scrollTop();
        if(scroll>=height){
            $(".header").removeClass('slideDown').addClass('slideUp');
            height=scroll;
        }
        else{
            $(".header").removeClass('slideUp').addClass('slideDown');
            height=scroll;
        }

    })*/
</script>
</body>

</html>