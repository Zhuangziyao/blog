<%@ page import="com.blog.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath(); %>
<html>
<head>
    <title>个人设置</title>
    <link rel="shortcut icon" href="<%=path %>/static/admin/images/favicon.ico" type="image/x-icon"/>
</head>
<body>
<div id="wrapper">
    <jsp:include page="header.jsp"/>
    <div class="content-page">
        <div class="content">
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <h4 class="page-title">个人设置</h4>
                    </div>
                    <%User user = (User) session.getAttribute("user");%>
                    <div class="col-md-6">
                        <div class="panel panel-color panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">个人信息</h3>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal" role="form" id="user-form">
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">账号</label>
                                        <div class="col-md-9">
                                            <input name="userName" type="text" value="<%=user.getUserName()%>"
                                                   class="form-control" readonly="readonly" disabled="disabled"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">姓名</label>
                                        <div class="col-md-9">
                                            <input id="screenName" type="text" class="form-control" name="screenName"
                                                   placeholder="输入您的姓名"
                                                   value="<%=user.getScreenName()%>" required="required"
                                                   aria-required="true"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">邮箱</label>
                                        <div class="col-md-9">
                                            <input id="email" type="text" class="form-control" name="email"
                                                   placeholder="输入您的邮箱"
                                                   value="<%=user.getEmail()%>" required="required"
                                                   aria-required="true"/>
                                        </div>
                                    </div>
                                    <div class="clearfix pull-right">
                                        <button type="button" class="btn btn-primary waves-effect waves-light"
                                                onclick="saveSetting()">
                                            保存信息
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="panel panel-color panel-danger">
                            <div class="panel-heading">
                                <h3 class="panel-title">修改密码</h3>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal" role="form" id="pwd-form">
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">输入旧密码</label>
                                        <div class="col-md-9">
                                            <input id="oldPassword" type="password" class="form-control"
                                                   name="oldPassword" required="required"
                                                   aria-required="true"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">输入新密码</label>
                                        <div class="col-md-9">
                                            <input type="password" name="password" id="password1" class="form-control"
                                                   required="required"
                                                   aria-required="true" rangelength="[6,14]"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">确认新密码</label>
                                        <div class="col-md-9">
                                            <input type="password" name="repass" class="form-control"
                                                   equalTo="#password1"/>
                                        </div>
                                    </div>
                                    <div class="clearfix pull-right">
                                        <button type="submit" class="btn btn-danger waves-effect waves-light">
                                            设置密码
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
<script src="https://cdn.bootcss.com/jquery-validate/1.15.1/jquery.validate.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-validate/1.15.1/localization/messages_zh.min.js"></script>
<script type="text/javascript">
    //修改信息
    function saveSetting() {
        var screenName = $('#screenName').val();
        var email = $('#email').val();
        $.ajax({
            type: 'POST',
            url: './profile/update',
            data: {screenName: screenName, email: email},
            success: function (data) {
                if (data == 'success') {
                    alert("修改成功");
                    window.location.reload();
                } else {
                    alert("修改失败");
                }
            }
        })
    }

    //修改密码
    $('#pwd-form').validate({
        submitHandler: function (form) {
            var old = $('#oldPassword').val();
            var newp = $('#password1').val();
            $.ajax({
                type: 'POST',
                url: './profile/updatePassword',
                data: {oldPwd: old, newPwd: newp},
                success: function (result) {
                    if (result == 'success') {
                        alert('密码修改成功');
                    } else {
                        alert('密码修改失败');
                    }
                }
            });
        }
    });
</script>
</body>
</html>
