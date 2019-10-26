<%@ page import="com.blog.model.Comment" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blog.common.util.common" %>
<%@ page import="com.blog.common.util.TimeTransform" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%String path = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" href="<%=path %>/static/admin/images/favicon.ico" type="image/x-icon"/>
    <title>评论管理</title>
</head>
<body class="fixed-left">
<jsp:include page="header.jsp"/>
<div id="wrapper">
    <div class="content-page">
        <div class="content">
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <h4 class="page-title">评论管理</h4>
                    </div>
                    <div class="col-md-12">
                        <table class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th>评论内容</th>
                                <th>评论人</th>
                                <th>评论时间</th>
                                <th>评论人邮箱</th>
                                <th>评论人网址</th>
                                <th>评论状态</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <% List<Comment> comments = (List<Comment>) request.getAttribute("comments");
                                for (int i = 0; i < comments.size(); i++) { %>
                            <tr>
                                <td style="display: none"><%=comments.get(i).getCoid()%>
                                </td>
                                <td>
                                    <a href="../article/<%=comments.get(i).getCid()%>#comments"
                                       target="_blank"><%=comments.get(i).getContent()%>
                                    </a>
                                </td>
                                <td><%=comments.get(i).getAuthor()%>
                                </td>
                                <td><%=TimeTransform.TimStamp2Time(comments.get(i).getCreated())%>
                                </td>
                                <td><%=comments.get(i).getMail()%>
                                </td>
                                <td><a href="<%=comments.get(i).getUrl()%>" target="_blank">
                                    <%=comments.get(i).getUrl() %>
                                </a>
                                </td>
                                <td>
                                    <% if (comments.get(i).getStatus().equals("approved")) { %>
                                    <span class="label label-success">审核通过</span>
                                    <% } %>
                                    <% if (comments.get(i).getStatus().equals("not_audit")) { %>
                                    <span class="label label-default">未审核</span>
                                    <% } %>
                                </td>
                                <td>
                                    <% if (comments.get(i).getStatus().equals("not_audit")) { %>
                                    <a href="javascript:void(0)"
                                       onclick="updateStatus(this)"
                                       class="btn btn-success btn-sm waves-effect waves-light m-b-5"><i
                                            class="fa fa-check-square-o"></i> <span>通过</span></a>
                                    <% } %>
                                    <a href="javascript:void(0)" onclick="delComment(this)"
                                       class="btn btn-danger btn-sm waves-effect waves-light m-b-5"><i
                                            class="fa fa-trash-o"></i> <span>删除</span></a>
                                </td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
<script type="text/javascript" src="<%=path%>/static/user/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
    //通过审核
    function updateStatus(obj) {
        var coid = $(obj).parents('tr').find("td:eq(0)").text();
        $.ajax({
            type: 'POST',
            url: './comments/approve',
            data: {coid: coid},
            success: function (data) {
                if (data == "success") {
                    alert("通过审核");
                    window.location.reload();
                }
            }
        })
    }

    //删除评论
    function delComment(obj) {
        var coid = $(obj).parents('tr').find('td:eq(0)').text();
        $.ajax({
            type: 'POST',
            url: './comments/delete',
            data: {coid: coid},
            success: function (data) {
                if (data == "success") {
                    alert("删除成功");
                    window.location.reload();
                }
            }
        })
    }
</script>
</body>
</html>