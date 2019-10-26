<%@ page import="com.blog.common.util.common" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%String path = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>BPG Blog - 登录</title>
    <link href="<%=path %>/static/admin/images/favicon.ico" rel="shortcut icon"/>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/>
    <link href="<%=path %>/static/admin/css/style.min.css" rel="stylesheet" type="text/css"/>
    <link href="https://cdn.bootcss.com/limonte-sweetalert2/6.4.1/sweetalert2.min.css" rel="stylesheet"/>
    <style type="text/css">
        body {
            position: absolute;
            width: 100%;
            height: 100%;
            background: url("<%=path%>/static/admin/images/bg/<%=common.rand(1,5)%>.png");
            background-size: cover;
        }

        .panel-shadow {
            -moz-box-shadow: 0px 0px 10px 0px rgba(39, 49, 65, 0.1);
            -webkit-box-shadow: 0px 0px 10px 0px rgba(39, 49, 65, 0.1);
            box-shadow: 0px 0px 10px 0px rgba(39, 49, 65, 0.1);
        }

        .bg-overlay {
            -moz-border-radius: 6px 6px 0 0;
            -webkit-border-radius: 6px 6px 0 0;
            background-color: rgba(47, 51, 62, 0.3);
            border-radius: 6px 6px 0 0;
            height: 100%;
            left: 0;
            position: absolute;
            top: 0;
            width: 100%;
        }

        .input-border {
            b1 . png
            font-size: 14px;
            width: 100%;
            height: 40px;
            border-radius: 0;
            border: none;
            border-bottom: 1px solid #dadada;
        }

        .bg-img > h3 {
            text-shadow: 0px 2px 3px #555;
            color: #cac9c8;
        }
    </style>
</head>
<body>
<div style="margin: 0 auto; padding-bottom: 0%; padding-top: 7.5%; width: 380px;">
    <div class="panel panel-color panel-danger panel-pages panel-shadow">
        <div class="panel-heading bg-img">
            <div class="bg-overlay"></div>
            <h3 class="text-center m-t-10"> Login BPM Blog</h3>
        </div>
        <div class="panel-body">
            <form class="form-horizontal m-t-20" method="post" id="loginForm" onsubmit="return checkForm()">
                <div class="form-group">
                    <div class="col-xs-12">
                        <input class="input-lg input-border" id="username" name="username" type="text" required="true"
                               placeholder="帐号:"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-12">
                        <input class="input-lg input-border" id="password" name="password" type="password"
                               required="true" placeholder="密码:"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-12">
                        <div class="checkbox checkbox-danger">
                            <input id="checkbox-signup" name="remeber_me" type="checkbox"/>
                            <label for="checkbox-signup">记住我</label>
                        </div>
                    </div>
                </div>
                <div class="form-group text-center m-t-40">
                    <div class="col-xs-12">
                        <button class="btn btn-danger btn-lg btn-rounded btn-block w-lg waves-effect waves-light"
                                style="box-shadow: 0px 0px 4px #868282;" type="submit" onclick="checkForm">登&nbsp;录
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.bootcss.com/jquery/2.2.3/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/static/user/js/jquery.cookie.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.bootcss.com/limonte-sweetalert2/6.4.1/sweetalert2.min.js"></script>
<script src="<%=path %>/static/admin/js/base.js"></script>
<script>
    //判断是否是记住我了
    if ($.cookie("username") != null && $.cookie("password") != null) {
        $('#checkbox-signup').prop("checked", true);
        $('#username').val($.cookie("username"));
        $("#password").val($.cookie("password"));
    }

    //判断登录
    function checkForm() {
        //记住我
        if ($('#checkbox-signup').prop("checked") == true && $.cookie("username") == null) {
            $.cookie("username", $('#username').val(), {expires: 7});
            $.cookie("password", $('#password').val(), {expires: 7});
        } else if ($('#checkbox-signup').prop("checked") == false) {
            //删除cookie
            $.cookie("username", null, {expires: -1});
            $.cookie("password", null, {expires: -1});
        }

        $.ajax({
            type: 'POST',
            url: './admin/login',
            data: $("#loginForm").serialize(),
            success: function (data) {
                console.log(data);
                if (data == "SUCCESS") {
                    window.location.href = "./admin/index";
                } else {
                    alert("帐号或密码错误");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                // 状态码
                console.log(XMLHttpRequest.status);
                // 状态
                console.log(XMLHttpRequest.readyState);
                // 错误信息
                console.log(textStatus);
            }

        });
        return false;
    }


</script>
</body>
</html>