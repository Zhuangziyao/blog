<%@ page import="com.blog.model.Meta" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" href="<%=path %>/static/admin/images/favicon.ico" type="image/x-icon"/>
    <title>友链管理</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="content-page">
    <div class="content">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <h4 class="page-title">友链管理</h4>
                </div>
                <div class="col-md-12">
                    <table class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>链接名称</th>
                            <th>链接地址</th>
                            <th>链接LOGO</th>
                            <th>链接排序</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% List<Meta> metaList = (List<Meta>) request.getAttribute("links");
                            for (int i = 0; i < metaList.size(); i++) {%>
                        <tr>
                            <td style="display: none;"><%=metaList.get(i).getmId()%>
                            </td>
                            <td><%=metaList.get(i).getName()%>
                            </td>
                            <td><a href="<%=metaList.get(i).getSlug()%>" target="_blank"><%=metaList.get(i).getSlug()%>
                            </a></td>
                            <td><%=metaList.get(i).getDescription()%>
                            </td>
                            <td><%=metaList.get(i).getSort()%>
                            </td>
                            <td>
                                <a href="javascript:void(0)" onclick="editLink(this);"
                                   class="btn btn-primary btn-sm waves-effect waves-light m-b-5"><i
                                        class="fa fa-edit"></i> <span>编辑</span></a>
                                <a href="javascript:void(0)" onclick="delLink(this);"
                                   class="btn btn-danger btn-sm waves-effect waves-light m-b-5"><i
                                        class="fa fa-trash-o"></i> <span>删除</span></a>
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
                <div class="row">
                    <div class="col-md-12" style="padding: 20px;">
                        <div class="panel panel-primary">
                            <div class="panel-heading"><h3 class="panel-title">保存友链</h3></div>
                            <div class="panel-body">

                                <form id="linkForm" class="form-inline" role="form" onsubmit="return false">

                                    <input type="hidden" id="mId" name="mId"/>

                                    <div class="form-group">
                                        <label class="sr-only">链接标题</label>
                                        <input type="text" id="name" name="name" class="form-control"
                                               placeholder="请输入链接标题"
                                               required="required" aria-required="true"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="sr-only">链接URL</label>
                                        <input type="url" id="slug" name="slug" class="form-control"
                                               placeholder="请输入链接地址" required="required"
                                               aria-required="true"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="sr-only">链接LOGO</label>
                                        <input type="url" id="description" name="description" class="form-control"
                                               placeholder="链接LOGO没有则不输入"/>
                                    </div>

                                    <div class="form-group">
                                        <label class="sr-only">链接排序</label>
                                        <input type="number" id="sort" name="sort" class="form-control" value="0"/>
                                    </div>

                                    <button type="submit" class="btn btn-success waves-effect waves-light m-l-10"
                                            onclick="save()">保存链接
                                    </button>
                                </form>
                            </div> <!-- panel-body -->
                        </div> <!-- panel -->
                    </div> <!-- col -->
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
<script type="text/javascript" src="<%=path%>/static/user/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
    //编辑友链
    function editLink(object) {
        var obj = $(object);
        var mid = obj.parents('tr').find('td:eq(0)').text();
        var title = obj.parents('tr').find('td:eq(1)').text();
        var url = obj.parents('tr').find('td:eq(2)').text();
        var logo = obj.parents('tr').find('td:eq(3)').text();
        var sort = obj.parents('tr').find('td:eq(4)').text();

        $('#linkForm #mId').val(mid);
        $('#linkForm #name').val(title);
        $('#linkForm #slug').val(url);
        $('#linkForm #description').val(logo);
        $('#linkForm #sort').val(sort);
    }

    //删除友链
    function delLink(obj) {
        var mid = $(obj).parents('tr').find('td:eq(0)').text();
        $.ajax({
            type: "POST",
            url: "./links/delete",
            data: {mId: mid},
            success: function (data) {
                if (data == "success")
                    alert("友链删除成功");
                else
                    alert("友链删除失败");
                window.location.reload();
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                // 状态码
                console.log(XMLHttpRequest.status);
                // 状态
                console.log(XMLHttpRequest.readyState);
                // 错误信息
                console.log(textStatus);
            }
        })
    }

    //保存友链
    function save() {
        if ($('#linkForm #name').val() == '' || $('#linkForm #name').val() == null) {
            alert("链接名称不能为空");
            return;
        }
        if ($('#linkForm #slug').val() == '' || $('#linkForm #slug').val() == null) {
            alert('链接url不能为空');
            return;
        }
        var params = $("#linkForm").serialize();
        $.ajax({
            type: "POST",
            url: './links/save',
            data: params,
            success: function (result) {
                $('#linkForm input').val('');
                $('#linkForm #sort').val('0');
                if (result == "success") {
                    alert('友链保存成功');
                } else {
                    alert('友链保存失败');
                }
                window.location.reload();
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
    }
</script>
</body>
</html>