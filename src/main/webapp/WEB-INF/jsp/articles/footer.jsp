<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String path=request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<footer class="footer">
        <div class="footer-social"></div>
        <div class="footer-meta">
            <div class="footer-container">
                <div class="meta-item meta-copyright">
                    <div class="meta-copyright-info">
                        <div class="info-text">
                            <a class="info-logo">
                                <img src="<%=path %>/static/user/img/logo.png" alt="logo">
                            </a>
                            <br>
                            <p>©版权所有 <a href="">BPM</a> 保留一切权利</p>
                            <p class="beianhao"><a href="http://www.miitbeian.gov.cn/"></a></p>
                            <br>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
<script type="text/javascript" src="<%=path%>/static/user/js/jquery-3.3.1.min.js"></script>
<script type="">
    $.ajax({
        type:'GET',
        url:'https://www.zhuyao.site/beianhao',
        dataType:'json',
        success:function(data){
            if(data!=null)
                $(".beianhao a").text(data['beianhao']);
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){
            // 状态码
            console.log(XMLHttpRequest.status);
            // 状态
            console.log(XMLHttpRequest.readyState);
            // 错误信息
            console.log(textStatus);
        }

    })
</script>
</body>
</html>