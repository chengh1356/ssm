<%--
  ~ Copyright (c) 2017. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  ~ Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
  ~ Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
  ~ Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
  ~ Vestibulum commodo. Ut rhoncus gravida arcu.
  --%>

<%--
  Created by IntelliJ IDEA.
  User: sun
  Date: 2017/5/4
  Time: 9:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path2 = request.getContextPath();
// 获得本项目的地址(例如: http://localhost:8080/MyApp/)赋值给basePath变量
    String basePath2 = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path2+"/";

%>
<html>
<head>
    <title></title>
</head>
<body>
<div class="main">
    <div class="webTop">
        <div class="corpTitle">
            <p><font face="微软雅黑, Microsoft YaHei"><b><font style="color: rgb(2, 178, 181);" color="#02b2b5">杭州市临安区防违控违管理</font> <font style="color: rgb(204, 204, 204);" color="#cccccc">云平台</font></b></font></p>
        </div>
    </div>
    <div class="nav">
        <ul>
            <li id="m_home" class="selectli">　　首页　　</li>
            <li id="m_tzgg" class="noneli" onclick="openNotice(this);">&nbsp;通知公告&nbsp;</li>
            <li id="m_clwfjzcz" class="noneli" onclick="open1(this);">存量违法建筑处置</li>
            <li id="m_xzwfjzcc" class="noneli" onclick="open2(this);">新增违法建筑拆除</li>
            <li id="m_ffyhdzcz"class="noneli" onclick="open3(this);">一户多宅处置</li>
            <li id="m_chtdly" class="noneli" onclick="open4(this);">拆后土地利用</li>
            <li id="m_nmjfbz" class="noneli" onclick="open5(this);">&nbsp;农民建房&nbsp;</li>
            <li id="m_xfjb" class="noneli" onclick="open6(this);">&nbsp;信访交办&nbsp;</li>
            <li id="m_login" class="noneli" onclick="javascript:window.location.href='login.jsp?_bank'">&nbsp;登录&nbsp;</li>
        </ul>
    </div>
</div>
</body>
</html>
