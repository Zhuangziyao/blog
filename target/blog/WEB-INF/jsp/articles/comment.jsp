<%@ page import="com.blog.model.Article" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blog.model.Comment" %>
<%@ page import="com.blog.common.util.TimeTransform" %>
<%@ page import="com.blog.common.util.common" %><%--
  Created by IntelliJ IDEA.
  User: 92113
  Date: 2018/9/23
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path=request.getContextPath(); %>
<html>
<head>
    <title>comment</title>
</head>
<body>
<div>
    <%Article article=(Article)request.getAttribute("article"); %>
    <div id="<%=article.getCid()%>" class="comment-container">
        <div id="comments" class="clearfix">
            <% if(article.getAllowComment()==true){ %>
            <div>
                <form id="comment-form" class="comment-form" role="form"
                      onsubmit="return false">
                    <input type="hidden" name="coid" id="coid"/>
                    <input type="hidden" name="cid" id="cid" value="<%=article.getCid()%>"/>
                    <%--<input type="hidden" name="_csrf_token" th:value="${_csrf_token}"/>--%>
                    <input type="text" name="author" maxlength="12" id="author"
                           class="form-control input-control clearfix"
                           placeholder="姓名 (*)"
                    />
                    <input type="email" name="mail" id="mail" class="form-control input-control clearfix"
                           placeholder="邮箱 (*)"
                    />
                    <input type="url" name="url" id="url" class="form-control input-control clearfix"
                           placeholder="网址 (http://)"
                    />
                    <textarea name="content" id="textarea" class="form-control" placeholder="以上信息可以为空,评论不能为空"
                              required="required" minlength="5"
                              maxlength="2000"></textarea>
                    <button type="submit" class="submit" id="misubmit" onclick="subComment()">提交</button>
                </form>
            </div>
            <% }else{ %>
            <div>
                <span class="response">评论已关闭.</span>
            </div>
            <% } %>
            <% List<Comment> commentList=(List<Comment>)request.getAttribute("comments");
              if(commentList.size()!=0){%>
            <div>
                <ol class="comment-list">
                    <% for(int i=0;i<commentList.size();i++){ %>
                        <li id="li-comment-<%=commentList.get(i).getCoid()%>" class="comment-body comment-parent comment-odd">
                            <div id="comment-<%=commentList.get(i).getCoid()%>">
                                <div class="comment-view" onclick="">
                                    <div class="comment-header">
                                        <!--设置get请求的参数-->
                                        <img class="avatar"
                                             src="<%=path%>/static/user/img/comment/comment-<%=common.rand(1,19)%>.png"
                                             title="<%=commentList.get(i).getAuthor()%>"
                                             width="80" height="80"/>
                                        <span class="comment-author">
                                            <a href="##" rel="external nofollow"><%=commentList.get(i).getAuthor()%></a>
                                        </span>
                                    </div>
                                    <div class="comment-content">
                                        <span class="comment-author-at"></span>
                                        <p><%=commentList.get(i).getContent()%></p>
                                    </div>
                                    <div class="comment-meta">
                                        <time class="comment-time">
                                            <%=TimeTransform.TimeStamp2Date(commentList.get(i).getCreated())%>
                                        </time>
                                        <span class="comment-reply"></span>
                                    </div>
                                </div>
                            </div>
                        </li>
                    <% } %>
                </ol>
                <%--<div class="lists-navigator clearfix">
                    <ol class="page-navigator">
                        <th:block th:if="${comments.hasPreviousPage}">
                            <li class="prev"><a th:href="'?cp='+${comments.prePage}+'#comments'">←</a></li>
                        </th:block>
                        <th:block th:each="navIndex : ${comments.navigatepageNums}">
                            <li th:class="${comments.pageNum}==${navIndex}?'current':''"><a
                                    th:href="'?cp='+${navIndex}+'#comments'" th:text="${navIndex}"></a>
                            </li>
                        </th:block>
                        <th:block th:if="${comments.hasNextPage}">
                            <li class="next"><a th:href="'?cp='+${comments.nextPage}+'#comments'">→</a></li>
                        </th:block>
                    </ol>

                </div>--%>
            </div>
            <% } %>
        </div>
    </div>
</div>
<script type="text/javascript" src="<%=path%>/static/user/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
    function subComment(){
        var author=$('#author').val();
        var url=$('#url').val();
        var mail=$('#mail').val();
        var content=$('#textarea').val();
        var cid=$('.comment-container').attr('id');
        $.ajax({
            type:'POST',
            url:'../comment/add',
            data:{author:author,url:url,mail:mail,content:content,cid:cid},
            success:function(data){
                if(data=='success'){
                    alert("提交成功");
                    window.location.reload();
                    $('#author').val('');
                    $('#mail').val('');
                    $('#url').val('');
                    $('#textarea').val('');
                }
            }
        })
    }
</script>
</body>
</html>
