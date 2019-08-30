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
<title>存量违法建筑处置</title>

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
    var frontXzid = sessionStorage.getItem("xzid");
    var frontXzname = sessionStorage.getItem("xzname");
    var frontType = sessionStorage.getItem("type");

    //拆除
    function chindex(){
        $("#cctable").html("");
        $.ajax({
            type: "post",
            url: "/clwfcz/selectAllClwfczCc",
            dataType: "json",
            success: function(data){
                if (frontXzid != "" && frontXzname != "" && frontType == 'ycsy') {
                    obj = new Object();
                    obj.id = "menu_ycsy";
                    onselect_menu(obj);
                    ycsyindex();
                }
                var mydata = $.parseJSON(data);
                var cxCount = 0;//处数
                var wfzdmjCount = 0.0;//违法占地面积
                var wfjzmjCount = 0.0;//违法建筑面积
                var str = "<tr><th>乡镇名称</th><th>宗数</th><th>违法建筑面积(平方米)</th><th>违法占地面积(平方米)</th></tr>";
                for (var i = 0;i<mydata.length; i++){
                    if(mydata[i].total){
                        cxCount += mydata[i].total;
                    }
                    if(mydata[i].sumzdmj){
                        wfzdmjCount += mydata[i].sumzdmj;
                    }
                    if(mydata[i].summj){
                        wfjzmjCount += mydata[i].summj;
                    }
                    str += "<tr><td><a href='javascript:openCJ(\""+mydata[i].xzid+"\",\""+mydata[i].xzname +"\");'>"+mydata[i].xzname+"</a></td><td>"+mydata[i].total+"</td><td>"+
                    mydata[i].summj+"</td><td>"+mydata[i].sumzdmj+"</td></tr>";
                }
                str += "<tr><th>汇总</th><th>"+cxCount+"</th><th>"+wfjzmjCount+"</th><th>"+wfzdmjCount+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#cctable").html(htmlStr);
                if (frontXzid != "" && frontXzname != "" && frontType == 'clcc') {
                    var str = "<a href='javascript:openCJ(\""+frontXzid+"\",\""+frontXzname +"\");'"+'id="index2Xzcc">"'+"</a>";
                    $(' #cctable').append(str);
                    document.getElementById('index2Xzcc').click();
                    $(' #index2Xzcc').remove();
                    sessionStorage.removeItem("xzid");
                    sessionStorage.removeItem("xzname");
                    sessionStorage.removeItem("type");
                    frontXzid = "";
                    frontType = "";
                    frontXzname = "";
                }
            }
        });
    }
    function openCJ(xzid,titlename){
        $('#w_cj').window({
            title: titlename+"-拆除",
            closed: false,
            cache: false,
            top:150,
            minimizable:false,
            maximizable:false,
            collapsible:false,
            href:"/clwfcz/clwfccCjIndex/"+xzid,
            modal: true
        });
        $('#w_cj').window("open");

    }

    //补办手续
    function bbsxindex(){
        $("#cctable").html("");
        $.ajax({
            type: "post",
            url: "/clwfcz/selectAllClwfczBbsx",
            dataType: "json",
            success: function(data){
                var mydata = eval(data);
                var wfzdmjCount = 0.0;//违法占地面积
                var wfjzmjCount = 0.0;//违法建筑面积
                var csCount = 0.0;//违法占地面积
                var str = "<tr><th>乡镇名称</th><th>宗数</th><th>违法建筑面积(平方米)</th><th>违法占地面积(平方米)</th></tr>";
                for (var i = 0;i<mydata.length; i++){
                    if(mydata[i].total){
                        csCount += mydata[i].total;
                    }
                    if(mydata[i].sumzdmj){
                        wfzdmjCount += mydata[i].sumzdmj;
                    }
                    if(mydata[i].summj){
                        wfjzmjCount += mydata[i].summj;
                    }
                    str += "<tr><td><a href='javascript:openBbsxCJ(\""+mydata[i].xzid+"\",\""+mydata[i].xzname +"\");'>"+mydata[i].xzname+"</a></td><td>"+mydata[i].total+"</td><td>"+
                    mydata[i].summj+"</td><td>"+mydata[i].sumzdmj+"</td></tr>"
                }
                str += "<tr><th>汇总</th><th>"+csCount+"</th><th>"+wfjzmjCount+"</th><th>"+wfzdmjCount+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#cctable").html(htmlStr);
            }
        });
    }

    function openBbsxCJ(xzid,titlename){
        $('#w_cj').window({
            title: titlename+"-补办手续",
            closed: false,
            cache: false,
            top:150,
            minimizable:false,
            maximizable:false,
            collapsible:false,
            href:"/clwfcz/clwfbbsxCjIndex/"+xzid,
            modal: true
        });
        $('#w_cj').window("open");

    }

    //罚没
    function fmindex(){
        $("#cctable").html("");
        $.ajax({
            type: "post",
            url: "/clwfcz/selectAllClwfczFm",
            dataType: "json",
            success: function(data){
                var mydata = eval(data);
                var wfzdmjCount = 0.0;//违法占地面积
                var wfjzmjCount = 0.0;//违法建筑面积
                var csCount = 0.0;//违法占地面积
                var str = "<tr><th>乡镇名称</th><th>宗数</th><th>违法建筑面积(平方米)</th><th>违法占地面积(平方米)</th></tr>";
                for (var i = 0;i<mydata.length; i++){
                    if(mydata[i].zs){
                        csCount += mydata[i].zs;
                    }
                    if(mydata[i].zdmj){
                        wfzdmjCount += mydata[i].zdmj;
                    }
                    if(mydata[i].jzmj){
                        wfjzmjCount += mydata[i].jzmj;
                    }
                    str += "<tr><td><a href='javascript:openFmCJ(\""+mydata[i].xzid+"\",\""+mydata[i].xzname +"\");'>"+mydata[i].xzname+"</a></td><td>"+mydata[i].zs+"</td><td>"+
                    mydata[i].jzmj+"</td><td>"+mydata[i].zdmj+"</td></tr>"
                }
                str += "<tr><th>汇总</th><th>"+csCount+"</th><th>"+wfjzmjCount+"</th><th>"+wfzdmjCount+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#cctable").html(htmlStr);
            }
        });
    }

    function openFmCJ(xzid,titlename){
        $('#w_cj').window({
            title: titlename+"-罚没",
            closed: false,
            cache: false,
            top:150,
            minimizable:false,
            maximizable:false,
            collapsible:false,
            href:"/clwfcz/clwffmCjIndex/"+xzid,
            modal: true
        });
        $('#w_cj').window("open");

    }

    //有偿使用
    function ycsyindex(){
        $("#cctable").html("");
        $.ajax({
            type: "post",
            url: "/clwfcz/selectAllClwfczYcsy",
            dataType: "json",
            success: function(data){
                var mydata = $.parseJSON(data);
                var wfzdmjCount = 0.0;//违法占地面积
                var wfjzmjCount = 0.0;//违法建筑面积
                var csCount = 0;
                var jnfyCount = 0;//收缴总额
                var str = "<tr><th>乡镇名称</th><th>宗数</th><th>违法建筑面积(平方米)</th><th>违法占地面积(平方米)</th><th>收缴总额(元)</th></tr>";
                for (var i = 0;i<mydata.length; i++){
                    if(mydata[i].zs){
                        csCount += mydata[i].zs;
                    }
                    if(mydata[i].zdmj){
                        wfzdmjCount += mydata[i].zdmj;
                    }
                    if(mydata[i].jzmj){
                        wfjzmjCount += mydata[i].jzmj;
                    }
                    if(mydata[i].ycsyje){
                        jnfyCount += mydata[i].ycsyje;
                    }
                    str += "<tr><td><a href='javascript:openYcsyCJ(\""+mydata[i].xzid+"\",\""+mydata[i].xzname +"\");'>"+mydata[i].xzname+"</a></td><td>"+mydata[i].zs+"</td><td>"+
                    mydata[i].jzmj+"</td><td>"+mydata[i].zdmj+"</td><td>"+mydata[i].ycsyje+"</td></tr>"
                }
                wfjzmjCount = wfjzmjCount.toFixed(2);
                str += "<tr><th>汇总</th><th>"+csCount+"</th><th>"+wfjzmjCount+"</th><th>"+wfzdmjCount+"</th><th>"+jnfyCount+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#cctable").html(htmlStr);
                if (frontXzid != "" && frontXzname != "" && frontType == 'ycsy') {
                    var str = "<a href='javascript:openYcsyCJ(\""+frontXzid+"\",\""+frontXzname +"\");'"+'id="index2Xzcc">"'+"</a>";
                    $(' #cctable').append(str);
                    document.getElementById('index2Xzcc').click();
                    $(' #index2Xzcc').remove();
                    sessionStorage.removeItem("xzid");
                    sessionStorage.removeItem("xzname");
                    sessionStorage.removeItem("type");
                    frontXzid = "";
                    frontType = "";
                    frontXzname = "";
                }
            }
        });
    }

    function openYcsyCJ(xzid,titlename){
        $('#w_cj').window({
            title: titlename+"-有偿使用",
            closed: false,
            cache: false,
            top:150,
            minimizable:false,
            maximizable:false,
            collapsible:false,
            href:"/clwfcz/clwfycsyCjIndex/"+xzid,
            modal: true
        });
        $('#w_cj').window("open");

    }

    //保护
    function bhindex(){
        $("#cctable").html("");
        $.ajax({
            type: "post",
            url: "/clwfcz/selectAllClwfczBh",
            dataType: "json",
            success: function(data){
                var mydata = eval(data);
                var wfzdmjCount = 0.0;//违法占地面积
                var wfjzmjCount = 0.0;//违法建筑面积
                var csCount = 0;
                var str = "<tr><th>乡镇名称</th><th>宗数</th><th>违法建筑面积(平方米)</th><th>违法占地面积(平方米)</th></tr>";
                for (var i = 0;i<mydata.length; i++){
                    if(mydata[i].total){
                        csCount += mydata[i].total;
                    }
                    if(mydata[i].sumzdmj){
                        wfzdmjCount += mydata[i].sumzdmj;
                    }
                    if(mydata[i].summj){
                        wfjzmjCount += mydata[i].summj;
                    }
                    str += "<tr><td><a href='javascript:openBhCJ(\""+mydata[i].xzid+"\",\""+mydata[i].xzname +"\");'>"+mydata[i].xzname+"</a></td><td>"+mydata[i].total+"</td><td>"+
                    mydata[i].summj+"</td><td>"+mydata[i].sumzdmj+"</td></tr>"
                }
                str += "<tr><th>汇总</th><th>"+csCount+"</th><th>"+wfjzmjCount+"</th><th>"+wfzdmjCount+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#cctable").html(htmlStr);
            }
        });
    }

    function openBhCJ(xzid,titlename){
        $('#w_cj').window({
            title: titlename+"-保护",
            closed: false,
            cache: false,
            top:150,
            minimizable:false,
            maximizable:false,
            collapsible:false,
            href:"/clwfcz/clwfbhCjIndex/"+xzid,
            modal: true
        });
        $('#w_cj').window("open");

    }

    //暂缓拆除
    function zhccindex(){
        $("#cctable").html("");
        $.ajax({
            type: "post",
            url: "/clwfcz/selectAllClwfczZhcc",
            dataType: "json",
            success: function(data){
                var mydata = eval(data);
                var wfzdmjCount = 0.0;//违法占地面积
                var wfjzmjCount = 0.0;//违法建筑面积
                var csCount = 0;
                var str = "<tr><th>乡镇名称</th><th>宗数</th><th>违法建筑面积(平方米)</th><th>违法占地面积(平方米)</th></tr>";
                for (var i = 0;i<mydata.length; i++){
                    if(mydata[i].total){
                        csCount += mydata[i].total;
                    }
                    if(mydata[i].sumzdmj){
                        wfzdmjCount += mydata[i].sumzdmj;
                    }
                    if(mydata[i].summj){
                        wfjzmjCount += mydata[i].summj;
                    }
                    str += "<tr><td><a href='javascript:openZhccCJ(\""+mydata[i].xzid+"\",\""+mydata[i].xzname +"\");'>"+mydata[i].xzname+"</a></td><td>"+mydata[i].total+"</td><td>"+
                    mydata[i].summj+"</td><td>"+mydata[i].sumzdmj+"</td></tr>"
                }
                str += "<tr><th>汇总</th><th>"+csCount+"</th><th>"+wfjzmjCount+"</th><th>"+wfzdmjCount+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#cctable").html(htmlStr);
            }
        });
    }

    function openZhccCJ(xzid,titlename){
        $('#w_cj').window({
            title: titlename+"-暂缓拆除",
            closed: false,
            cache: false,
            top:150,
            minimizable:false,
            maximizable:false,
            collapsible:false,
            href:"/clwfcz/clwfzhccCjIndex/"+xzid,
            modal: true
        });
        $('#w_cj').window("open");

    }

    //初始化
    $(function(){
        //var obj = document.getElementById(menu_id);
        onchange_menu(menu_id);
        chindex();
    });
</script>

</head>

<body>
<input type="hidden" value="${xzid}" id="xzid">
<input type="hidden" value="${xzname}" id="xzname">
<jsp:include page="/public/chead" />
<div class="mycontent">
    <div class="div_left">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td id="menu_cc" class="menu_select" onclick="onselect_menu(this);chindex();"><span>拆除</span></td>
            </tr>
            <tr><td><div class="dashedli"></div></td></tr>
            <tr>
                <td id="menu_bbsx" class="menu_noselect" onclick="onselect_menu(this);bbsxindex();"><span>补办手续</span></td>
            </tr>
            <tr><td><div class="dashedli"></div></td></tr>
            <tr>
                <td id="menu_fm" class="menu_noselect" onclick="onselect_menu(this);fmindex();"><span>罚没</span></td>
            </tr>
            <tr><td><div class="dashedli"></div></td></tr>
            <tr>
                <td id="menu_ycsy" class="menu_noselect" onclick="onselect_menu(this);ycsyindex();"><span>有偿使用</span></td>
            </tr>
            <tr><td><div class="dashedli"></div></td></tr>
            <tr>
                <td id="menu_bh" class="menu_noselect" onclick="onselect_menu(this);bhindex();"><span>保护</span></td>
            </tr>
            <tr><td><div class="dashedli"></div></td></tr>
            <tr>
                <td id="menu_zhcc" class="menu_noselect" onclick="onselect_menu(this);zhccindex();"><span>暂缓拆除</span></td>
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
