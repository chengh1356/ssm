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

</head>
<body>
<table id="hcctable" class="hovertable" width="100%">
</table>
<div id="w_h" class="easyui-window" title="" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:700px;height:400px;padding:5px;">
</div>
<script language="javascript">
    var xzid =  "${xzid}";
   //补办手续
    function cjchindex(){
        $("#hcctable").html("<tr><th>村名</th><th>处数</th><th>违法建筑面积(平方米)</th><th>违法占地面积(平方米)</th></tr>");
        $.ajax({
            type: "post",
            url: "/clwfcz/selectClwfBbsxCj/"+xzid,
            dataType: "json",
            success: function(data){
                var mydata = $.parseJSON(data);
                var cxCount = 0;//处数
                var wfzdmjCount = 0.0;//违法占地面积
                var wfjzmjCount = 0.0;//违法建筑面积
                var csCount = 0.0;//违法占地面积
                var str = "<tr><th>村名</th><th>宗数</th><th>违法建筑面积(平方米)</th><th>违法占地面积(平方米)</th></tr>";
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
                    str += "<tr><td><a href='javascript:openH(\""+mydata[i].cid+"\",\""+mydata[i].cname +"\");'>"+mydata[i].cname+"</a></td><td>"+mydata[i].total+"</td><td>"+
                    mydata[i].summj+"</td><td>"+mydata[i].sumzdmj+"</td></tr>";
                }
                str += "<tr><th>汇总</th><th>"+csCount+"</th><th>"+wfzdmjCount+"</th><th>"+wfjzmjCount+"</th></tr>";
                var htmlStr =  ReplaceAll(str,"undefined","");
                $("#hcctable").html(htmlStr);
            }
        });
    }
    function openH(cid,titlename){
        $('#w_h').window({
            title: titlename,
            closed: false,
            cache: false,
            top:150,
            minimizable:false,
            maximizable:false,
            collapsible:false,
            href:"hbbsxclwfIndex.action?cjclwfjzcchzb.cid="+cid+"&cjclwfjzcchzb.cname="+titlename,
            modal: true
        });
        $('#w_h').window("open");
//        window.open("hclwfIndex.action?cjclwfjzcchzb.cid="+cid);

    }
    //初始化
    $(function(){
        cjchindex();
    });
</script>
</body>
</html>
