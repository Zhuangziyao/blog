<%@ page import="com.blog.model.Attach" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<% String path=request.getContextPath();
    String attachPath=request.getSession().getServletContext().getRealPath("/upload");%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传附件</title>
    <link rel="shortcut icon" href="<%=path %>/static/admin/images/favicon.ico" type="image/x-icon"/>
    <link href="https://cdn.bootcss.com/dropzone/5.4.0/dropzone.css" rel="stylesheet">
</head>
<style>
    #dropzone {
        margin-bottom: 3rem;
    }

    .dropzone {
        border: 2px dashed #0087F7;
        border-radius: 5px;
        background: white;
    }

    .dropzone .dz-message {
        font-weight: 400;
    }

    .dropzone .dz-message .note {
        font-size: 0.8em;
        font-weight: 200;
        display: block;
        margin-top: 1.4rem;
    }

    .attach-img {
        width: 100px;
        height: 100px;
        border-radius: 10px;
        box-shadow: 0px 0px 8px #333;
    }

    .attach-text {
        font-size: 12px;
        font-weight: 300;
    }

    .attach-img:hover {
        background-color: #f9f9f9;
    }
</style>
<body class="fixed-left">
<jsp:include page="header.jsp"/>
<div id="wrapper">
    <div class="content-page">
        <div class="content">
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <h4 class="page-title">文件管理</h4>
                    </div>
                    <div class="row">
                        <div class="col-md-12 portlets">
                            <!-- Your awesome content goes here -->
                            <div class="m-b-30">
                                <form action="#" class="dropzone" id="dropzone">
                                    <div class="fallback">
                                        <input name="file" type="file" multiple="multiple"/>
                                    </div>
                                    <div class="dz-message">
                                        将文件拖至此处或点击上传.
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12 attach">
                        <% List<Attach> attaches=(List<Attach>)request.getAttribute("attaches");
                            if(attaches==null || attaches.size()==0){ %>
                            <div class="row">
                                <div class="col-md-4 text-center">
                                    <div class="alert alert-warning">
                                        目前还没有一个附件呢，你可以上传试试!
                                    </div>
                                </div>
                            </div>
                            <% }else{
                                 for(int i=0;i<attaches.size();i++){ %>
                                <div class="col-md-2 text-center m-t-10">
                                    <a href="..<%=attaches.get(i).getFkey()%>" target="_blank">
                                        <img class="attach-img"
                                             src="<%=attaches.get(i).getFtype().equals("image") ? path+attaches.get(i).getFkey() : path+"/static/admin/images/attach.png" %>"
                                             title="<%=attaches.get(i).getFname()%>"/>
                                    </a>
                                    <div class="clearfix m-t-10">
                <span class="attach-text" data-toggle="tooltip" data-placement="top"
                      data-original-title="<%=attaches.get(i).getFname()%>"><%=attaches.get(i).getFname()%></span>
                                    </div>
                                    <div class="clearfix">
                                        <button url="<%=path+attaches.get(i).getFkey()%>" type="button"
                                                class="btn btn-warning btn-sm waves-effect waves-light m-t-5 copy">
                                            <i class="fa fa-copy"></i> <span>复制</span>
                                        </button>
                                        <div style="display:none;"><%=attaches.get(i).getId()%></div>
                                        <button type="button"
                                                class="btn btn-danger btn-sm waves-effect waves-light m-t-5"
                                                onclick="delAttach(this)">
                                            <i class="fa fa-trash-o"></i> <span>删除</span>
                                        </button>
                                    </div>
                                </div>
                            <% }
                            } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
<script src="https://cdn.bootcss.com/dropzone/5.4.0/dropzone.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/clipboard.js/1.6.0/clipboard.min.js"></script>
<script type="text/javascript">
    $("#dropzone").dropzone({
        paramName: "file",
        method:'POST',
        url: "./attach/upload",
        maxFilesize: 1,
        init: function () {
            this.on("success", function (file, msg) {
                console.log(file);
                console.log(msg);
                if (msg != "success") {
                    alert('上传文件大于1M');
                }else{
                    alert('上传成功');
                }
                setTimeout(function () {
                    window.location.reload();
                }, 200);
            });
        }
    });
    var clipboard = new Clipboard('button.copy', {
        text: function (trigger) {
            return $(trigger).attr('url');
        }
    });

    clipboard.on('success', function (e) {
        console.info('Action:', e.action);
        console.info('Text:', e.text);
        console.info('Trigger:', e.trigger);
        e.clearSelection();
    });

    //删除附件
    function delAttach(obj){
        var id=$(obj).siblings("div").text();
        $.ajax({
            type:'POST',
            data:{id:id},
            url:'./attach/delete',
            success:function(data){
                if(data=='success'){
                    alert("删除成功");
                    window.location.reload();
                }else{
                    alert("删除失败");
                    window.location.reload();
                }
            }
        })
    }

</script>
</body>
</html>