<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<% String path=request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统管理</title>
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
                            <h4 class="page-title">系统设置</h4>
                        </div>
                        <% Map<String,String> map=(Map<String,String>)request.getAttribute("options"); %>
                        <div class="col-md-6">
                            <div class="panel panel-color panel-primary">
                                <div class="panel-heading">
                                    <h3 class="panel-title">全局设置</h3>
                                </div>
                                <div class="panel-body">
                                    <form class="form-horizontal" role="form" id="global-form">
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">站点名称</label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" name="site_title" placeholder="站点名称"
                                                       value="<%=map.get("site_title")%>" required="required" aria-required="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">站点描述</label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" name="site_description" placeholder="站点描述"
                                                       value="<%=map.get("site_description")%>" required="required" aria-required="true"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">ICP备案号</label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" name="site_record" placeholder="ICP备案号"
                                                       value="<%=map.get("site_record")%>" required="required" aria-required="true"/>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-md-3 control-label">博客主题</label>
                                            <div class="col-md-9">
                                                <select name="site_theme" class="form-control">
                                                    <option value="default" selected="<%=map.get("site_theme")%>">默认主题</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="clearfix pull-right">
                                            <button type="button" class="btn btn-primary waves-effect waves-light" onclick="saveSetting()">
                                                保存设置
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="panel panel-color panel-inverse">
                                <div class="panel-heading">
                                    <h3 class="panel-title">个性化设置</h3>
                                </div>
                                <div class="panel-body">
                                    <form id="indivi-form" class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">微博账号</label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" name="social_weibo" value="<%=map.get("social_weibo")%>"
                                                       placeholder="微博账号，不输入则不显示"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">知乎账号</label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" name="social_zhihu" value="<%=map.get("social_zhihu")%>"
                                                       placeholder="知乎账号，不输入则不显示"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">Github账号</label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" name="social_github"
                                                       value="<%=map.get("social_github")%>" placeholder="Github账号，不输入则不显示"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">Twitter账号</label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" name="social_twitter"
                                                       value="<%=map.get("social_twitter")%>" placeholder="Twitter账号，不输入则不显示"/>
                                            </div>
                                        </div>
                                        <div class="clearfix pull-right">
                                            <button type="button" class="btn btn-inverse waves-effect waves-light"
                                                    onclick="saveIndiviSetting()">
                                                保存设置
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>

                        <%--<div class="col-md-6">
                            <div class="panel panel-color panel-success">
                                <div class="panel-heading">
                                    <h3 class="panel-title">系统备份（备份文件包含附件和主题）</h3>
                                </div>
                                <div class="panel-body">
                                    <form id="backupForm" class="form-inline" role="form">

                                        <div class="form-group col-md-6">
                                            <input id="backup_dir" style="width: 100%;" class="form-control" placeholder="请输入备份存放的磁盘路径" required="" aria-required="true" type="text"/>
                                        </div>

                                        <button type="button" class="btn btn-success waves-effect waves-light m-l-10" onclick="backup('attach');">备份文件</button>
                                        <button type="button" class="btn btn-danger waves-effect waves-light m-l-10" onclick="backup('db')">导出数据库SQL</button>
                                    </form>
                                </div>
                            </div>
                        </div>--%>

                    </div>
    </div>
<jsp:include page="footer.jsp"/>
<script type="text/javascript" src="//cdn.bootcss.com/jquery-toggles/2.0.4/toggles.min.js"></script>
<script type="text/javascript">
    /**
     * 保存全局设置
     */
    function saveSetting() {
        var param = $('#global-form').serialize();
        $.ajax({
            type:"POST",
            url : './setting/save',
            data: param,
            success: function (result) {
                if(result == 'success'){
                    alert('设置保存成功');
                } else {
                    alert('设置保存失败');
                }
            }
        });
    }

    /**
     * 保存个性化设置
     */
    function saveIndiviSetting() {
        var param = $('#indivi-form').serialize();
        $.ajax({
            type:"POST",
            url : './setting/save',
            data: param,
            success: function (result) {
                if(result =='success'){
                    alert('设置保存成功');
                } else {
                    alert('设置保存失败');
                }
            }
        });
    }
</script>
</body>
</html>