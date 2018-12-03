<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<% String path=request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BPM - 博客管理</title>
    <link rel="shortcut icon" href="<%=path %>/static/admin/images/favicon.ico" type="image/x-icon"/>
</head>
<body class="fixed-left">
<div id="wrapper">
    <jsp:include page="header.jsp" flush="true"></jsp:include>
    <div class="content-page">
        <div class="content">
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <h4 class="page-title">仪表盘</h4>
                    </div>

                    <div class="row">
                        <div class="col-sm-6 col-lg-3">
                            <div class="mini-stat clearfix bx-shadow bg-info">
                                <span class="mini-stat-icon"><i class="fa fa-quote-right" aria-hidden="true"></i></span>
                                <div class="mini-stat-info text-right">
                                    发表了<span class="counter" id="article"></span>篇文章
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-lg-3">
                            <div class="mini-stat clearfix bg-purple bx-shadow">
                                <span class="mini-stat-icon"><i class="fa fa-comments-o" aria-hidden="true"></i></span>
                                <div class="mini-stat-info text-right">
                                    收到了<span class="counter" id="comment"></span>条留言
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-6 col-lg-3">
                            <div class="mini-stat clearfix bg-success bx-shadow">
                                <span class="mini-stat-icon"><i class="fa fa-cloud-upload"
                                                                aria-hidden="true"></i></span>
                                <div class="mini-stat-info text-right">
                                    上传了<span class="counter" id="attach"></span>个附件
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-6 col-lg-3">
                            <div class="mini-stat clearfix bg-primary bx-shadow">
                                <span class="mini-stat-icon"><i class="fa fa-link" aria-hidden="true"></i></span>
                                <div class="mini-stat-info text-right">
                                    友链了<span class="counter" id="link"></span>个好友
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">最新文章</h4>
                                </div>
                                <div class="panel-body">
                                    <ul class="list-group" id="article-list"></ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">最新留言</h4>
                                </div>
                                <div class="panel-body" id="comment-list"></div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">系统日志</h4>
                                </div>
                                <div class="panel-body">
                                    <ul class="list-group" id="logs"></ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>

<script type="text/javascript">
    $.ajax({
        type:"POST",
        url:"./dashboard",
        dataType:'json',
        success:function (data) {
            $("#article").text(data.articleCount);
            $("#link").text(data.linkCount);
            $("#attach").text(data.attachCount);
            $("#comment").text(data.commentCount);
            //最新文章列表
            var a="";
            var articles=data.articles;
            for(var i=0;i<articles.length;i++){
                a+="<li class='list-group-item'><span class='badge badge-primary' title='"+0+"条评论'></span>";
                a+="<a target='_blank' href='../article/"+articles[i].cid+"'>"+articles[i].title+"</a> </li>";
            }
            $("#article-list").append(a);
            //最新留言列表
            var c="";
            var comments=data.comments;
            if(comments.length==0){
                c+="<div class='alert alert-warning'>还没有收到留言.</div>";
            }else{
                c+="<ul class='list-group'>";
                for(var i=0;i<comments.length;i++){
                    c+="<li class='list-group-item'>";
                    if(comments[i].url != null){//若评论人有url则添加a标签，没有就不加
                        c+="<div><a href='"+comments[i].url+"' target='_blank'>"+comments[i].author+"</a></div>";
                    }else{
                        c+="<div>"+comments[i].author+"</div>";
                    }
                   c+= "于<block>"+timestamp2time(comments[i].created)+"<block/>：<a" +
                    "href=../../article/"+comments[i].cid+"#comments" +
                    "target='_blank'>"+comments[i].content+"</a></li>";
                }
                c+="</ul>";
            }
            $("#comment-list").append(c);
            //系统日志列表
            var l="";
            var logs=data.logs;
            for(var i=0;i<logs.length;i++){
                l+="<li class='list-group-item'>";
                l+="<span>"+timestamp2time(logs[i].created)+" "+logs[i].authorId+"=>"+logs[i].action+"</span></li>";
            }
            $("#logs").append(l);
        },
        error:function (XMLHttpRequest, textStatus, errorThrown) {
            // 状态码
            console.log(XMLHttpRequest.status);
            // 状态
            console.log(XMLHttpRequest.readyState);
            // 错误信息
            console.log(textStatus);
        }
    })
    //毫秒转日期
    function timestamp2time(timestamp){
        timestamp=timestamp*1000;
        var oDate = new Date(timestamp),
            oYear = oDate.getFullYear(),
            oMonth = oDate.getMonth()+1,
            oDay = oDate.getDate(),
            oHour = oDate.getHours(),
            oMin = oDate.getMinutes(),
            oSen = oDate.getSeconds(),
            oTime = oYear +'-'+ getzf(oMonth) +'-'+ getzf(oDay) +' '+ getzf(oHour) +':'+ getzf(oMin) +':'+getzf(oSen);//最后拼接时间
        return oTime;
    }
    //补0操作
    function getzf(num){
        if(parseInt(num) < 10){
            num = '0'+num;
        }
        return num;
    }
</script>
</body>
</html>