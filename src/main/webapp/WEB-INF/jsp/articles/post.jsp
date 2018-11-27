<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.blog.model.Article" %>
<%@page import="java.util.*" %>
<%@ page import="java.text.*,com.blog.common.util.*" %>
<% String path=request.getContextPath(); %>
<% Article article=(Article)request.getAttribute("article"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=article.getTitle() %> - BPM Blog</title>
    <link rel="shortcut icon" href="<%=path%>/static/user/img/favicon.ico" />
<link rel="stylesheet" href="<%=path %>/static/user/css/style.min.css"/>
<link href="https://cdn.bootcss.com/highlight.js/9.12.0/styles/xcode.min.css" rel="stylesheet">
</head>
<body class="bg-grey">
<jsp:include page="header.jsp" />
<article class="main-content post-page" itemscope="" itemtype="http://schema.org/Article">
    <div class="post-header">
        <h1 class="post-title" itemprop="name headline">
            <a href="" data-no-instant=""><%=article.getTitle() %></a>
        </h1>
        <div class="post-data">
            <time itemprop="datePublished" >发布于 <%=TimeTransform.TimeStamp2Date(article.getCreated()) %> </time>
            / <a href="<%=path%>/category/<%=article.getCategories()%>"><%=article.getCategories() %></a> / <a href="#comments"><%=article.getCommentsNum() %>条评论</a> /
            <block/><%=article.getHits() %>浏览
        </div>
    </div>
    <div id="post-content" class="post-content" itemprop="articleBody">
        <p class="post-tags">
        <% if(article.getTags()!=null&&!article.getTags().trim().equals("")){ %>
        	<a href="<%=path %>/tag/<%=article.getTags()%>"><%=article.getTags() %></a>
        <% } %>
        </p>
        <%=article.getContent() %>
        <p class="post-info">
            本站文章除注明转载/出处外，均为本站原创或翻译，转载前请务必署名,转载请标明出处.<br/>最后编辑时间为:
            <block><%=TimeTransform.TimeStamp2Date(article.getModified()) %></block>
        </p>
    </div>
</article>
<% if(article.getType().equals("post")){ %>
    <jsp:include page="comment.jsp"/>
<% } %>
<jsp:include page="footer.jsp" />
<% if(article.getType().equals("post")){ %>
    <div id="directory-content" class="directory-content">
        <div id="directory"></div>
    </div>
<% } %>
<script src="https://cdn.bootcss.com/highlight.js/9.12.0/highlight.min.js"></script>
<script >hljs.initHighlightingOnLoad();</script>
<script type="text/javascript">
    //右侧导航栏
    var postDirectoryBuild = function () {
        var postChildren = function children(childNodes, reg) {
                var result = [],
                    isReg = typeof reg === 'object',
                    isStr = typeof reg === 'string',
                    node, i, len;
                for (i = 0, len = childNodes.length; i < len; i++) {
                    node = childNodes[i];
                    if ((node.nodeType === 1 || node.nodeType === 9) &&
                        (!reg ||
                            isReg && reg.test(node.tagName.toLowerCase()) ||
                            isStr && node.tagName.toLowerCase() === reg)) {
                        result.push(node);
                    }
                }
                return result;
            },
            createPostDirectory = function (article, directory, isDirNum) {
                var contentArr = [],
                    titleId = [],
                    levelArr, root, level,
                    currentList, list, li, link, i, len;
                levelArr = (function (article, contentArr, titleId) {
                    var titleElem = postChildren(article.childNodes, /^h\d$/),
                        levelArr = [],
                        lastNum = 1,
                        lastRevNum = 1,
                        count = 0,
                        guid = 1,
                        id = 'directory' + (Math.random() + '').replace(/\D/, ''),
                        lastRevNum, num, elem;
                    while (titleElem.length) {
                        elem = titleElem.shift();
                        contentArr.push(elem.innerHTML);
                        num = +elem.tagName.match(/\d/)[0];
                        if (num > lastNum) {
                            levelArr.push(1);
                            lastRevNum += 1;
                        } else if (num === lastRevNum ||
                            num > lastRevNum && num <= lastNum) {
                            levelArr.push(0);
                            lastRevNum = lastRevNum;
                        } else if (num < lastRevNum) {
                            levelArr.push(num - lastRevNum);
                            lastRevNum = num;
                        }
                        count += levelArr[levelArr.length - 1];
                        lastNum = num;
                        elem.id = elem.id || (id + guid++);
                        titleId.push(elem.id);
                    }
                    if (count !== 0 && levelArr[0] === 1) levelArr[0] = 0;

                    return levelArr;
                })(article, contentArr, titleId);
                currentList = root = document.createElement('ul');
                dirNum = [0];
                for (i = 0, len = levelArr.length; i < len; i++) {
                    level = levelArr[i];
                    if (level === 1) {
                        list = document.createElement('ul');
                        if (!currentList.lastElementChild) {
                            currentList.appendChild(document.createElement('li'));
                        }
                        currentList.lastElementChild.appendChild(list);
                        currentList = list;
                        dirNum.push(0);
                    } else if (level < 0) {
                        level *= 2;
                        while (level++) {
                            if (level % 2) dirNum.pop();
                            currentList = currentList.parentNode;
                        }
                    }
                    dirNum[dirNum.length - 1]++;
                    li = document.createElement('li');
                    link = document.createElement('a');
                    link.href = '#' + titleId[i];
                    link.innerHTML = !isDirNum ? contentArr[i] :
                        dirNum.join('.') + ' ' + contentArr[i];
                    li.appendChild(link);
                    currentList.appendChild(li);
                }
                directory.appendChild(root);
            };
        createPostDirectory(document.getElementById('post-content'), document.getElementById('directory'), true);
    };
    postDirectoryBuild();
</script>
</body>
</html>