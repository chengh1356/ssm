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

<script src="../js/jquery-easyui-1.4.4/jquery.min.js"></script>
<script src="../js/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
<link href="../js/jquery-easyui-1.4.4/themes/default/easyui.css" rel="stylesheet">
<link href="../js/jquery-easyui-1.4.4/themes/icon.css" rel="stylesheet" />
<script src="../js/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
    <link href="../css/index.css" rel="stylesheet">
    <link href="../css/cindex.css" rel="stylesheet">
<script src="../js/cindex.js"></script>
    <script src="../js/base-loading.js"></script>
</head>
<body>
<table id="hcctable" class="hovertable" width="100%">
</table>
<div id="w_h" class="easyui-window" title="" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:700px;height:400px;padding:5px;">
</div>
<script language="javascript">
    var xzid =  "${requestScope.xzid}";
    //拆除
    function cjchindex(){
        $("#hcctable").html("<tr><th>村名</th><th>处数</th><th>拆除建筑面积(平方米)</th><th>拆除占地面积(平方米)</th></tr>");
        $.ajax({
            type: "post",
            url: "findAllCjffyhdzmshzb.action?viewyhdzfmcidEntity.xzid="+xzid,
            dataType: "json",
            success: function(data){
                var mydata = eval(data);
                var cxCount = 0;//处数
                var ccmj=0;//拆除面积
                var zdmj = 0;//占地面积
                var wfzdmjCount = 0.0;//违法建筑面积
                var wfjzmjCount = 0.0;//违法占地面积
                var str = "<tr><th>村名</th><th>处数</th><th>拆除建筑面积(平方米)</th><th>拆除占地面积(平方米)</th></tr>";
                for (var i = 0;i<mydata.length; i++){
                    if(mydata[i].total){
                        cxCount += mydata[i].total;
                    }
                    if(mydata[i].summj){
                        wfjzmjCount += mydata[i].summj;
                        ccmj=parseFloat(mydata[i].summj).toFixed(2);
                    }else{ccmj='';}
                    if(mydata[i].sumzdmj){
                        wfzdmjCount += mydata[i].sumzdmj;
                        zdmj=parseFloat(mydata[i].sumzdmj).toFixed(2);
                    }else{zdmj='';}


                    str += "<tr><td><a href='javascript:openH(\""+mydata[i].cid+"\",\""+mydata[i].cname +"\");'>"+mydata[i].cname+"</a></td><td>"+mydata[i].total+"</td><td>"+
                    ccmj+"</td><td>"+zdmj+"</td></tr>"
                }
                str += "<tr><th>汇总</th><th>"+cxCount+"</th><th>"+parseFloat(wfjzmjCount).toFixed(2)+"</th><th>"+parseFloat(wfzdmjCount).toFixed(2)+"</th></tr>";
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
            href:"hffyhdzmsIndex.action?viewyhdzfmcidEntity.cid="+cid,
            modal: true
        });
        $('#w_h').window("open");
    }
    //初始化
    $(function(){
        cjchindex();
    });
</script>
</body>
</html>
