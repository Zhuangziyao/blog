<%@ page import="com.blog.model.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath(); %>
<html>
<head>
    <title>用户管理</title>
    <link rel="shortcut icon" href="<%=path %>/static/admin/images/favicon.ico" type="image/x-icon"/>
</head>
<body class="fixed-left">
<jsp:include page="header.jsp"/>
<div id="wrapper">
    <div class="content-page">
        <div class="content">
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <h4 class="page-title">用户管理</h4>
                    </div>
                    <div class="col-md-12">
                        <table class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th>序号</th>
                                <th>用户帐号</th>
                                <th>密码</th>
                                <th>用户名称</th>
                                <th>用户邮箱</th>
                                <th>用户级别</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <% List<User> useres = (List<User>) request.getAttribute("useres");
                                for (int i = 0; i < useres.size(); i++) { %>
                            <tr>
                                <td style="display: none"><%=useres.get(i).getuId()%>
                                </td>
                                <td><%=(i + 1)%>
                                </td>
                                <td><%=useres.get(i).getUserName()%>
                                </td>
                                <td><%=useres.get(i).getPassword()%>
                                </td>
                                <td><%=useres.get(i).getScreenName()%>
                                </td>
                                <td><%=useres.get(i).getEmail() %>
                                </td>
                                <td><%=useres.get(i).getGroupName()%>
                                </td>
                                <td>
                                    <a href="javascript:void(0)" onclick="editUser(this)"
                                       class="btn btn-primary btn-sm waves-effect waves-light m-b-5"><i
                                            class="fa fa-edit"></i> <span>编辑</span></a>
                                    <a href="javascript:void(0)" onclick="delUser(this)"
                                       class="btn btn-danger btn-sm waves-effect waves-light m-b-5"><i
                                            class="fa fa-trash-o"></i> <span>删除</span></a>
                                </td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                    <div class="add-user row">
                        <div class="col-sm-12">
                            <div class="panel panel-color panel-primary">
                                <div class="panel-heading">
                                    <h3 class="panel-title">用户设置</h3>
                                </div>
                            </div>
                            <form class="user-form form-inline panel-body"
                                  style="padding-left: 20px;padding-right: 20px;">
                                <input style="display: none" name="uId" id="uId">
                                <div>
                                    <label style="" class="col-md-1 control-label">用户帐号 </label>
                                    <input class="col-md-2" style="" type="text" name="userName" id="userName">

                                </div>
                                <div>
                                    <label style="" class="col-md-1 control-label">用户名 </label>
                                    <input class="col-md-2" style="" type="text" name="screenName" id="screenName">

                                </div>
                                <div>
                                    <label style="" class="col-md-1 control-label">密码 </label>
                                    <input class="col-md-2" style="" type="text" name="password" id="password">

                                </div>
                                <div style="">
                                    <label style="" class="col-md-1 control-label">组别 </label>
                                    <select class="col-md-2" style="" type="text" name="groupName" id="groupName">
                                        <option value="super">super</option>
                                        <option value="admin">admin</option>
                                        <option value="visitor" selected="selected">visitor</option>
                                    </select>

                                </div>
                                <div style="">
                                    <label style="width: 100px;" class="col-md-1 control-label">邮箱 </label>
                                    <input class="col-md-2" style="" type="text" name="email" id="email"
                                           placeholder="可空">

                                </div>
                                <div style="">
                                    <label style="" class="col-md-1 control-label">HomeUrl </label>
                                    <input class="col-md-2" style="" type="text" name="homeUrl" id="homeUrl"
                                           placeholder="可空">
                                </div>
                                <div style="">
                                    <label class="col-md-1 control-label">Activated </label>
                                    <input class="col-md-2" style="" type="text" name="activated" id="activated"
                                           placeholder="可空">

                                </div>
                                <div style="">
                                    <label class="col-md-1 control-label">Logged </label>
                                    <input class="col-md-2" style="" type="text" name="logged" id="logged"
                                           placeholder="可空">

                                </div>
                                <button class="btn btn-pink btn-sm waves-effect waves-light m-b-5" id="user-btn">
                                    <i class="fa fa-paw"></i> <span>添加用户</span></button>
                                <button class="btn btn-purple btn-sm waves-effect waves-light m-b-5" id="clear-btn">
                                    <i class="fa fa-trash-o"></i> <span>清空</span></button>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
<script type="text/javascript">
    function editUser(obj) {
        var uName = $(obj).parents('tr').find('td:eq(2)').text();
        $.ajax({
            type: 'POST',
            url: './user/get',
            data: {uname: uName},
            success: function (data) {
                $('#userName').val(data.userName);
                $("#userName").attr("disabled", "disabled");
                $('#screenName').val(data.screenName);
                $('#uId').val(data.uId);
                $('#password').val(data.password);
                $('#homeUrl').val(data.homeUrl);
                $('#email').val(data.email);
                $('#groupName').val(data.groupName);
                $('#activated').val(data.activated);
                $('#logged').val(data.logged);
                $('#user-btn').text('编辑用户');
            }
        })
    }

    function delUser(obj) {
        var uName = $(obj).parents('tr').find('td:eq(2)').text();
        $.ajax({
            type: 'POST',
            url: './user/delete',
            data: {uname: uName},
            success: function (data) {
                if (data == 'success') {
                    alert('删除成功');
                    window.location.reload();
                }
            }
        })
    }

    $('#clear-btn').click(function () {
        $('#userName').val();
        $("#userName").removeAttr("disabled");
        $('#screenName').val();
        $('#uId').val();
        $('#password').val();
        $('#homeUrl').val();
        $('#email').val();
        $('#groupName').val();
        $('#activated').val();
        $('#logged').val();
        $('#user-btn').text('添加用户');
    })

    $('#user-btn').click(function () {
        if ($('#userName').val() == '') {
            alert('用户名不能为空');
            return;
        }
        if ($('#password').val() == '') {
            alert('密码不能为空');
            return;
        }
        var param = $('.user-form').serialize();
        if ($('#user-btn').text() == '编辑用户') {
            $.ajax({
                type: 'POST',
                url: './user/edit',
                data: param,
                success: function (data) {
                    if (data == 'success')
                        alert('编辑成功');
                    window.location.reload();
                }
            })
        }
        if ($('#user-btn').text() == '添加用户') {
            $.ajax({
                type: 'POST',
                url: './user/add',
                data: param,
                success: function (data) {
                    if (data == 'success') {
                        alert('添加成功');
                        window.location.reload();
                    }
                }
            })
        }
    })
</script>
</body>
</html>
