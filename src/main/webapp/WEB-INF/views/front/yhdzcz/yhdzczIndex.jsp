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
<title>非法一户多宅处置</title>

<script src="/static/js/jquery-easyui-1.4.4/jquery.min.js"></script>
<script src="/static/js/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
<link href="/static/js/jquery-easyui-1.4.4/themes/default/easyui.css" rel="stylesheet">
<link href="/static/js/jquery-easyui-1.4.4/themes/icon.css" rel="stylesheet" />
<script src="/static/js/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
<link href="/static/css/index.css" rel="stylesheet">
<link href="/static/css/cindex.css" rel="stylesheet">
<script src="/static/js/cindex.js"></script>
    <script src="/static/js/base-loading.js"></script>
<script language="javascript">
    var menu_id = "${param.menuid}";

    <!--非法一户多宅拆除-->
    function chChindex(){
        $("#cctable").html("");
        $.ajax({
            type: "post",
            url: "/yhdzcz/selectAllYhdzccXz",//查询所有的乡镇的新增违法建筑拆除汇总信息
            dataType: "json",
            success: function(data){//返回数据
                var mydata = $.parseJSON(data);//将返回的json字符串转换成json数据格式
                var cxCount = 0;//处数
                var wfzdmjCount = 0.0;//违法建筑面积
                var wfjzmjCount = 0.0;//违法占地面积
                var str = "<tr><th>乡镇名称</th><th>处数</th><th>违法建筑面积(平方米)</th><th>违法占地面积(平方米)</th></tr>";
                for (var i = 0;i < mydata.length; i++){
                    if(mydata[i].total){//累计计算违法处数
                        cxCount += mydata[i].total;
                    }
                    if(mydata[i].summj){//累计计算违法建筑面积
                        wfjzmjCount += mydata[i].summj;
                    }
                    if(mydata[i].sumzdmj){//累计计算违法占地面积
                        wfzdmjCount += mydata[i].sumzdmj;
                    }
                    str += "<tr><td><a href='javascript:openCJ_cc(\""+mydata[i].xzid+"\",\""+mydata[i].xzname +"\");'>"+mydata[i].xzname+"</a></td><td>"+mydata[i].total+"</td><td>"+
                    mydata[i].summj+"</td><td>"+mydata[i].sumzdmj+"</td></tr>"
                }
                str += "<tr><th>汇总</th><th>"+cxCount+"</th><th>"+wfjzmjCount+"</th><th>"+wfzdmjCount+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#cctable").html(htmlStr);
            }
        });
    }
    <!--打开村级非法一户多宅拆除-->
    function openCJ_cc(xzid,titlename){//对应点击超链接

        $('#w_cj').window({
            title: titlename+"-拆除",
            closed: false,
            cache: false,
            top:150,
            minimizable:false,
            maximizable:false,
            collapsible:false,
            href:"cjffyhdzIndex.action?yhdzclztEntity.xzid="+xzid,
            modal: true
        });
        $('#w_cj').window("open");

    }

    <!--非法一户多宅暂缓拆除-->
    function zhChindex(){
        $("#cctable").html("");
        $.ajax({
            type: "post",
            url: "/yhdzcz/selectAllYhdzzhccXz",//查询所有的乡镇的新增违法建筑拆除汇总信息
            dataType: "json",
            success: function(data){//返回数据
                var mydata = $.parseJSON(data);//将返回的json字符串转换成json数据格式
                var cxCount = 0;//处数
                var wfzdmjCount = 0.0;//违法建筑面积
                var wfjzmjCount = 0.0;//违法占地面积
                var str = "<tr><th>乡镇名称</th><th>处数</th><th>违法建筑面积(平方米)</th><th>违法占地面积(平方米)</th></tr>";
                for (var i = 0;i < mydata.length; i++){
                    if(mydata[i].total){//累计计算违法处数
                        cxCount += mydata[i].total;
                    }
                    if(mydata[i].summj){//累计计算违法建筑面积
                        wfjzmjCount += mydata[i].summj;
                    }
                    if(mydata[i].sumzdmj){//累计计算违法占地面积
                        wfzdmjCount += mydata[i].sumzdmj;
                    }
                    str += "<tr><td><a href='javascript:openCJ_zh(\""+mydata[i].xzid+"\",\""+mydata[i].xzname +"\");'>"+mydata[i].xzname+"</a></td><td>"+mydata[i].total+"</td><td>"+
                    mydata[i].summj+"</td><td>"+mydata[i].sumzdmj+"</td></tr>"
                }
                str += "<tr><th>汇总</th><th>"+cxCount+"</th><th>"+wfjzmjCount+"</th><th>"+wfzdmjCount+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#cctable").html(htmlStr);
            }
        });
    }

    <!--打开村级非法一户多宅暂缓拆除-->
    function openCJ_zh(xzid,titlename){//对应点击超链接
        $('#w_cj').window({
            title: titlename+"-暂缓拆除",
            closed: false,
            cache: false,
            top:150,
            minimizable:false,
            maximizable:false,
            collapsible:false,
            href:"cjffyhdzzhIndex.action?yhdzclztEntity.xzid="+xzid,
            modal: true
        });
        $('#w_cj').window("open");

    }

    <!--非法一户多宅没收-->
    function msChindex(){
        $("#cctable").html("");
        $.ajax({
            type: "post",
            url: "/yhdzcz/selectAllYhdzfmXz",//查询所有的乡镇的新增违法建筑拆除汇总信息
            dataType: "json",
            success: function(data){//返回数据
                var mydata = $.parseJSON(data);//将返回的json字符串转换成json数据格式
                var cxCount = 0;//处数
                var ccmj=0;//拆除面积
                var zdmj=0;//占地面积
                var wfzdmjCount = 0.0;//违法建筑面积
                var wfjzmjCount = 0.0;//违法占地面积
                var str = "<tr><th>乡镇名称</th><th>处数</th><th>违法建筑面积(平方米)</th><th>违法占地面积(平方米)</th></tr>";
                for (var i = 0;i < mydata.length; i++){
                    if(mydata[i].total){//累计计算违法处数
                        cxCount += mydata[i].total;
                    }
                    if(mydata[i].summj){//累计计算违法建筑面积
                        wfjzmjCount += mydata[i].summj;
                        ccmj=parseFloat(mydata[i].summj).toFixed(2);
                    }else{ccmj='';}
                    if(mydata[i].sumzdmj){//累计计算违法占地面积
                        wfzdmjCount += mydata[i].sumzdmj;
                        zdmj=parseFloat(mydata[i].sumzdmj).toFixed(2);
                    }else{zdmj='';}
                    str += "<tr><td><a href='javascript:openCJ_ms(\""+mydata[i].xzid+"\",\""+mydata[i].xzname +"\");'>"+mydata[i].xzname+"</a></td><td>"+mydata[i].total+"</td><td>"+
                    ccmj+"</td><td>"+zdmj+"</td</tr>"
                }
                str += "<tr><th>汇总</th><th>"+cxCount+"</th><th>"+parseFloat(wfjzmjCount).toFixed(2)+"</th><th>"+parseFloat(wfzdmjCount).toFixed(2)+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#cctable").html(htmlStr);
            }
        });
    }

    <!--打开村级非法一户多宅没收-->
    function openCJ_ms(xzid,titlename){//对应点击超链接

        $('#w_cj').window({
            title: titlename+"-罚没",
            closed: false,
            cache: false,
            top:150,
            minimizable:false,
            maximizable:false,
            collapsible:false,
            href:"cjffyhdzmsIndex.action?viewyhdzfmcidEntity.xzid="+xzid,
            modal: true
        });
        $('#w_cj').window("open");

    }





    //初始化
    $(function(){//页面载入时首先走这个方法
        onchange_menu(menu_id);
        chChindex();
    });
</script>

</head>

<body>
<jsp:include page="/public/chead" />
<div class="mycontent">
    <div class="div_left">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td id="menu_cc" class="menu_select" onclick="onselect_menu(this);chChindex();"><span>拆除</span></td>
            </tr>
            <tr><td><div class="dashedli"></div></td></tr>
            <tr>
                <td id="menu_bbsx" class="menu_noselect" onclick="onselect_menu(this);zhChindex();"><span>暂缓拆除</span></td>
            </tr>
            <tr><td><div class="dashedli"></div></td></tr>
            <tr>
                <td id="menu_fm" class="menu_noselect" onclick="onselect_menu(this);msChindex();"><span>罚没</span></td>
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
