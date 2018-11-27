<%@ page import="com.blog.model.Article" %>
<%@ page import="com.blog.model.Meta" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blog.common.util.common" %>
<%@ page import="com.blog.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<% String path=request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文章发布</title>
    <link rel="shortcut icon" href="<%=path %>/static/admin/images/favicon.ico" type="image/x-icon"/>
<link href="<%=path%>/static/admin/plugins/tagsinput/jquery.tagsinput.css" rel="stylesheet"/>
<link href="<%=path%>/static/admin/plugins/select2.dist.css/select2-bootstrap.css" rel="stylesheet"/>
<link href="<%=path%>/static/admin/plugins/toggles/toggles.css" rel="stylesheet"/>
<link href="//cdn.bootcss.com/multi-select/0.9.12/css/multi-select.css" rel="stylesheet"/>
<link href="//cdn.bootcss.com/select2/3.4.8/select2.min.css" rel="stylesheet"/>
<link href="<%=path%>/static/admin/plugins/md/css/style.css" rel="stylesheet"/>
<link href="<%=path%>/static/admin/plugins/editor.md-master/css/editormd.css" rel="stylesheet" />
<style>
    #tags_tagsinput {
        background-color: #fafafa;
        border: 1px solid #eeeeee;
    }

    #tags_addTag input {
        width: 100%;
    }

    #tags_addTag {
        margin-top: -5px;
    }
</style>
</head>
<body class="fixed-left">
<jsp:include page="header.jsp"/>
<div id="wrapper">
    <div class="content-page">
        <div class="content">
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <h4 class="page-title">
                            <% Article article=(Article) request.getAttribute("article");
                             if(article!=null){ %>
                                编辑文章
                             <% }else{ %>
                                发布文章
                             <% } %>
                        </h4>
                    </div>
                    <div class="col-md-12">
                        <form id="articleForm" role="form" novalidate="novalidate">
                            <input type="hidden" name="categories" id="categories"/>
                            <input type="hidden" name="cid"
                                   value="<%=article==null?"":article.getCid()%>" id="cid"/>
                            <input type="hidden" name="status"
                                   value="<%=article!=null?article.getStatus():"publish"%>"
                                   id="status"/>
                            <input type="hidden" name="allowComment"
                                   value="<%=article!=null?article.getAllowComment():"true"%>"
                                   id="allow_comment"/>
                            <input type="hidden" name="allowPing"
                                   value="<%=article!=null?article.getAllowPing():"true"%>"
                                   id="allow_ping"/>
                            <input type="hidden" name="allowFeed"
                                   value="<%=article!=null?article.getAllowFeed():"true"%>"
                                   id="allow_feed"/>
                            <input type="hidden" name="content" id="content-editor"/>
                            <%User user=(User)request.getSession().getAttribute("user");%>
                            <input type="hidden" name="authorId" id="author_id"
                                   value="<%=user.getuId()%>"/>
                            <div class="form-group col-md-6" style="padding: 0 10px 0 0;">
                                <input type="text" class="form-control" placeholder="请输入文章标题（必须）" name="title"
                                       required="required"
                                       aria-required="true"
                                       value="<%=article!=null&&article.getTitle()!=null?article.getTitle():""%>"/>
                            </div>

                            <div class="form-group col-md-6" style="padding: 0 0 0 10px;">
                                <input type="text" class="form-control" disabled="disabled"
                                       placeholder="自定义访问路径，如：my-first-article  默认为文章id" name="slug"/>
                            </div>

                            <div class="form-group col-md-6" style="padding: 0 10px 0 0;">
                                <input name="tags" id="tags" type="text" class="form-control" placeholder="请填写文章标签"
                                       value="<%=article!=null&&article.getTags()!=null?article.getTags():""%>"/>
                            </div>

                            <div class="form-group col-md-6">
                                <select id="multiple-sel" class="select2 form-control"
                                        data-placeholder="请选择分类...">
                                    <% if(article==null||article.getCategories()==null){
                                        List<Meta> metas=(List<Meta>)request.getAttribute("categories");
                                        for(int i=0;i<metas.size();i++){ %>
                                            <option value="<%=metas.get(i).getName()%>"><%=metas.get(i).getName()%></option>
                                    <%  }
                                        }else{
                                        List<Meta> metas=(List<Meta>)request.getAttribute("categories");
                                            for(int i=0;i<metas.size();i++){
                                                if(article.getCategories().contains(metas.get(i).getName())){%>
                                            <option value="<%=metas.get(i).getName()%>" selected="selected"><%=metas.get(i).getName()%></option>
                                                <% }else{ %>
                                            <option value="<%=metas.get(i).getName()%>"><%=metas.get(i).getName()%></option>
                                    <%          }
                                            }
                                        } %>
                                </select>
                            </div>
                            <div class="clearfix"></div>
                            <%--<div class="form-group">
                                <textarea style="height: 450px" autocomplete="off" id="text" name="text"
                                          class="markdown-textarea"><%=article!=null&&article.getContent()!=null?article.getContent():""%></textarea>
                            </div>--%>
                            <div id="content-editormd" class="form-group">
                                <textarea style="height:450px" class="form-control" id="text" name="content-editormd-markdown-doc"><%=article!=null&&article.getContent()!=null?article.getContent():""%></textarea>
                            </div>
                            <div class="form-group col-md-3 col-sm-4">
                                <label class="col-sm-4">开启评论</label>
                                <div class="col-sm-8">
                                    <div class="<%=article!=null&&article.getAllowComment()!=null?"toggle toggle-success allow-"+article.getAllowComment():"toggle toggle-success allow-true"%>"
                                         onclick="allow_comment(this);"></div>
                                </div>
                            </div>

                            <div class="form-group col-md-3 col-sm-4">
                                <label class="col-sm-4">允许Ping</label>
                                <div class="col-sm-8">
                                    <div class="<%=article!=null&&article.getAllowPing()!=null?"toggle toggle-success allow-"+article.getAllowPing():"toggle toggle-success allow-true"%>"
                                         onclick="allow_ping(this);"></div>
                                </div>
                            </div>

                            <div class="form-group col-md-3 col-sm-4">
                                <label class="col-sm-4">允许订阅</label>
                                <div class="col-sm-8">
                                    <div class="<%=article!=null&&article.getAllowFeed()!=null?"toggle toggle-success allow-"+article.getAllowFeed():"toggle toggle-success allow-true"%>"
                                         onclick="allow_feed(this);"></div>
                                </div>
                            </div>

                            <div class="clearfix"></div>

                            <div class="text-right">
                                <a class="btn btn-default waves-effect waves-light" href="../article">返回列表</a>
                                <button type="button" class="btn btn-primary waves-effect waves-light"
                                        onclick="subArticle('publish');">
                                    保存文章
                                </button>
                                <button type="button" class="btn btn-warning waves-effect waves-light"
                                        onclick="subArticle('draft');">
                                    存为草稿
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
<script type="text/javascript" src="<%=path%>/static/admin/plugins/tagsinput/jquery.tagsinput.min.js"></script>
<script type="text/javascript" src="<%=path%>/static/admin/plugins/jquery-multi-select/jquery.quicksearch.js"></script>
<script type="text/javascript" src="<%=path%>/static/admin/plugins/md/js/diff.js"></script>
<script type="text/javascript" src="<%=path%>/static/admin/plugins/md/js/md.js"></script>
<%--<script type="text/javascript" src="<%=path%>/static/admin/plugins/md/js/pagedown-extra.js"></script>--%>
<script type="text/javascript" src="<%=path%>/static/admin/plugins/md/js/pagedown.js"></script>
<script type="text/javascript" src="<%=path%>/static/admin/plugins/md/js/jquery.scrollto.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/multi-select/0.9.12/js/jquery.multi-select.min.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/select2/3.4.8/select2.min.js"></script>
<script type="text/javascript" src="<%=path%>/static/admin/plugins/jquery-toggles/toggles.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/jquery-toggles/2.0.4/toggles.min.js"></script>
<script type="text/javascript" src="<%=path%>/static/admin/plugins/editor.md-master/editormd.min.js"></script>
<script type="text/javascript">
    $(function() {
        editormd("content-editormd", {
            width   : "100%",
            height  : 450,
            syncScrolling : "single",
            path    : "<%=request.getContextPath()%>/static/admin/plugins/editor.md-master/lib/",
            saveHTMLToTextarea : true, // 保存HTML到Textarea
        });
    });
    // Tags Input
    $('#tags').tagsInput({
        width: '100%',
        height: '35px',
        defaultText: '请输入文章标签'
    });

    $('.toggle').toggles({
        on: true,
        text: {
            on: '开启',
            off: '关闭'
        }
    });

    $('div.allow-false').toggles({
        off: true,
        text: {
            on: '开启',
            off: '关闭'
        }
    });

    $(".select2").select2({
        width: '100%'
    });

    //保存文章
    function subArticle(status){
        var title = $('#articleForm input[name=title]').val();
        var content = $('#text').val();
        if (title == '') {
            alert('请输入文章标题');
            return;
        }
        if (content == '') {
            alert('请输入文章内容');
            return;
        }
        $('#content-editor').val(content);
        $("#articleForm #status").val(status);
        $("#articleForm #categories").val($('#multiple-sel').val());
        var params = $("#articleForm").serialize();
        $.ajax({
            type:'POST',
            data:params,
            url:'../../admin/article/modify',
            success:function(data){
                if(data=='success'){
                    alert('保存文章成功');
                    window.location.href='../../admin/article';
                }
            },
            error:function(XMLHttpRequest, textStatus, errorThrown) {
                // 状态码
                console.log(XMLHttpRequest.status);
                // 状态
                console.log(XMLHttpRequest.readyState);
                // 错误信息
                console.log(textStatus);
            }
        })
    }

    function allow_ping(obj){
        var this_ = $(obj);
        var on = this_.find('.toggle-on.active').length;
        var off = this_.find('.toggle-off.active').length;
        if (on == 1) {
            $('#allow_ping').val(false);
        }
        if (off == 1) {
            $('#allow_ping').val(true);
        }
    }

    function allow_feed(obj){
        var this_ = $(obj);
        var on = this_.find('.toggle-on.active').length;
        var off = this_.find('.toggle-off.active').length;
        if (on == 1) {
            $('#allow_feed').val(false);
        }
        if (off == 1) {
            $('#allow_feed').val(true);
        }
    }

    function allow_comment(obj){
        var this_ = $(obj);
        var on = this_.find('.toggle-on.active').length;
        var off = this_.find('.toggle-off.active').length;
        if (on == 1) {
            $('#allow_comment').val(false);
        }
        if (off == 1) {
            $('#allow_comment').val(true);
        }
    }



</script>
</body>
</html>