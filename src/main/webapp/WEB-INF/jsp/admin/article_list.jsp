<%@ page import="com.blog.model.Article" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blog.common.util.TimeTransform" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>文章管理</title>
    <link rel="shortcut icon" href="<%=path %>/static/admin/images/favicon.ico" type="image/x-icon"/>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="content-page">
    <div class="content">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <h4 class="page-title">文章管理</h4>
                </div>
                <div class="col-md-12">
                    <table class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th width="35%">文章标题</th>
                            <th width="15%">发布时间</th>
                            <th>浏览量</th>
                            <th>所属分类</th>
                            <th width="8%">发布状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% List<Article> articles = (List<Article>) request.getAttribute("articles");
                            for (int i = 0; i < articles.size(); i++) {%>
                        <tr>
                            <td style="display:none"><%=articles.get(i).getCid()%>
                            </td>
                            <td>
                                <a href="./article/<%=articles.get(i).getCid()%>"><%=articles.get(i).getTitle()%>
                                </a>
                            </td>
                            <td><%=TimeTransform.TimStamp2Time(articles.get(i).getCreated())%>
                            </td>
                            <td><%=articles.get(i).getHits()%>
                            </td>
                            <td><%=articles.get(i).getCategories()%>
                            </td>
                            <td>
                                <% if (articles.get(i).getStatus().equals("publish")) { %>
                                <span class="label label-success">已发布</span>
                                <% }
                                    if (articles.get(i).getStatus().equals("draft")) { %>
                                <span class="label label-default">草稿</span>
                                <% } %>
                            </td>
                            <td>
                                <a href="./article/<%=articles.get(i).getCid()%>"
                                   class="btn btn-primary btn-sm waves-effect waves-light m-b-5"><i
                                        class="fa fa-edit"></i> <span>编辑</span></a>
                                <a href="javascript:void(0)" onclick="delPost(this)"
                                   class="btn btn-danger btn-sm waves-effect waves-light m-b-5"><i
                                        class="fa fa-trash-o"></i> <span>删除</span></a>
                                <a href="javascript:void(0)" onclick="preview(this)"
                                   class="btn btn-warning btn-sm waves-effect waves-light m-b-5"><i
                                        class="fa fa-rocket"></i> <span>预览</span></a>
                            </td>
                        </tr>
                        <% }%>

                        </tbody>
                    </table>
                    <%--<div th:replace="comm/macros :: pageAdminNav(${articles})"></div>--%>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="background"
     style="position:fixed;top: 0;left: 0;display: none;z-index:990;width: 100%;height: 100%;background-color: #0e2231;opacity: 0.5;"></div>
<div id="preview-box" class="post-content"
     style="position: fixed;z-index: 991;padding: 20px;display: none;margin-top:80px;top:0;left:25%;width: 50%;height: 80%;background-color: #f7f7f7;overflow: scroll;"></div>
<jsp:include page="footer.jsp"/>
<script type="text/javascript" src="<%=path%>/static/user/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
    //删除
    function delPost(object) {
        var cid = $(object).parents('tr').find('td:eq(0)').text();
        $.ajax({
            type: 'POST',
            url: './article/delete',
            data: {cid: cid},
            success: function (data) {
                if (data == 'success') {
                    alert('删除成功');
                    window.location.reload();
                }

            }
        })
    }

    //预览
    function preview(object) {
        var cid = $(object).parents('tr').find('td:eq(0)').text();
        $.ajax({
            type: 'POST',
            url: './article/preview/' + cid,
            success: function (data) {
                $('#preview-box').empty();
                $('#preview-box').append(data.content);
                $('#preview-box').show();
                $('#background').show();
            }
        })
    }

    $('#background').click(function () {
        $('#preview-box').hide();
        $('#background').hide();
    })
</script>
</body>
</html>