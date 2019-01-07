<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String path=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <meta name="renderer" content="webkit" />
    <link rel="shortcut icon" href="<%=path%>/static/user/img/favicon.icon" />
</head>
<body gtools_scp_screen_capture_injected="true">
	<header id="header" class="header bg-white animated">
    <div class="navbar-container">
        <a href="<%=path %>/" class="navbar-logo">
            <img src="<%=path %>/static/user/img/logo.png" alt="logo">
        </a>
        <div class="navbar-menu">
            <a href="<%=path %>/archives">归档</a>
            <a href="<%=path %>/links">友链</a>
            <a href="<%=path %>/about">关于</a>
        </div>
        <div class="navbar-search">
            <span class="icon-search"></span>
            <form role="search" onsubmit="return false;">
                <span class="search-box">
                    <input type="text" id="search-inp" class="input" placeholder="搜索..." autocomplete="off" maxlength="30">
                </span>
            </form>
        </div>
        <div class="navbar-mobile-menu" onclick="">
        <span class="icon-menu cross"><span class="middle"></span></span>
            <ul>
                <li><a href="<%=path %>/archives">归档</a></li>
                <li><a href="<%=path %>/links">友链</a></li>
                <li><a href="<%=path %>/about">关于</a></li>
            </ul></div>
    </div>
</header>
<script type="text/javascript" src="<%=path%>/static/user/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$('#search-inp').keydown(function(e){
	if(e.keyCode==13){
		var searchContent=$(this).val();
		window.location.href="<%=path %>/search?word="+searchContent;
	}
})
//判断滚动条方向
var scrollBefore = $(window).scrollTop();
$(window).scroll(function() {
    var scrollAfter=$(window).scrollTop();
    if (scrollBefore < scrollAfter) {
        var current=$('#header').css('top');
        if(current!=0)
            startMover(-80);
    }
    else if (scrollBefore > scrollAfter){
        var current=$('#header').css('top');
        if(current!=-80)
            startMover(0);
    }
    scrollBefore = scrollAfter;
});
//移动效果
var timer = null;
function startMover(a){//速度和目标值
    clearInterval(timer);//执行当前动画同时清除之前的动画
    var odiv = document.getElementById('header');
    timer = setInterval(function(){
        var speed = (a-odiv.offsetTop)/5;//缓冲动画的速度参数变化值
        //如果速度是大于0，说明是向xia走，那么就向上取整
        speed = speed>0?Math.ceil(speed):Math.floor(speed);
        //Math.floor();向下取整
        if(odiv.offsetTop == a){
            clearInterval(timer);
        } else{
            odiv.style.top = odiv.offsetTop+speed+'px';
        }
    },20);
}
</script>
</body>
</html>