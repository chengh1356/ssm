<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  ~ Copyright (c) 2017. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  ~ Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
  ~ Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
  ~ Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
  ~ Vestibulum commodo. Ut rhoncus gravida arcu.
  --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新增违法建筑处置</title>

    <script src="/static/js/jquery-easyui-1.4.4/jquery.min.js"></script>
    <script src="/static/js/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
    <link href="/static/js/jquery-easyui-1.4.4/themes/default/easyui.css" rel="stylesheet">
    <link href="/static/js/jquery-easyui-1.4.4/themes/icon.css" rel="stylesheet"/>
    <script src="/static/js/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
    <link href="/static/css/index.css" rel="stylesheet">
    <link href="/static/css/cindex.css" rel="stylesheet">
    <script src="/static/js/cindex.js"></script>
    <script src="/static/js/base-loading.js"></script>

<script language="javascript">
    var menu_id = "${param.menuid}";

    //拆除
    function chindex(){
        $("#cctable").html("");
        $.ajax({
            type: "post",
            url: "/xzwfcc/selectAllXzwfccXz",//查询所有的乡镇的新增违法建筑拆除汇总信息
            dataType: "json",
            success: function(data){//返回数据
                var mydata = $.parseJSON(data);//将返回的json字符串转换成json数据格式
                var cxCount = 0;//处数
                var wfzdmjCount = 0.0;//违法建筑面积
                var wfjzmjCount = 0.0;//违法占地面积
                var str = "<tr><th>乡镇名称</th><th>宗数</th><th>违法建筑面积(平方米)</th><th>违法占地面积(平方米)</th></tr>";
                for (var i = 0;i < mydata.length; i++){
                    if(mydata[i].zs){//累计计算违法处数
                        cxCount += mydata[i].zs;
                    }
                    if(mydata[i].zdmj){//累计计算违法占地面积
                        wfzdmjCount += mydata[i].zdmj;
                    }
                    if(mydata[i].jzmj){//累计计算违法建筑面积
                        wfjzmjCount += mydata[i].jzmj;
                    }
                    str += "<tr><td><a href='javascript:openCJ(\""+mydata[i].xzid+"\",\""+mydata[i].xzname +"\");'>"+mydata[i].xzname+"</a></td><td>"+mydata[i].zs+"</td><td>"+
                    mydata[i].jzmj+"</td><td>"+mydata[i].zdmj+"</td></tr>"
                }
                str += "<tr><th>汇总</th><th>"+cxCount+"</th><th>"+wfjzmjCount+"</th><th>"+wfzdmjCount+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#cctable").html(htmlStr);
                var frontXzid = sessionStorage.getItem("xzid");
                var frontXzname = sessionStorage.getItem("xzname");
                var frontType = sessionStorage.getItem("type");
                if (frontXzid != "" && frontXzname != "" && frontType == 'xzcc') {
                    var str = "<a href='javascript:openCJ(\""+frontXzid+"\",\""+frontXzname +"\");'"+'id="index2Xzcc">"'+"</a>";
                    $(' #cctable').append(str);
                    document.getElementById('index2Xzcc').click();
                    $(' #index2Xzcc').remove();
                    sessionStorage.removeItem("xzid");
                    sessionStorage.removeItem("xzname");
                    sessionStorage.removeItem("type");
                }
            }
        });
    }

    function openCJ(xzid,titlename){//对应点击超链接

        $('#w_cj').window({
            title: titlename,
            closed: false,
            cache: false,
            top:150,
            minimizable:false,
            maximizable:false,
            collapsible:false,
            href:"cjxzwfIndex.action?xzid="+xzid,
            modal: true
        });
        $('#w_cj').window("open");

    }

    //初始化
    $(function(){//页面载入时首先走这个方法
        onchange_menu(menu_id);
        chindex();
    });
</script>

</head>

<body>
<jsp:include page="/public/chead" />
<div class="mycontent">
    <div class="div_left">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td id="menu_cc" class="menu_select" onclick="onselect_menu(this);chindex();"><span>新增拆除</span></td>
            </tr>
        </table>
    </div>
    <div class="div_center">
        <div style="margin-left:10px;">
            <table id="cctable" class="hovertable" width="100%">
            </table>
        </div>
    </div>
</div>
<div id="w_cj" class="easyui-window" title="" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:700px;height:400px;padding:5px;">
</div>
<jsp:include page="/public/foot" />
</div>
</body>
</html>
