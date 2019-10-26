<%@ page import="java.util.List" %>
<%@ page import="static com.blog.common.util.common.rand_color" %>
<%@ page import="com.blog.model.MetaDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%String path = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" href="<%=path %>/static/admin/images/favicon.ico" type="image/x-icon"/>
    <title>分类管理</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="content-page">
    <div class="content">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <h4 class="page-title">分类/标签管理</h4>
                </div>
                <div class="col-md-6">
                    <div class="panel panel-color panel-primary">
                        <div class="panel-heading">
                            <h1 class="panel-title">分类列表</h1>
                        </div>
                        <div class="panel-body">
                            <% List<MetaDto> categories = (List<MetaDto>) request.getAttribute("category");
                                for (int i = 0; i < categories.size(); i++) { %>
                            <div class="btn-group m-b-10">
                                <% if (categories.get(i).getName() == "默认分类") { %>
                                <button type="button"
                                        class="btn btn-<%=rand_color()%> dropdown-toggle waves-effect waves-light">
                                    <block><%=categories.get(i).getName()%>
                                    </block>
                                    <block>(<%=categories.get(i).getCount()%>)</block>
                                </button>
                                <% } else { %>
                                <button type="button"
                                        class="btn btn-<%=rand_color()%> dropdown-toggle waves-effect waves-light"
                                        data-toggle="dropdown" aria-expanded="false">
                                    <block><%=categories.get(i).getName()%>
                                    </block>
                                    <block>(<%=categories.get(i).getCount()%>)</block>
                                    <span
                                            class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li><a href="javascript:void(0)" id="<%=categories.get(i).getmId()%>"
                                           name="<%=categories.get(i).getName()%>"
                                           class="edit-category">修改</a>
                                    </li>
                                    <li><a href="javascript:void(0)" id="<%=categories.get(i).getmId()%>"
                                           class="del-category">删除</a></li>
                                </ul>
                                <% } %>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="panel  panel-pink">
                        <div class="panel-heading">
                            <h1 class="panel-title">标签列表</h1>
                        </div>
                        <div class="panel-body">
                            <% List<MetaDto> tags = (List<MetaDto>) request.getAttribute("tags");
                                for (int i = 0; i < tags.size(); i++) { %>
                            <div class="btn-group m-b-10">
                                <button type="button"
                                        class="btn btn-+<%=rand_color()%>+ dropdown-toggle waves-effect waves-light"
                                        data-toggle="dropdown" aria-expanded="false">
                                    <block><%=tags.get(i).getName()%>
                                    </block>
                                    <block>(<%=tags.get(i).getCount()%>)</block>
                                    <span class="caret"></span></button>
                                <ul class="dropdown-menu" role="menu">
                                    <li><a href="javascript:void(0)" id="<%=tags.get(i).getmId()%>"
                                           class="del-category">删除</a></li>
                                </ul>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <form id="cform" class="form-inline" role="form">
                                <input type="hidden" id="mid"/>
                                <div class="form-group">
                                    <input type="text" class="form-control" id="cname" placeholder="请输入分类名称"/>
                                </div>
                                <button id="save-category-btn" type="button"
                                        class="btn btn-success waves-effect waves-light m-l-10">添加分类
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
<script type="text/javascript" src="<%=path%>/static/user/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
    //添加分类
    $('#save-category-btn').click(function () {
        $.ajax({
            type: 'POST',
            url: './category/add',
            data: {cname: $('#cname').val()},
            success: function (data) {
                if (data == 'success') {
                    alert("保存成功");
                    window.location.reload();
                } else {
                    alert("该分类已存在");
                }
            }
        })
    })

    $('.del-category').click(function () {
        $.ajax({
            type: 'POST',
            url: './category/delete',
            data: {mId: $(this).attr('id')},
            success: function (data) {
                if (data == 'success') {
                    alert('删除成功');
                    window.location.reload();
                } else {
                    alert("删除失败");
                }
            }
        })
    })
</script>
</body>
</html>