<%--
  ~ Copyright (c) 2017. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  ~ Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
  ~ Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
  ~ Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
  ~ Vestibulum commodo. Ut rhoncus gravida arcu.
  --%>

<%--
  Created by IntelliJ IDEA.
  User: wmd
  Date: 2017/5/9
  Time: 20:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>

    <script src="/static/js/jquery-easyui-1.4.4/jquery.min.js"></script>
    <script src="/static/js/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
    <link href="/static/js/jquery-easyui-1.4.4/themes/default/easyui.css" rel="stylesheet">
    <link href="/static/js/jquery-easyui-1.4.4/themes/icon.css" rel="stylesheet" />
    <script src="/static/js/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
    <link href="/static/css/index.css" rel="stylesheet">
    <link href="/static/css/cindex.css" rel="stylesheet">
    <script src="/static/js/cindex.js"></script>
    <link href="/static/css/notice.css" rel="stylesheet"/>


    <script language="JavaScript">



        //请求并初始化notice
        function notice() {
            var id = "${noticeId}";
            $.ajax({
                type: "post",
                url: "${path}/notice/content",
                data: {id:id},
                dataType: "json",
                success:function(data){
                    var jsonData = $.parseJSON(data);
                    initHtml(jsonData);
                }
            })
        }


        //初始化html
        function initHtml(jsonData) {
            $(" title").html(jsonData.title);
            $(" .tzgg_tttle").html(jsonData.title);
            $(" .tzgg_author").html("作者: "+ jsonData.author);
            $(" .tzgg_time").html("发布时间: "+ jsonData.time);
            $(" .tzgg_right").eq(0).html(jsonData.author);
            $(" .tzgg_right").eq(1).html(jsonData.time);
            $(" #fj").hide();
            $(" .content").load("notice/content/html/"+noticeId+".html", function(){
                addFj();
            });
            $(" .tzgg_gg").eq(0).html(jsonData.title);
        }


        //附件下载
        function addFj(){
            $(" #content .uploadfile").each(function(){
                $(" #fj").show();
                var filename = $(this).attr("name");
                var filePath = $(this).val();
                var html = '<div class="fj" style="text-indent:2em; font-size: 16px; line-height: 200%; font-family: 仿宋_GB2312;"><a href="downloadFj.action?filename='+noticeId+"/";
                html += filename+'" style="font-size: 16px; line-height: 200%; font-family: 仿宋_GB2312;">';
                html += filename+'</a></div>';
                $(" #fj").after(html);
            });
        }

        $(function(){
            onchange_menu("m_tzgg");
            notice();
        });
        $.ajaxSetup ({
            cache: false //关闭AJAX相应的缓存
        });

    </script>

</head>

<body>

<jsp:include page="/public/chead" />

<div class="mycontent" style=" width: 67%; margin:0 auto;">
    <span class="tzgg_gg"></span>
    <div class="div_center" style="width: 100%;margin:0 auto;">
        <p  style="width: 100%;text-align: center"><h1 class="tzgg_tttle"></h1></p>
        <div class="detail_xltit"></div>
        <h5 class="tzgg_time"></h5>
        <h5 class="tzgg_author"></h5>
        <div class= "detail_xltit" style="margin: 0 auto 20px;">
        </div>

        <div id="content" class="content" style="margin: 0 auto">
        </div>

        <div id="tzgg_right_div" style="margin-top: 60px">
            <p class="tzgg_right">
            </p>
            <p class="tzgg_right">
            </p>
        </div>
        <br>
        <p id="fj" style="font-family:微软雅黑,Arial Narrow,HELVETICA; color:#999; font-weight:bold; border-bottom:solid 2px #f5f5f5; display: block;">附件下载:</p>
    </div>
</div>
<div style="font: 0px/0px sans-serif;clear: both;display: block"> </div>
<jsp:include page="/public/foot" />
</body>
</html>
