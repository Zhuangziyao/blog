<%@ page import="com.blog.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%String path = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8"/>
    <title>博客后台 - BPM Blog</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta content="Coderthemes" name="author"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="<%=path %>/static/admin/css/style.min.css" rel="stylesheet" type="text/css"/>
    <link href="https://cdn.bootcss.com/limonte-sweetalert2/6.4.1/sweetalert2.min.css" rel="stylesheet"/>
</head>
<body>
<div class="topbar">
    <div class="topbar-left">
        <div class="text-center p-t-10" style="margin: 0 auto;">
            <div class="pull-left" style="padding-left: 10px;">
                <a href="./index">
                    <img src="<%=path %>/static/admin/images/logo.png" width="50" height="50"/>
                </a>
            </div>
            <div class="pull-left" style="padding-left: 10px;">
                <span style="font-size: 28px; color: #2f353f; line-height: 50px;">BPM Blog</span>
            </div>
        </div>
    </div>
    <div class="navbar navbar-default" role="navigation">
        <div class="container">
            <div class="">
                <div class="pull-left">
                    <button type="button" class="button-menu-mobile open-left">
                        <i class="fa fa-bars"></i>
                    </button>
                    <span class="clearfix"></span>
                </div>

                <ul class="nav navbar-nav navbar-right pull-right" style="height: 60px">
                    <li class="dropdown" style="height: 60px">
                        <a href="" class="dropdown-toggle profile" data-toggle="dropdown"
                           aria-expanded="true" style="width:60px;margin-right: 15px">
                            <img src="<%=path%>/static/admin/images/user/user-avatar.png" alt="user-img"
                                 class="img-circle" style="margin-top:5px;width: 60px;height: 60px"/>
                        </a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="../" target="_blank">
                                    <i class="fa fa-eye" aria-hidden="true"></i>查看网站
                                </a>
                            </li>
                            <li><a href="<%=path %>/admin/profile"><i class="fa fa-sun-o"></i> 个人设置</a></li>
                            <li><a href="<%=path %>/admin/logout"><i class="fa fa-sign-out"></i> 注销</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="left side-menu">
    <div class="sidebar-inner slimscrollleft">
        <div id="sidebar-menu">
            <ul>
                <li>
                    <a href="<%=path %>/admin/index">
                        <i class="fa fa-dashboard waves-effect" aria-hidden="true"></i>
                        <span> 仪表盘 </span></a>
                </li>
                <li>
                    <a href="<%=path %>/admin/article/publish">
                        <i class="fa fa-pencil-square-o waves-effect" aria-hidden="true"></i>
                        <span> 发布文章 </span></a>
                </li>
                <li>
                    <a href="<%=path %>/admin/article">
                        <i class="fa fa-list waves-effect" aria-hidden="true"></i>
                        <span> 文章管理 </span></a>
                </li>
                <% User user = (User) session.getAttribute("user");
                    if (user.getGroupName().equals("super")) {%>
                <li>
                    <a href="<%=path %>/admin/user"><i class="fa fa-file-text waves-effect" aria-hidden="true"></i>
                        <span> 用户管理 </span></a>
                </li>
                <% } %>
                <li>
                    <a href="<%=path %>/admin/comments"><i class="fa fa-comments waves-effect" aria-hidden="true"></i>
                        <span> 评论管理 </span></a>
                </li>
                <li>
                    <a href="<%=path %>/admin/category"><i class="fa fa-tags waves-effect" aria-hidden="true"></i>
                        <span> 分类/标签 </span></a>
                </li>
                <li>
                    <a href="<%=path %>/admin/attach"><i class="fa fa-cloud-upload waves-effect" aria-hidden="true"></i>
                        <span> 文件管理 </span></a>
                </li>
                <li>
                    <a href="<%=path %>/admin/links"><i class="fa fa-link waves-effect" aria-hidden="true"></i>
                        <span> 友链管理 </span></a>
                </li>
                <li>
                    <a href="<%=path %>/admin/setting"><i class="fa fa-gear waves-effect" aria-hidden="true"></i>
                        <span> 系统设置 </span></a>
                </li>
            </ul>
            <div class="clearfix"></div>
        </div>
        <div class="clearfix"></div>
    </div>
</div>
<script type="text/javascript" src="<%=path%>/static/user/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
    //动态修改active状态
    $(document).ready(function () {
        var url = window.location.href;
        console.log(url);
        if (url.indexOf("index") != -1) {
            $("#side-menu ul li:eq(0) a").addClass("active");
        } else if (url.indexOf("article/publish") != -1) {
            $("#side-menu ul li:eq(1) a").addClass("active");
        } else if (url.indexOf("/article") != -1) {
            $("#side-menu ul li:eq(2) a").addClass("active");
        } else if (url.indexOf("user") != -1) {
            $("#side-menu ul li:eq(3) a").addClass("active");
        } else if (url.indexOf("comments") != -1) {
            $("#side-menu ul li:eq(4) a").addClass("active");
        } else if (url.indexOf("category") != -1) {
            $("#side-menu ul li:eq(5) a").addClass("active");
        } else if (url.indexOf("attach") != -1) {
            $("#side-menu ul li:eq(6) a").addClass("active");
        } else if (url.indexOf("links") != -1) {
            $("#side-menu ul li:eq(7) a").addClass("active");
        } else if (url.indexOf("setting") != -1) {
            $("#side-menu ul li:eq(8) a").addClass("active");
        }
    })
</script>
</body>
</html>